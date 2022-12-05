#ifndef NNGENERATORSVC_H_
#define NNGENERATORSVC_H_

#include "GaudiKernel/IInterface.h"
#include "GaudiKernel/Kernel.h"
#include "GaudiKernel/Service.h"
#include "GaudiKernel/IIncidentListener.h"

#include "NNGeneratorSvc/INNGeneratorSvc.hh"
#include <string>

#include "G4ThreeVector.hh"

class NNPred;


struct EmcHit{
    int local_x;
    int local_y;
    double energy; 
    int global_part;
    int global_ntheta;
    int global_nphi;   
};

class NNGeneratorSvc: public Service, virtual public INNGeneratorSvc{
    public:
        NNGeneratorSvc(const std::string& name, ISvcLocator* svcloc);
        ~NNGeneratorSvc();

        bool getUseNN(){return m_use_nn;}
        void generate(G4ThreeVector mom, G4ThreeVector emc_pos);
        std::vector<EmcHit>* getHitCol(){return &m_emc_hit_col; }
        std::string getTargetParticle(){return m_target_particle;}

        virtual StatusCode queryInterface(const InterfaceID& riid, void** ppvUnknown);
        virtual StatusCode initialize();
        virtual StatusCode finalize();

    private:

        void setLocalHitCol(G4ThreeVector mom);
        void local2Global();
        void reset();
        bool pos2CenterCrystal(G4ThreeVector emc_pos);

    private:
        bool m_use_nn;
        std::vector<EmcHit> m_emc_hit_col;
        EmcHit m_center;
        bool m_use_antineutron_nn;
        NNPred* m_nnpred;
        
        std::string m_model_1;
        std::string m_model_2;

        std::string m_target_particle;
        int m_region;
           
};

#endif
