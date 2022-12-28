#!/bin/bash
THIS_PATH=$(cd $(dirname $0);pwd)
echo $THIS_PATH

python $THIS_PATH/../../../code/gen/gen2root.py\
    --n 2e5\
    --events_per_file 1e4\
    --do_sim \
    --do_rec\
    --do_root\
    --use_nn false\
    --target_particle gamma\
    --decay_card decay_card/gamma_p_1_theta_0.dec\
    --abs_path  $THIS_PATH\
    --log_level 6
