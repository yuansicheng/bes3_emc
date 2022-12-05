#include "GaudiKernel/MsgStream.h"
#include "GaudiKernel/AlgFactory.h"
#include "GaudiKernel/Algorithm.h"
#include "GaudiKernel/ISvcLocator.h"
#include "GaudiKernel/SmartDataPtr.h"
#include "GaudiKernel/IDataProviderSvc.h"
#include "GaudiKernel/PropertyMgr.h"
#include "GaudiKernel/Bootstrap.h"
#include "EventModel/EventModel.h"
#include "EventModel/Event.h"
#include "EvtRecEvent/EvtRecEvent.h"
#include "EvtRecEvent/EvtRecTrack.h"
#include "EventModel/EventHeader.h"
#include "DstEvent/TofHitStatus.h"
#include "McTruth/McParticle.h"
#include "McTruth/DecayMode.h"
#include "McTruth/MdcMcHit.h"
#include "McTruth/TofMcHit.h"
#include "McTruth/EmcMcHit.h"
#include "McTruth/TofMcHit.h"
#include "McTruth/MucMcHit.h"
#include "McTruth/McEvent.h"
#include "TMath.h"
#include "GaudiKernel/INTupleSvc.h"
#include "GaudiKernel/NTuple.h"
#include "GaudiKernel/Bootstrap.h"
#include "GaudiKernel/IHistogramSvc.h"
#include "CLHEP/Vector/ThreeVector.h"
#include "CLHEP/Vector/LorentzVector.h"
#include "CLHEP/Vector/TwoVector.h"
#include "CLHEP/Geometry/Point3D.h"
#include "EmcRecGeoSvc/EmcRecBarrelGeo.h"
#include "EmcRecGeoSvc/EmcRecGeoSvc.h"

#include "ExtractEmcInfo/ExtractEmcInfo.h"

/////////////////////////////////////////////////////////////////////////////

ExtractEmcInfo::ExtractEmcInfo(const std::string& name, ISvcLocator* pSvcLocator) : Algorithm(name, pSvcLocator) {
    
}

/////////////////////////////////////////////////////////////////////////////

StatusCode ExtractEmcInfo::initialize(){
    MsgStream log(msgSvc(), name());
		
	log << MSG::INFO << "in initialize()" << endmsg;
	
	StatusCode status;

    bookNTuple();
    
    m_event = 0;

    log << MSG::INFO << "successfully return from initialize()" <<endmsg;
  	return StatusCode::SUCCESS;
}

StatusCode ExtractEmcInfo::execute(){
    MsgStream log(msgSvc(), name());
		
	log << MSG::INFO << "in execute()" << endmsg;
	
	StatusCode status;

    getInfoFromMcParticleCol();
    getInfoFromRecEmcCol();
    getNeutralShower();

    m_tuple->write();
    m_event += 1;

    return StatusCode::SUCCESS;

}

StatusCode ExtractEmcInfo::finalize(){
    MsgStream log(msgSvc(), name());
		
	log << MSG::INFO << "in finalize()" << endmsg;
	
	StatusCode status;

    return StatusCode::SUCCESS;

}

/////////////////////////////////////////////////////////////////////////////

bool ExtractEmcInfo::bookNTuple(){
    m_tuple = ntupleSvc()->book ("FILE1/EmcInfo", CLID_ColumnWiseTuple, "N-Tuple");

    m_tuple->addItem("event", m_event);


    // mc partical
    m_tuple->addItem("mc_partical", m_mc_partical_index, 0, 100);
        m_tuple->addItem("pdg_code", m_mc_partical_index, m_pdg_code);
        m_tuple->addItem("momentum", m_mc_partical_index, m_momentum);
        m_tuple->addItem("theta", m_mc_partical_index, m_theta);
        m_tuple->addItem("phi", m_mc_partical_index, m_phi);
        m_tuple->addItem("hit_emc", m_mc_partical_index, m_hit_emc);
        m_tuple->addItem("killed", m_mc_partical_index, m_killed);

    // all hit on emc
    m_tuple->addItem("all_hit_index", m_all_hit_index, 0, 1000);
        m_tuple->addIndexedItem("all_hit_cell_id", m_all_hit_index, m_all_hit_cell_id);
        m_tuple->addIndexedItem("all_hit_energy", m_all_hit_index, m_all_hit_energy);

    m_tuple->addItem("neutral_shower_index", m_neutral_shower_index, 0, 25);
        m_tuple->addItem("shower_id", m_neutral_shower_index, m_shower_id);
        m_tuple->addIndexedItem("shower_etot", m_neutral_shower_index, m_shower_etot);
        m_tuple->addIndexedItem("shower_e5x5", m_neutral_shower_index, m_shower_e5x5);
        m_tuple->addIndexedItem("shower_secondmom", m_neutral_shower_index, m_shower_secondmom);
        m_tuple->addIndexedItem("shower_nhit", m_neutral_shower_index, m_shower_nhit);

    return true;
}

