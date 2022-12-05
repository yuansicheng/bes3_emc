#ifndef NNPred_hh
#define NNPred_hh

#include<string>
#include<vector>


// #include <torch/script.h> // One-stop header.
// #include <ATen/Parallel.h> // One-stop header.


class NNPred{
    public: 
        // NNPred(const std::string&, const std::string&); // two flows
        NNPred(const char*, const char*, int region); // two flows
        ~NNPred();
        float getModel1Pred(float mom, float theta, float phi);

        std::vector<float> getModel2Pred(float mom, float theta, float phi, float energy);

    private:
        // torch::jit::script::Module m_module1;
        // torch::jit::script::Module m_module2;

        std::string m_model1_name;
        std::string m_model2_name;

        int m_region;


};

#endif

