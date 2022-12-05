#include "NNGeneratorSvc/NNGeneratorSvc.hh"
#include <string>
#include <unistd.h>
#include <stdio.h>

#include "GaudiKernel/MsgStream.h"
#include "GaudiKernel/Kernel.h"
#include "GaudiKernel/IInterface.h"
#include "GaudiKernel/StatusCode.h"
#include "GaudiKernel/SvcFactory.h"

#include "GaudiKernel/IIncidentSvc.h"
#include "GaudiKernel/Incident.h"
#include "GaudiKernel/IIncidentListener.h"

#include "GaudiKernel/ISvcLocator.h"
#include "GaudiKernel/Bootstrap.h"

#include "Identifier/EmcID.h"
#include "G4ThreeVector.hh"

#include <math.h>

#include "EmcRecGeoSvc/EmcRecGeoSvc.h"


#include "/junofs/users/yuansc/bes3_emc/code/NNPred/NNPred.h"



NNGeneratorSvc::NNGeneratorSvc(const std::string& name, ISvcLocator* svcloc): Service (name, svcloc){
    declareProperty("UseNN", m_use_nn = false);
    declareProperty("NNModel1", m_model_1 = "");
    declareProperty("NNModel2", m_model_2 = "");
    declareProperty("TargetParticle", m_target_particle = "");
    declareProperty("UseNN", m_use_nn = false);
    declareProperty("region", m_region = 0);

    // load model
    if (
        m_use_nn &&
        (access(m_model_1.c_str(), F_OK)) &&
        (access(m_model_2.c_str(), F_OK))
    ){
        m_nnpred = new NNPred(m_model_1.c_str(), m_model_2.c_str(), m_region);
    }

}

NNGeneratorSvc::~NNGeneratorSvc(){}

void NNGeneratorSvc::reset(){
    m_emc_hit_col.clear();
    return;
}

StatusCode NNGeneratorSvc::queryInterface(const InterfaceID& riid, void** ppvInterface){
  if( IID_INNGeneratorSvc.versionMatch(riid) ){
    *ppvInterface = static_cast<INNGeneratorSvc*> (this);
  } else{
    return Service::queryInterface(riid, ppvInterface);
  }
  return StatusCode::SUCCESS;
}

StatusCode NNGeneratorSvc::initialize(){
  MsgStream log(messageService(), name());
  log << MSG::INFO << "========== NNGeneratorSvc::initialize() ==========" << endreq;

  StatusCode sc = Service::initialize();
  return sc;
}

StatusCode NNGeneratorSvc::finalize(){
  MsgStream log(messageService(), name());
  log << MSG::INFO << "========== NNGeneratorSvc::finalize() ==========" << endreq;

  return StatusCode::SUCCESS;
}

void NNGeneratorSvc::generate(G4ThreeVector mom, G4ThreeVector emc_pos){
    setLocalHitCol(mom);
    pos2CenterCrystal(emc_pos);
    local2Global();
    return;
}


void NNGeneratorSvc::setLocalHitCol(G4ThreeVector mom){
    m_emc_hit_col.clear();
    float energy = m_nnpred->getModel1Pred(mom.getR(), mom.getTheta(), mom.getPhi());
    std::vector<float> model2_out = m_nnpred->getModel2Pred(mom.getR(), mom.getTheta(), mom.getPhi(), energy);

    // set to hit col
    int n = sqrt(model2_out.size());
    for (int it = 0; it < model2_out.size(); it++){
        EmcHit tmp_hit = {it/n, it%n, model2_out[it], 0, it/n-2, it%n-2};
        m_emc_hit_col.push_back(tmp_hit);
    }
}

void NNGeneratorSvc::local2Global(){
    for (int it = 0; it < m_emc_hit_col.size(); it++){
        m_emc_hit_col[it]. global_part = 1;
        m_emc_hit_col[it]. global_ntheta += m_center.global_ntheta;
        m_emc_hit_col[it]. global_nphi += m_center.global_nphi;
    }

    // delete hits out of barrel
    for (int it = m_emc_hit_col.size()-1; it >= 0 ; it--){
        if (m_emc_hit_col[it]. global_ntheta < EmcID::getTHETA_BARREL_MIN() || m_emc_hit_col[it]. global_ntheta > EmcID::getTHETA_BARREL_MAX() ){
        m_emc_hit_col.erase(m_emc_hit_col.begin() + it);
        }
        else if (m_emc_hit_col[it]. global_nphi< EmcID::getPHI_BARREL_MIN() || m_emc_hit_col[it].global_nphi > EmcID::getPHI_BARREL_MAX()){
            m_emc_hit_col[it].global_nphi = (m_emc_hit_col[it].global_nphi + EmcID::getPHI_BARREL_MAX()+1) % (EmcID::getPHI_BARREL_MAX()+1);
        }
        else{}
    }

    return ;
}

bool NNGeneratorSvc::pos2CenterCrystal(G4ThreeVector pos){
    MsgStream log(msgSvc(), name());
    static IEmcRecGeoSvc* emc_rec_geo_svc;
    StatusCode sc = service("EmcRecGeoSvc", emc_rec_geo_svc);
    if(sc != StatusCode::SUCCESS) {
        log << MSG::ERROR << "EmcRec Error: Can't get EmcRecGeoSvc." << endmsg;
  }

    // not in barrel, then break
    double cos_theta = pos.cosTheta();

    if(fabs(cos_theta) > 0.83){
        return false;
    }

    double phi = pos.getPhi();
    // get nphi
    if(phi < 0){
        phi += 3.1415;
    }
    int nphi = int(phi / (3.1415 / (EmcID::getPHI_BARREL_MAX() - EmcID::getPHI_BARREL_MIN() + 1.) ));

    // get ntheta
    int ntheta = 0;
    float delta_cos_theta;
    double min_delta_cos_theta = 99999.;
    HepPoint3D crystal_front_center;
    for (int i=EmcID::getTHETA_BARREL_MIN(); i<=EmcID::getTHETA_BARREL_MAX(); i++){
        crystal_front_center = emc_rec_geo_svc->GetCFrontCenter(EmcID::crystal_id(1, i, nphi));
        delta_cos_theta = fabs(crystal_front_center.cosTheta() - cos_theta);
        if (delta_cos_theta < min_delta_cos_theta){
            ntheta = i;
            min_delta_cos_theta = delta_cos_theta;
        }
        else{
            break;
        }
    }
    m_center.global_part = 1;
    m_center.global_ntheta = ntheta;
    m_center.global_nphi = nphi;
}


