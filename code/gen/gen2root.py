#!/usr/bin/python
# -*- coding: utf-8 -*-

# @Author	:	yuansc
# @Contact	:	yuansicheng@ihep.ac.cn
# @Date		:	2022-02-15 

import os, sys, argparse, logging

this_path = os.path.abspath(os.path.dirname(__file__))

parser = argparse.ArgumentParser()
parser.add_argument('--log_level', type=int, default=5)
parser.add_argument('--boss_env', type=str, default='../boss/boss_env.sh')

parser.add_argument('--do_sim', action='store_true')
parser.add_argument('--do_rec', action='store_true')
parser.add_argument('--do_root', action='store_true')

parser.add_argument('-c', '--decay_card', type=str)

parser.add_argument('--job_option_template_sim', type=str, default='jobOptionis_template/job_option_sim.txt')
parser.add_argument('--job_option_template_rec', type=str, default='jobOptionis_template/job_option_sim2rec.txt')
parser.add_argument('--job_option_template_root', type=str, default='jobOptionis_template/job_option_rec2root.txt')

parser.add_argument('--n', type=float, default=1e3)
parser.add_argument('--events_per_file', type=float, default=1e3)

parser.add_argument('--path', type=str)
parser.add_argument('--abs_path', type=str)

parser.add_argument('--target_particle', type=str, default='')
parser.add_argument('--use_nn', type=str, default='false')

parser.add_argument('--model_1', type=str, default='')
parser.add_argument('--model_2', type=str, default='')
parser.add_argument('--region', type=int, default=0)

args = parser.parse_args()

# ##########################################
# options
args.decay_card = os.path.join(this_path, args.decay_card)
args.boss_env = os.path.join(this_path, args.boss_env)

args.path = os.path.join(this_path, args.boss_env)
if args.abs_path:
    args.path = args.abs_path

args.job_option_template_sim = os.path.join(this_path, args.job_option_template_sim)
args.job_option_template_rec = os.path.join(this_path, args.job_option_template_rec)
args.job_option_template_root = os.path.join(this_path, args.job_option_template_root)

args.model_1 = os.path.join(this_path, args.model_1)
args.model_2 = os.path.join(this_path, args.model_2)

# ##########################################


if not os.path.isdir(args.path):
    os.makedirs(args.path)

os.chdir(args.path)


for i in range(int(args.n/args.events_per_file)):
    job_file = 'job_{}.sh'.format(i)

    job_content = []
    job_content.append('#!/bin/bash')
    job_content.append('pwd')
    job_content.append('source {}'.format(args.boss_env))

    if args.do_sim:
        job_content.append('python {}/sim.py\\'.format(this_path))
        job_content.append('\t-i {}\\'.format(i))
        job_content.append('\t-c {}\\'.format(args.decay_card))
        job_content.append('\t-t {}\\'.format(args.job_option_template_sim))
        job_content.append('\t--target_particle {}\\'.format(args.target_particle))
        job_content.append('\t--use_nn {}\\'.format(args.use_nn))
        job_content.append('\t--events_per_file {}\\'.format(args.events_per_file))
        job_content.append('\t--log_level {}'.format(args.log_level))

    if args.do_rec:
        job_content.append('python {}/sim2rec.py\\'.format(this_path))
        job_content.append('\t-i {}\\'.format(i))
        job_content.append('\t-t {}\\'.format(args.job_option_template_rec))
        job_content.append('\t--model_1 {}\\'.format(args.model_1))
        job_content.append('\t--model_2 {}\\'.format(args.model_2))
        job_content.append('\t--region {}\\'.format(args.region))
        job_content.append('\t--use_nn {}\\'.format(args.use_nn))
        job_content.append('\t--log_level {}'.format(args.log_level))

    if args.do_root:
        job_content.append('python {}/rec2root.py\\'.format(this_path))
        job_content.append('\t-i {}\\'.format(i))
        job_content.append('\t-t {}\\'.format(args.job_option_template_root))
        job_content.append('\t--log_level {}'.format(args.log_level))

    with open(job_file, 'w') as f:
        f.write('\n'.join(job_content))

    os.system('chmod 755 {}'.format(job_file))
    os.system('hep_sub {}'.format(job_file))

