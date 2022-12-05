#!/bin/bash
THIS_PATH=$(cd $(dirname $0);pwd)
echo $THIS_PATH

python $THIS_PATH/../../../code/gen/gen2root.py\
    --n 10\
    --events_per_file 10\
    --do_sim \
    --do_rec\
    --do_root\
    --use_nn false\
    --target_particle anti_neutron\
    --decay_card decay_card/anti_neutron_p_1_theta_0.dec\
    --abs_path  $THIS_PATH\
    --log_level 2
