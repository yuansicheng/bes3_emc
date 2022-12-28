#!/usr/bin/python
# -*- coding: utf-8 -*-

# @Author    :   yuansc
# @Contact   :   yuansicheng@ihep.ac.cn
# @Date      :   2022-12-02

import os, sys, logging
import numpy as np

import matplotlib.pyplot as plt
import matplotlib.patches as patches

__all__ = ['getHitImg', 'getHitImgAll', 'showHitImg']

this_path = os.path.dirname(__file__)
if this_path not in sys.path:
    sys.path.append(this_path)

from emc_info import EmcInfo
emc_info = EmcInfo()

def getHitImg(leading_shower_id, region, hit_map):
    global emc_info
    near_ids = emc_info.getBarrelNearIds(leading_shower_id, region)

    # select useful hits
    hit_map = {k:v for k,v in hit_map.items() if k in near_ids}

    # construct hit img
    hit_img = np.zeros((region, region))
    center_coo = emc_info.barrelId2Coordinate(leading_shower_id)

    for emc_id, energy in hit_map.items():
        this_coo = emc_info.barrelId2Coordinate(emc_id)

        x = this_coo[0] - center_coo[0]
        y = this_coo[1] - center_coo[1] 
        if abs(y) > region // 2:
            sign = 1 if y < 0 else -1
            y = sign * (emc_info.getBarrelShape()[1] - abs(y))

        hit_img[x+ region // 2, y+ region // 2] = energy

    return hit_img


def getHitImgAll(hit_map):
    global emc_info
    hit_img = np.zeros((emc_info.getBarrelShape()[0], emc_info.getBarrelShape()[1]))

    for emc_id, energy in hit_map.items():
        try:
            this_coo = emc_info.barrelId2Coordinate(emc_id)
            hit_img[this_coo[0], this_coo[1]] = energy
        except:
            pass

    return hit_img

def showHitImg(hit_img, marks=[], figsize=(5,5), drop_zero=True):
    if drop_zero:
        np.place(hit_img, hit_img==0, np.nan)
    plt.clf()
    fig = plt.figure(figsize=figsize, dpi=96)
    ax = plt.axes()
    for mark in marks:
        ax.add_patch(patches.Rectangle(np.array(mark)-0.5, 1, 1, fill=False, linewidth=1, edgecolor='red', zorder=100))
    plt.imshow(hit_img.T, zorder=10)
    plt.xlabel('ntheta')
    plt.ylabel('nphi')
    plt.colorbar()
    plt.tight_layout()
    return fig








