#!/usr/bin/python
# -*- coding: utf-8 -*-

# @Author    :   yuansc
# @Contact   :   yuansicheng@ihep.ac.cn
# @Date      :   2022-12-02

import os, sys, logging
import argparse

__all__ = ['SingleParticleDatasetMaker']

this_path = os.path.dirname(__file__)
if this_path not in sys.path:
    sys.path.append(this_path)

utils_path = os.path.join(this_path, '../utils')
if utils_path not in sys.path:
    sys.path.append(utils_path)

from dataset_maker import DatasetMaker
from root_operations import *
from emc_operations import getHitImg
from emc_info import EmcInfo

class SingleParticleDatasetWithThresholdMaker(DatasetMaker):
    def __init__(self, 
        root_path='', 
        h5_path='', 
        n_files=5, 
        events_per_file=10000, 
        tree='EmcInfo', 
        pdg_code=-2112, 
        region=5, 
        e_threshold=0.1) -> None:
        super().__init__(
            root_path=root_path, 
            h5_path=h5_path, 
            n_files=n_files, 
            events_per_file=events_per_file, 
            tree=tree
        )

        self._pdg_code = pdg_code
        self._region = region
        self._e_threshold = e_threshold

        self._emc_info = EmcInfo()
        

    def preprocessRoot(self, root_data):
        # drop useless data
        # useful_keys = ['pdg_code', 'momentum', 'theta', 'phi', 'hit_emc', 'all_hit_cell_id', 'all_hit_energy', 'shower_id']
        # root_data = {k:root_data[k] for k in useful_keys}

        root_data = selectTargetParticle(root_data, self._pdg_code)
        root_data = selectHitBarrel(root_data)
        root_data = selectLeadingShowerInBarrel(root_data)
        root_data = selectE(root_data, threshold=self._e_threshold)

        return root_data

    def processOneEvent(self, event_data):
        for k in ['momentum', 'theta', 'phi']:
            self._data[k].append(event_data[k])
        
        self._data['hit_img'].append(getHitImg(event_data['leading_shower_id'], self._region, dict(zip(event_data['all_hit_cell_id'], event_data['all_hit_energy']))))


# # test
# root_path = os.path.join(this_path, '../../dataset/anti_n0/p_1_theta_0_test')
# spdm = SingleParticleDatasetMaker(
#     root_path=root_path, 
#     h5_path=root_path, 
#     n_files=1, 
#     events_per_file=10, 
# )
# spdm.run()

