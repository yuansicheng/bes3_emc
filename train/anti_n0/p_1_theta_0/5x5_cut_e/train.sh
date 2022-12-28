#!/bin/bash
THIS_PATH=$(cd $(dirname $0);pwd)
echo $THIS_PATH

python $THIS_PATH/../../../../code/caloflow/run.py\
    --workpath .\
    --particle_type n0\
    --generate_to_file \
    --restore_file $THIS_PATH/model_checkpoint.pt \
    --data_dir $THIS_PATH/../../../../dataset/anti_n0/p_1_theta_0/5x5_cut_e \
    --output_dir $THIS_PATH \
    --with_noise \
    --mode single_recursive \
    --n_epochs 30 \
    --train \
    --region 5 \