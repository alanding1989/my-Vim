#! /usr/bin/env bash


# File Name    : extools/plug-install/cpp/pybind.sh
# Author       : AlanDing
# Created Time : Tue 27 Aug 2019 09:36:10 PM CST
# Description  : 


headerpath=/opt/lang-tools/cpp/pybind11
repopath=/mnt/fun+downloads/linux系统安装/code-software/lang/python/pybind11
syshpath=/usr/local/include/pybind11

if [ ! -e $headerpath ]; then
  if [ ! -e $repopath ]; then
    git clone https://github.com/pybind/pybind11 $repopath && cd $repopath || exit 1
    mkdir build && cd build && cmake ..
    make check -j 4 && sudo make install
  fi
  if [ -e $syshpath ]; then
    sudo mv $syshpath /opt/lang-tools/cpp/
  fi
fi
