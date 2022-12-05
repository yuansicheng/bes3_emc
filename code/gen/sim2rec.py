#!/usr/bin/python
# -*- coding: utf-8 -*-

# @Author	:	yuansc
# @Contact	:	yuansicheng@ihep.ac.cn
# @Date		:	2022-02-15 

import os, sys, argparse, logging
from glob import glob

this_path = os.path.dirname(__file__)
if this_path not in sys.path:
    sys.path.append(this_path)

from utils import replaceJobOptionValue

# set arg
parser = argparse.ArgumentParser()
parser.add_argument('--log_level', type=int, default=5)
parser.add_argument('-i', type=int)
parser.add_argument('-t', '--template', type=str, default='jobOptionis_template/job_option_sim2rec.txt')
parser.add_argument('--target_particle', type=str, default='')
parser.add_argument('--use_nn', type=str, default='false')
parser.add_argument('--model_1', type=str, default='')
parser.add_argument('--model_2', type=str, default='')
parser.add_argument('--region', type=int, default=0)

args = parser.parse_args()

replace_dict = {
    'NNGeneratorSvc.UseNN': args.use_nn ,
    'NNGeneratorSvc.TargetParticle': args.target_particle ,
    'NNGeneratorSvc.region': args.region, 
    'NNGeneratorSvc.NNModel1': args.model_1,
    'NNGeneratorSvc.NNModel2': args.model_2,
    'MessageSvc.OutputLevel': args.log_level,
}

# create job_option
job_option_file =  'job_option_sim2rec_{}.txt'.format(args.i)
rtraw_file = '{}.rtraw'.format(args.i)
rec_file = '{}.rec'.format(args.i)

replace_dict['EventCnvSvc.digiRootOutputFile'] = rec_file

with open(args.template, 'r') as f:
    content = f.readlines()
replaceJobOptionValue(content, replace_dict)
for i, line in enumerate(content):
    if line.startswith('EventCnvSvc.digiRootInputFile'):
        input_files = '{\"' + rtraw_file + '\"}'
        content[i] = 'EventCnvSvc.digiRootInputFile = {}; \n'.format(input_files)
with open(job_option_file, 'w') as f:
    f.writelines(''.join(content))

# run job_option
os.system('chmod 755 {}'.format(job_option_file))
os.system('boss.exe {}'.format(job_option_file))