#！/bin/bash

source ~yuansc/.bashrc
setup_boss

TEST_DIR="/junofs/users/yuansc/test"
source $TEST_DIR/nnpred_env.sh

boss.exe $TEST_DIR/job_options_sim_0.txt
boss.exe $TEST_DIR/job_options_rec_0.txt
boss.exe $TEST_DIR/job_options_root_0.txt