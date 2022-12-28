#!/usr/bin/python
# -*- coding: utf-8 -*-

# @Author    :   yuansc
# @Contact   :   yuansicheng@ihep.ac.cn
# @Date      :   2022-12-01

import os, sys, logging
import pandas as pd

__all__ = ['EmcInfo']

this_path = os.path.dirname(__file__)
if this_path not in sys.path:
    sys.path.append(this_path)


class EmcInfo:
    def __init__(self) -> None:
        self.loadEmcInfo()

    def loadEmcInfo(self, file=os.path.join(this_path, 'emc_info.csv')):
        if not os.path.isfile(file):
            print('emc info file {} do not exists'.format(file))
        self._emc_info = pd.read_csv(file)
        self._emc_info.set_index('id', drop=True, inplace=True)
        self._emc_info_barrel = self._emc_info[self._emc_info['npart']==1]

        self._barrel_shape = (self._emc_info_barrel.max()-self._emc_info_barrel.min()+1).values[1:]

    def getEmcInfo(self, barrel_only=False):
        if barrel_only:
            return self._emc_info_barrel
        else:
            return self._emc_info.copy()

    def getBarrelShape(self):
        return self._barrel_shape

    def isInBarrel(self, id):
        return int(id) in self.getEmcInfo(barrel_only=True).index

    def barrelId2Coordinate(self, id):
        tmp = self.getEmcInfo(barrel_only=True).loc[int(id)]
        if tmp.shape[0]:
            return tmp.ntheta, tmp.nphi

    def barrelCoordinate2Id(self, ntheta, nphi):
        tmp = self.getEmcInfo(barrel_only=True)
        tmp = tmp.loc[(tmp.ntheta==int(ntheta) ) & (tmp.nphi==int(nphi))]
        if tmp.shape[0]:
            return tmp.index[0]

    def barrelDistance(self, id1, id2):
        tmp = [id1, id2]
        for i in range(len(tmp)):
            if not isinstance(tmp[i], (list, tuple)):
                assert self.isInBarrel(tmp[i])
                tmp[i] = self.barrelId2Coordinate(tmp[i])
        coo1, coo2 = tuple(tmp)
        
        delta_ntheta = abs(coo1[0]-coo2[0])
        delta_nphi = min(abs(coo1[1]-coo2[1]), self.getBarrelShape()[1]-abs(coo1[1]-coo2[1]))

        return delta_ntheta, delta_nphi

    def getBarrelNearIds(self, center_id, region):
        assert 0 < region < self.getBarrelShape()[0] and region % 2
        if not isinstance(center_id, (list, tuple)):
            assert self.isInBarrel(center_id)
            center_coo = self.barrelId2Coordinate(center_id)
        else:
            center_coo = center_id

        ntheta_range = list(range(max(0, center_coo[0]-region//2), min(self.getBarrelShape()[0], center_coo[0]+region//2+1)))
        nphi_range = [i%self.getBarrelShape()[1] if i>=0 else self.getBarrelShape()[1]+i for i in range(center_coo[1]-region//2, center_coo[1]+region//2+1)]
        
        tmp = self.getEmcInfo(barrel_only=True)
        tmp = tmp.loc[(tmp.ntheta.isin(ntheta_range)) & tmp.nphi.isin(nphi_range)]
        return tmp.index

# # test
# emc_info = EmcInfo()
# print(emc_info.getBarrelNearIds((2, 1), 5))