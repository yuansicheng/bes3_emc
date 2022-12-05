c++ -g -c -I"./" -I"/cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release/J20v2r0-branch/ExternalLibs/libtorch/1.6.0/include"   -pipe   -W -Wall -Wwrite-strings -Wpointer-arith -Woverloaded-virtual  -std=c++14  -fPIC  -D_GNU_SOURCE -o ./NNPred.o     ./NNPred.cc 
c++ -g -fPIC -shared -Wl,--no-undefined -L/cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release/J20v2r0-branch/ExternalLibs/libtorch/1.6.0/lib -ltorch -lc10 -ltorch_cpu -o ./libNNPred.so  ./NNPred.o 

# c++ -g ./test.cc ./libNNPred.so

