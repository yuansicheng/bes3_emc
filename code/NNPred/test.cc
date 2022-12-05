#include "NNPred.h"
#include <string>
// #include <stdio.h>
#include <iostream>

int main(){
    std::string model1 = "/hpcfs/juno/junogpu/yuansc/bes3-emc/anti_neutron_mc/scripts_caloflow_git/model1.pt";
    std::string model2 = "/hpcfs/juno/junogpu/yuansc/bes3-emc/anti_neutron_mc/scripts_caloflow_git/model2.pt";
    NNPred nnpred (model1.c_str(), model2.c_str());

    // std::vector<float> test_out = nnpred.getModel2Pred(1., 1., 1., 1.);
    // for (int it = 0; it < test_out.size(); it++){
    //     std::cout << test_out[it] << " ";
    // }
    // std::cout << std::endl;

    float test_out = nnpred.getModel1Pred(1., 1., 1.);
    std::cout << test_out << std::endl;
}
