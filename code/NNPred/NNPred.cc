#include "NNPred.h"
#include <torch/script.h> // One-stop header.
#include <ATen/Parallel.h> // One-stop header.
#include <iostream>
#include <memory>
#include <cmath>
#include <stdio.h>

#define DEBUG_FUNC {std::cout << __PRETTY_FUNCTION__ << ": " << __LINE__ << std::endl;}


double gaussrand(){
    static double V1, V2, S;
    static int phase = 0;
    double X;

    if ( phase == 0 ) {
        do {
            double U1 = (double)rand() / RAND_MAX;
            double U2 = (double)rand() / RAND_MAX;

            V1 = 2 * U1 - 1;
            V2 = 2 * U2 - 1;
            S = V1 * V1 + V2 * V2;
        } while(S >= 1 || S == 0);

        X = V1 * sqrt(-2 * log(S) / S);
    } else
        X = V2 * sqrt(-2 * log(S) / S);

    phase = 1 - phase;

    return X;
}


NNPred::NNPred(const char* model1_name, const char* model2_name, int region){
    
    m_model1_name = model1_name;
    m_model2_name = model2_name;

    m_region = region;

}

NNPred::~NNPred(){

}

float NNPred::getModel1Pred(float mom, float theta, float phi){
    static auto m_tensor_options = torch::TensorOptions().dtype(torch::kFloat32);
    static torch::jit::script::Module module1 = torch::jit::load(m_model1_name);

    module1.eval();

    std::vector<float> tmp_vec;
    tmp_vec.push_back(mom);
    tmp_vec.push_back(theta);
    tmp_vec.push_back(phi);
    tmp_vec.push_back(gaussrand());
    at::Tensor input_ = torch::from_blob(tmp_vec.data(), {1,4}, m_tensor_options);

    torch::jit::IValue output_ = module1.forward({input_});

    at::Tensor output;
    output = output_.toTensor();

    std::vector<float> v (output.data<float>(), output.data<float>() + output.numel());
    float res = v.at(0);
    return res;

}

std::vector<float> NNPred::getModel2Pred(float mom, float theta, float phi, float energy){
    static auto m_tensor_options = torch::TensorOptions().dtype(torch::kFloat32);
    static torch::jit::script::Module module2 = torch::jit::load(m_model2_name);

    module2.eval();

    std::vector<float> tmp_vec;
    tmp_vec.push_back(mom);
    tmp_vec.push_back(theta);
    tmp_vec.push_back(phi);
    tmp_vec.push_back(energy);
    for (int i = 0; i < m_region*m_region; i++)
    {
        // tmp_vec.push_back(1.);
        tmp_vec.push_back(gaussrand());
    }

    at::Tensor input_ = torch::from_blob(tmp_vec.data(), {1,m_region*m_region+4}, m_tensor_options);

    torch::jit::IValue output_ = module2.forward({input_});

    at::Tensor output;
    output = output_.toTensor();

    std::vector<float> v (output.data<float>(), output.data<float>() + output.numel());
    // float res = v.at(0);
    return v;

}




