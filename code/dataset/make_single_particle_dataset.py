#!/usr/bin/python
# -*- coding: utf-8 -*-

# @Author    :   yuansc
# @Contact   :   yuansicheng@ihep.ac.cn
# @Date      :   2022-12-02

import os, sys, logging
import argparse

this_path = os.path.dirname(__file__)
if this_path not in sys.path:
    sys.path.append(this_path)

from single_particle_dataset_maker import SingleParticleDatasetMaker

def getArgs():
    parser = argparse.ArgumentParser()

    parser.add_argument('--root_path', type=str)
    parser.add_argument('--h5_path', type=str)
    parser.add_argument('--n_files', type=int, default=5)
    parser.add_argument('--events_per_file', type=int, default=10000)
    parser.add_argument('--tree', type=str, default='EmcInfo')
    parser.add_argument('--pdg_code', type=int)
    parser.add_argument('--region', type=int, default=5)

    return parser.parse_args()

if __name__ =='__main__':
    args = getArgs()
    dataset_maker = SingleParticleDatasetMaker(
        root_path=args.root_path, 
        h5_path=args.h5_path, 
        n_files=args.n_files, 
        events_per_file=args.events_per_file, 
        tree=args.tree, 
        pdg_code=args.pdg_code, 
        region=args.region, 
    )
    dataset_maker.run()
