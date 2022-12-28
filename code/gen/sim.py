#!/usr/bin/python
# -*- coding: utf-8 -*-

# @Author	:	yuansc
# @Contact	:	yuansicheng@ihep.ac.cn
# @Date		:	2022-02-15 

import os, sys, argparse, logging

this_path = os.path.dirname(__file__)
if this_path not in sys.path:
    sys.path.append(this_path)

from utils import replaceJobOptionValue


# set arg
parser = argparse.ArgumentParser()

parser.add_argument('--log_level', type=int, default=5)
parser.add_argument('-i', type=int)
parser.add_argument('-c', '--card', type=str)
parser.add_argument('-t', '--template', type=str, default='jobOptionis_template/job_option_sim.txt')
parser.add_argument('--target_particle', type=str, default='')
parser.add_argument('--use_nn', type=str, default='false')
parser.add_argument('--events_per_file', type=float, default=1e3)

args = parser.parse_args()

# create job_option
job_option_file =  'job_option_sim_{}.txt'.format(args.i)
rtraw_file = '{}.rtraw'.format(args.i)

replace_dict = {
    'EvtDecay.userDecayTableName': args.card ,
    'ApplicationMgr.EvtMax': int(args.events_per_file),
    'NNGeneratorSvc.UseNN': args.use_nn ,
    'NNGeneratorSvc.TargetParticle': args.target_particle ,
    'RootCnvSvc.digiRootOutputFile': rtraw_file, 
    'BesRndmGenSvc.RndmSeed': args.i, 
    'MessageSvc.OutputLevel': args.log_level,
}

with open(args.template, 'r') as f:
    content = f.readlines()
content = replaceJobOptionValue(content, replace_dict)
with open(job_option_file, 'w') as f:
    f.writelines(''.join(content))

# run job_option
os.system('chmod 755 {}'.format(job_option_file))
os.system('boss.exe {}'.format(job_option_file))