bool ExtractEmcInfo::getInfoFromMcParticleCol(){
    // momentum, theta, phi
    SmartDataPtr<Event::McParticleCol> mc_particle_col(eventSvc(), "/Event/MC/McParticleCol");
	if (!mc_particle_col){
	 	std::cout << "Could not retrieve McParticelCol" << std::endl;
	  	return false;
    }

    m_mc_partical_index = 0;
    double px, py, pz;
    
    for(Event::McParticleCol::iterator iter_mc=mc_particle_col->begin(); iter_mc!= mc_particle_col->end(); iter_mc++){
        px = (*iter_mc)->initialFourMomentum().x();
        py = (*iter_mc)->initialFourMomentum().y();
        pz = (*iter_mc)->initialFourMomentum().z();

        m_theta[m_mc_partical_index] = (*iter_mc)->initialFourMomentum().theta();
        m_phi[m_mc_partical_index] = (*iter_mc)->initialFourMomentum().phi();
        m_momentum[m_mc_partical_index] = sqrt(px*px+py*py+pz*pz);

        m_pdg_code[m_mc_partical_index] = (*iter_mc)->particleProperty();
        m_hit_emc[m_mc_partical_index] = ((*iter_mc)->statusFlags() & 1<<12) >> 12;
        m_killed[m_mc_partical_index] = ((*iter_mc)->statusFlags() & 1<<13) >> 13;

        m_mc_partical_index ++;
    }
    return true;
}

bool ExtractEmcInfo::getInfoFromRecEmcCol(){
    // EMC infomation
    SmartDataPtr<RecEmcHitCol> rec_emc_hit_col(eventSvc(),"/Event/Recon/RecEmcHitCol");
    if (!rec_emc_hit_col)
    {   
        std::cout << "Could not retrieve RecEmcHitCol" << std::endl;
        return false;
    }
    m_all_hit_index = 0;
    for(RecEmcHitCol::iterator it=rec_emc_hit_col->begin(); it!= rec_emc_hit_col->end(); it++)
    {
        m_all_hit_cell_id[m_all_hit_index] = (*it)->getCellId();
        m_all_hit_energy[m_all_hit_index] = (*it)->getEnergy();
        m_all_hit_index ++;
    }
    return true;
}

bool ExtractEmcInfo::getNeutralShower(){
    // neutral shower infomation
    SmartDataPtr<RecEmcShowerCol> rec_emc_shower_col(eventSvc(),"/Event/Recon/RecEmcShowerCol");
    SmartDataPtr<EvtRecTrackCol> evt_rec_trk_col(eventSvc(),  EventModel::EvtRec::EvtRecTrackCol);

    // get charged shower id
    std::vector<int> charged_shower_id;
    for(EvtRecTrackCol::iterator trk=evt_rec_trk_col->begin(); trk!= evt_rec_trk_col->end(); trk++){
        if ((*trk)->isEmcShowerValid()){
            charged_shower_id.push_back((*trk)->emcShower()->getShowerId().get_value());
        }
    }
    
    m_neutral_shower_index = 0;
    vector<int>::iterator it;
    for(RecEmcShowerCol::iterator shower=rec_emc_shower_col->begin(); shower!= rec_emc_shower_col->end(); shower++){
        m_shower_id[m_neutral_shower_index] = (*shower)->getShowerId().get_value();
        it = find(charged_shower_id.begin(), charged_shower_id.end(), 1);
        if (it != charged_shower_id.end()){
            continue;
        }
        m_shower_etot[m_neutral_shower_index] = (*shower)->energy();
        m_shower_e5x5[m_neutral_shower_index] = (*shower)->e5x5();
        m_shower_secondmom[m_neutral_shower_index] = (*shower)->secondMoment();
        m_shower_nhit[m_neutral_shower_index] = (*shower)->numHits();

        m_neutral_shower_index ++;
    }
}