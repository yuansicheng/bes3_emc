#!/usr/bin/python
# -*- coding: utf-8 -*-

# @Author    :   yuansc
# @Contact   :   yuansicheng@ihep.ac.cn
# @Date      :   2022-12-06

import os, sys, logging
import numpy as np

img_r2 = {}

def getEtot(img):
    return img.sum()

def getMax(img):
    return img.max()

def setR2(n):
    r2 = np.zeros((n,n))
    center = n // 2
    for i in range(n):
        for j in range(n):
            r2[i,j] = (center - i) ** 2 + (center - j) ** 2
    img_r2[n] = r2

def getSecmom(img):
    global img_r2
    if img.shape[0] not in img_r2:
        setR2(img.shape[0])
    r2 = img_r2[img.shape[0]]
    return (img*r2).sum() / img.sum()

def getE5x5(img):
    assert img.shape[0]>=5 and img.shape[0]==img.shape[1]
    center = img.shape[0] // 2
    return img[center-2:center+3, center-2:center+3].sum()

def getCenterE(img):
    center = img.shape[0] // 2
    return img[center, center]

def getNhit(img):
    return (img>1e-4).sum()


# # test
# img = np.ones((17,17))
# print(getSecmom(img))