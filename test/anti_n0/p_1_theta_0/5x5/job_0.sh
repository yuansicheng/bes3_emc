#!/bin/bash
pwd
source /junofs/users/yuansc/bes3_emc/code/gen/../boss/boss_env.sh
# python /junofs/users/yuansc/bes3_emc/code/gen/sim.py\
# 	-i 0\
# 	-c /junofs/users/yuansc/bes3_emc/code/gen/decay_card/anti_neutron_p_1_theta_0.dec\
# 	-t /junofs/users/yuansc/bes3_emc/code/gen/jobOptionis_template/job_option_sim.txt\
# 	--target_particle anti_neutron\
# 	--use_nn true\
# 	--events_per_file 10000.0\
# 	--log_level 6
python /junofs/users/yuansc/bes3_emc/code/gen/sim2rec.py\
	-i 0\
	-t /junofs/users/yuansc/bes3_emc/code/gen/jobOptionis_template/job_option_sim2rec.txt\
	--model_1 /junofs/users/yuansc/bes3_emc/test/anti_n0/p_1_theta_0/5x5/../../../../model/anti_n0/p_1_theta_0/5x5/model1.pt\
	--model_2 /junofs/users/yuansc/bes3_emc/test/anti_n0/p_1_theta_0/5x5/../../../../model/anti_n0/p_1_theta_0/5x5/model2.pt\
	--region 5\
	--use_nn true\
	--log_level 6
python /junofs/users/yuansc/bes3_emc/code/gen/rec2root.py\
	-i 0\
	-t /junofs/users/yuansc/bes3_emc/code/gen/jobOptionis_template/job_option_rec2root.txt\
	--log_level 6