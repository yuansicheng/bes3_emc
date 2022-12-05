#ifndef EXTRACT_EMC_INFO_H
#define EXTRACT_EMC_INFO_H

#include "GaudiKernel/AlgFactory.h"
#include "GaudiKernel/Algorithm.h"
#include "GaudiKernel/NTuple.h"
#include "GaudiKernel/SmartDataPtr.h"

class ExtractEmcInfo : public Algorithm {
    public:
        ExtractEmcInfo(const std::string& name, ISvcLocator* pSvcLocator);
        StatusCode initialize();
        StatusCode execute();
        StatusCode finalize();

    private:
        bool bookNTuple();
        bool getInfoFromMcParticleCol();
        bool getInfoFromRecEmcCol();
        bool getNeutralShower();

        int m_n;

        NTuple::Tuple*  m_tuple;
        NTuple::Item<int> m_event;

        NTuple::Item<int> m_mc_partical_index;   
            NTuple::Array<int> m_pdg_code;
            NTuple::Array<float> m_momentum;
            NTuple::Array<float> m_theta;
            NTuple::Array<float> m_phi;
            NTuple::Array<int> m_hit_emc;
            NTuple::Array<int> m_killed;

        NTuple::Item<int> m_all_hit_index;
            NTuple::Array<int> m_all_hit_cell_id;
            NTuple::Array<float> m_all_hit_energy;

        NTuple::Item<int> m_neutral_shower_index;
            NTuple::Array<int> m_shower_id;
            NTuple::Array<float> m_shower_etot;
            NTuple::Array<float> m_shower_e5x5;
            NTuple::Array<float> m_shower_secondmom;
            NTuple::Array<int> m_shower_nhit;
};

#endif