# BESIII反中子模拟研究

## 1. 研究背景
反中子作为一种中性强子，不会在漂移室中产生径迹，除去在TOF（飞行时间计数器）中沉积的少量能量外，大部分能量沉积在EMC（电磁量能器）中。
由于数据缺失，GEANT4并不能很好得模拟反中子在EMC中的响应。对于EMC的端盖，本底更加复杂，并且和桶部间存在其他物质，使得Geant4模拟更加不准确。此外，预计BEPC未来会进一步升高对撞能量，将会产生大量强子等，有模拟中性强子的需求的物理道将会增加。因此，实现一种data-driven（数据驱动）的模拟方法，由反中子的四动量，通过一个网络直接生成探测器响应是非常重要的。

## 2. 研究方案
- 数据集制作：使用模拟/实验数据，经过挑选后提取出量能器上特定区域的响应作为神经网络的输入。
- 网络模型选择：CaloFlow模型。
- 网络训练：使用CaloFlow现有代码，后面根据对模型和任务的理解对模型进行调整。
- 模型性能检查：
    - 框架外，定义一些函数检验分布一致性；
    - 框架内，比较使用/不使用深度学习，经过官方重建后，对物理分析有意义的变量分布的一致性。

## 3.代码

### 3.1. boss框架相关代码
#### 3.1.1. 模拟
code/boss/workarea/Simulation/BOOST
- EmcSim
    - BesEmcSD.cc：processHits时，记录目标粒子是否击中量能器，并且如果使用深度学习，kill这条track。
- TruSim
    - BesTruthTrack：增加is_killed和is_hit_emc两个字段，并能通过函数访问。
    - BesSensitiveManager::EndOfTrack：将G4Track中的状态存储到TruthTrack中。
- BesSim
    - BesMcTruthWriter::SaveMcParticle：将TruthTrack的状态存储到McParticle的flag中的12和13位，使重建可以读取track的状态。

#### 3.1.2. 重建
code/boss/workarea/Reconstraction
- EmcRec
    - 2hitmap之后，遍历McParticle，如果有需要使用深度学习模型生成的粒子，调用NNGeneratorSvc产生一组击中，并填入hitmap中。

#### 3.1.3. 量能器击中提取（新增包）
code/boss/workarea/ExtractEmcInfo
- ExtractEmcInfo
    - 提取rec文件中的以下信息：
        - McParticle信息；
        - EMC上所有击中信息，用于生成数据集；
        - EMC Shower信息， 用于检验重建结果。

#### 3.1.4. 框架内调用深度学习模型（新增包）
code/boss/workarea/NNGeneratorSvc
- NNGeneratorSvc
- 该svc主要实现两个功能
    - 模拟中需要kill特定粒子种类，粒子种类由svc传入；
    - 重建中调用NNPred完成预测，具体流程为根据传入的动量和位置，先根据粒子初始动量产生local的图片（与量能器结构无关），再根据粒子击中量能器的位置生成全局的emc hit。

### 3.2. 框架外调用深度学习模型
code/NNPred
- 使用JUNO环境的libTorch调用预先训练的模型。

### 3.3. 通用工具函数
code/util

### 3.4. 数据集代码
code/gen

