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
from emc_operations import getHitImg
from emc_info import EmcInfo

class SingleParticleDatasetMaker(DatasetMaker):
    def __init__(self, 
        root_path='', 
        h5_path='', 
        n_files=5, 
        events_per_file=10000, 
        tree='EmcInfo', 
        pdg_code=-2112, 
        region=5) -> None:
        super().__init__(
            root_path=root_path, 
            h5_path=h5_path, 
            n_files=n_files, 
            events_per_file=events_per_file, 
            tree=tree
        )

        self._pdg_code = pdg_code
        self._region = region

        self._emc_info = EmcInfo()
        

    def preprocessRoot(self, root_data):
        # drop useless data
        useful_keys = ['pdg_code', 'momentum', 'theta', 'phi', 'hit_emc', 'all_hit_cell_id', 'all_hit_energy', 'shower_id']
        root_data = {k:root_data[k] for k in useful_keys}

        # include target particle
        include_target_particle_index = [i for i in range(self._getDictLen(root_data)) if self._pdg_code in root_data['pdg_code']]
        root_data = self._cleanRootDataWithIndex(root_data, include_target_particle_index)

        # select target particle
        target_particle_index = [list(data).index(self._pdg_code) for data in root_data['pdg_code']]
        for k in ['momentum', 'theta', 'phi', 'hit_emc']:
            root_data[k] = [root_data[k][i][target_particle_index[i]] for i in range(self._getDictLen(root_data))]

        # select hit barrel event
        hit_barrel_index = [i for i in range(self._getDictLen(root_data)) if root_data['hit_emc']]
        root_data = self._cleanRootDataWithIndex(root_data, hit_barrel_index)

        # leading shower in barrel
        leading_shower_in_barrel_index = [i for i in range(self._getDictLen(root_data)) if len(root_data['shower_id'][i]) and self._emc_info.isInBarrel(root_data['shower_id'][i][0])]
        root_data = self._cleanRootDataWithIndex(root_data, leading_shower_in_barrel_index)
        root_data['leading_shower_id'] = [data[0] for data in root_data['shower_id']]

        return root_data

    def processOneEvent(self, event_data):
        for k in ['momentum', 'theta', 'phi']:
            self._data[k].append(event_data[k])
        
        self._data['hit_img'].append(getHitImg(event_data['leading_shower_id'], self._region, dict(zip(event_data['all_hit_cell_id'], event_data['all_hit_energy']))))

    def _cleanRootDataWithIndex(self, root_data, index):
        for k, v in root_data.items():
            root_data[k] = [v[i] for i in range(len(index)) if i in index]
        return root_data


# # test
# root_path = os.path.join(this_path, '../../dataset/anti_n0/p_1_theta_0_test')
# spdm = SingleParticleDatasetMaker(
#     root_path=root_path, 
#     h5_path=root_path, 
#     n_files=1, 
#     events_per_file=10, 
# )
# spdm.run()

