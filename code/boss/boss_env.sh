BOSS_DIR='/junofs/users/yuansc/bes3_emc/code/boss'

source $BOSS_DIR/cmthome/setup.sh
source $BOSS_DIR/cmthome/setupCMT.sh
source $BOSS_DIR/cmthome/setupCVS.sh
source $BOSS_DIR/workarea/TestRelease/TestRelease-00-00-92/cmt/setup.sh

source $BOSS_DIR/workarea/NNGeneratorSvc/NNGeneratorSvc-00-00-01/cmt/setup.sh
source $BOSS_DIR/workarea/ExtractEmcInfo/ExtractEmcInfo-00-00-01/cmt/setup.sh

export PATH=/cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/contrib/gcc/8.3.0/bin/:$PATH
export LD_LIBRARY_PATH=/cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/contrib/gcc/8.3.0/lib64/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release/J20v2r0-branch/ExternalLibs/libtorch/1.6.0/lib:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=/junofs/users/wxfang/FastSim/bes3/705/workarea/Reconstruction/MdcDedxAlg/MdcDedxAlg-00-06-58/src/NN:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/junofs/users/yuansc/bes3_emc/code/NNPred:$LD_LIBRARY_PATH
export OMP_NUM_THREADS=1