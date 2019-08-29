#! /usr/bin/env bash


# File Name    : extools/plug-install/build-caffe.sh
# Author       : AlanDing
# Created Time : Fri 09 Aug 2019 02:10:29 AM CST
# Description  : 

path=/mnt/fun+downloads/linux系统安装/code-software/lang/cpp/deepL/caffe

if [ -e $path ]; then
  cd $path && git pull
else
  git clone git@github.com:BVLC/caffe.git $path && (cd $path || exit)
fi

sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install libatlas-base-dev 
sudo apt-get install libopenblas-dev 
sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev


mkdir build && cd build || exit

./configure --prefix=/opt/lang-tools/cpp/caffe

make all -j8
make test
make runtest

ln -s /opt/lang-tools/cpp/
