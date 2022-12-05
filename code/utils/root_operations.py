#!/usr/bin/python
# -*- coding: utf-8 -*-

# @Author    :   yuansc
# @Contact   :   yuansicheng@ihep.ac.cn
# @Date      :   2022-12-01

import os, sys, logging
import uproot

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

# # test
# this_path = os.path.dirname(__file__)
# rf = os.path.join(this_path, '../../dataset/anti_n0/p_1_theta_0_test/0.root')
# data = readRootFile(rf, 'EmcInfo')
# print(data['pdg_code'][0])