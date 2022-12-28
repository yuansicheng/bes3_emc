#!/usr/bin/python
# -*- coding: utf-8 -*-

# @Author    :   yuansc
# @Contact   :   yuansicheng@ihep.ac.cn
# @Date      :   2022-12-01

import os, sys, logging
from glob import glob
from collections import defaultdict
from tqdm import tqdm
import h5py
import numpy as np

__all__ = ['DatasetMaker']

this_path = os.path.dirname(__file__)
if this_path not in sys.path:
    sys.path.append(this_path)

utils_path = os.path.join(this_path, '../utils')
if utils_path not in sys.path:
    sys.path.append(utils_path)

from root_operations import readRootFile, getDictLen

class DatasetMaker:
    def __init__(
        self, 
        root_path='', 
        h5_path='', 
        n_files = 5, 
        events_per_file = 1e4, 
        tree = 'EmcInfo', 
        ) -> None:
        self._setRootFiles(root_path)
        self._setH5Path(h5_path)

        self._n_files = n_files
        self._events_per_file = events_per_file

        self._data = defaultdict(list)

        self._root_index = 0
        self._tree = tree
        

    def _setRootFiles(self, root_path):
        assert os.path.isdir(root_path)
        self._root_path = root_path
        self._root_files = glob(os.path.join(root_path, '*.root'))

    def _setH5Path(self, h5_path):
        self._h5_path = h5_path
        if not os.path.isdir(h5_path):
            os.makedirs(h5_path)

    def run(self):
        for i in tqdm(range(self._n_files)):
            while getDictLen(self._data) < self._events_per_file:
                self._processOneFile(self._root_files[self._root_index])
                self._root_index += 1
            self._saveOneH5(i)

    def preprocessRoot(self, root_data):
        raise NotImplementedError

    def processOneEvent(self, event_data):
        raise NotImplementedError


    def _processOneFile(self, root_file):
        print('loading file: {}'.format(root_file)) 
        root_data = readRootFile(root_file, self._tree)
        print('preproccessing file: {}'.format(root_file))
        root_data = self.preprocessRoot(root_data)
        
        print('preproccessing event: ')
        for i in tqdm(range(getDictLen(root_data))):
            event_data = {k:v[i] for k,v in root_data.items()}
            self.processOneEvent(event_data)

    def _saveOneH5(self, i):
        h5_file_name = os.path.join(self._h5_path, '{}.h5'.format(i))
        hf = h5py.File(h5_file_name, 'w')

        for k in self._data:
            hf[k] = np.array(self._data[k][:self._events_per_file])
            self._data[k] = self._data[k][self._events_per_file:]

        hf.close()

        
