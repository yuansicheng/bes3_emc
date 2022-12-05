#!/bin/bash

source ~yuansc/.bashrc
setup_boss
junofs
cd bes3_emc/anti_neutron_mc/test/single_gamma
pwd
source ../nnpred_env.sh


boss.exe job_options_sim_0_with_nn.txt
boss.exe job_options_rec_0_with_nn.txt
boss.exe job_options_root_0_with_nn.txt
