#! /usr/bin/env bash

#================================================================================
# File Name    : extools/lang-install/python.sh
# Author       : AlanDing
# Created Time : Thu 06 Jun 2019 01:39:15 PM CST
# Description  : 
#================================================================================

dotfile="$ALANDOTFILE"

if ! echo "$PATH" | grep conda ; then
  cpath=$(pwd)
  cd /mnt/fun+downloads/linux系统安装/code-software/lang/python || return
  curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
  sh ./Miniconda3-latest-Linux-x86_64.sh
  cd "$cpath" || return
fi

if [ ! -x "/usr/bin/pip" ]; then
  ln -s /home/alanding/software/anaconda3/envs/py36/bin/pip usr/bin/pip
fi

if ! grep -q PYSPARK_PYTHON "/etc/profile"; then
  print "export JAVA_HOME=/opt/lang-tools/java/jdk \
    \nexport PYSPARK_PYTHON=/home/alanding/software/anaconda3/envs/py36/bin/python3.6" >> /etc/profile
fi

if [ ! -e "/home/alanding/software/anaconda3/envs/py36" ]; then
  conda creat -n py36 python=3.6
  pip install -r "$dotfile/pip3-list.txt"
fi

