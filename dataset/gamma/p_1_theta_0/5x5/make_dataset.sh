#!/bin/bash
THIS_PATH=$(cd $(dirname $0);pwd)
echo $THIS_PATH

python $THIS_PATH/../../../../code/dataset/make_single_particle_dataset.py\
    --root_path $THIS_PATH/../../../../gen/gamma/p_1_theta_0\
    --h5_path $THIS_PATH/\
    --n_files 6\
    --events_per_file 10000\
    --tree EmcInfo\
    --pdg_code 22\
    --region 5