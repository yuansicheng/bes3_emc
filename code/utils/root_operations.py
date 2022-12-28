#!/usr/bin/python
# -*- coding: utf-8 -*-

# @Author    :   yuansc
# @Contact   :   yuansicheng@ihep.ac.cn
# @Date      :   2022-12-01

import os, sys, logging
import uproot
from collections import defaultdict
import numpy as np
import awkward

utils_path = os.path.dirname(__file__)
if utils_path not in sys.path:
    sys.path.append(utils_path)

from emc_info import EmcInfo
emc_info = EmcInfo()

def readRootFile(root_file, tree_name, keys='all'):
    assert os.path.isfile(root_file)
    rf = uproot.open(root_file)
    tree = rf[tree_name]
    if keys == 'all':
        keys = tree.keys()
    else:
        keys = [k for k in keys if k in tree.keys()]
    
    data = {}
    for key in keys:
        data[key] = tree[key].array()

    rf.close()
    return data

def getDictLen(d):
    return len(list(d.values())[0]) if d else 0 

def cleanRootDataWithIndex(root_data, index):
    for k, v in root_data.items():
        root_data[k] = root_data[k][index]
    return root_data 

def selectTargetParticle(root_data, pdg_code):
    # include target particle
    include_target_particle_index = [i for i in range(getDictLen(root_data)) if pdg_code in root_data['pdg_code'][i]]
    root_data = cleanRootDataWithIndex(root_data, include_target_particle_index)

    # select target particle
    target_particle_index = [list(data).index(pdg_code) for data in root_data['pdg_code']]
    for k in ['momentum', 'theta', 'phi', 'hit_emc', 'killed']:
        tmp = []
        for i in range(getDictLen(root_data)):
            tmp.append(root_data[k][i][target_particle_index[i]])
        root_data[k] = awkward.Array(tmp)
    return root_data

def selectHitBarrel(root_data):
    # select hit barrel event
    hit_barrel_index = [i for i in range(getDictLen(root_data)) if root_data['hit_emc'][i]]
    root_data = cleanRootDataWithIndex(root_data, hit_barrel_index)
    return root_data

def selectLeadingShowerInBarrel(root_data):
    leading_shower_in_barrel_index = [i for i in range(getDictLen(root_data)) if len(root_data['shower_id'][i]) and emc_info.isInBarrel(root_data['shower_id'][i][0])]
    root_data = cleanRootDataWithIndex(root_data, leading_shower_in_barrel_index)
    tmp = []
    for i in range(getDictLen(root_data)):
        tmp.append(root_data['shower_id'][i][0])
    root_data['leading_shower_id'] = awkward.Array(tmp)
    return root_data

def selectE(root_data, threshold=0.1):
    threshold_index = [i for i in range(getDictLen(root_data)) if root_data['shower_etot'][i][0]>threshold]
    root_data = cleanRootDataWithIndex(root_data, threshold_index)
    return root_data

# # test
# this_path = os.path.dirname(__file__)
# rf = os.path.join(this_path, '../../dataset/anti_n0/p_1_theta_0_test/0.root')
# data = readRootFile(rf, 'EmcInfo')
# print(data['pdg_code'][0])