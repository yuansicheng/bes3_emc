
source /cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release/J20v2r0-branch/setup.sh
export PATH=/cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/contrib/gcc/8.3.0/bin/:$PATH
export LD_LIBRARY_PATH=/cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/contrib/gcc/8.3.0/lib64/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release/J20v2r0-branch/ExternalLibs/libtorch/1.6.0/lib:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=/junofs/users/wxfang/FastSim/bes3/705/workarea/Reconstruction/MdcDedxAlg/MdcDedxAlg-00-06-58/src/NN:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/hpcfs/juno/junogpu/yuansc/bes3-emc/anti_neutron_mc/scripts_caloflow_git/NNPred/:$LD_LIBRARY_PATH
export OMP_NUM_THREADS=1
