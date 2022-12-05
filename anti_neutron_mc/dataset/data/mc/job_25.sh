#!/bin/bash
source ~/.bashrc
pwd
setup_boss
source /junofs/users/yuansc/bes3_emc/anti_neutron_mc/test/nnpred_env.sh
i=25
python ../../codes/sim.py -i $i -e 10000
python ../../codes/sim2rec.py -i $i
python ../../codes/rec2root.py -i $i