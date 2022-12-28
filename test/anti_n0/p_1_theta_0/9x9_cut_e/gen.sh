#!/bin/bash
THIS_PATH=$(cd $(dirname $0);pwd)
echo $THIS_PATH

MODEL_PATH=$THIS_PATH/../../../../model/anti_n0/p_1_theta_0/9x9_cut_e

python $THIS_PATH/../../../../code/gen/gen2root.py\
    --n 1e4\
    --events_per_file 1e4\
    --do_rec\
    --do_root\
    --use_nn true\
    --target_particle anti_neutron\
    --decay_card decay_card/anti_neutron_p_1_theta_0.dec\
    --model_1 $MODEL_PATH/model1.pt\
    --model_2 $MODEL_PATH/model2.pt\
    --region 9\
    --abs_path  $THIS_PATH\
    --log_level 6