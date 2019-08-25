#! /usr/bin/env bash


# File Name    : extools/plug-install/cgdb.sh
# Author       : AlanDing
# Created Time : Sun 25 Aug 2019 09:50:32 PM CST
# Description  : 

# set -e

path=/mnt/fun+downloads/linux系统安装/code-software/cgdb

if [ ! -e "$path" ]; then
  git clone git@github.com:cgdb/cgdb.git "$path"
  mkdir -p "$path/build"
fi

cd "$path/build" || exit 1
../autogen.sh
../configure && make -srj4 && make install
