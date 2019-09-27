#! /usr/bin/env bash

#================================================================================
# File Name    : extools/lang-install/python.sh
# Author       : AlanDing
# Created Time : Thu 06 Jun 2019 01:39:15 PM CST
# Description  : 
#================================================================================

# dotfile="$ALANDOTFILE"


if [ -x conda ]; then
  cpath=$(pwd)
  cd /mnt/fun+downloads/linux系统安装/code-software/lang/python || return
  curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
  sh ./Miniconda3-latest-Linux-x86_64.sh
  cd "$cpath" || return
fi

if [ ! -x "/usr/bin/pip" ]; then
  ln -s /home/alanding/software/lang-tools/miniconda/bin/pip usr/bin/pip
fi

if ! grep -q PYSPARK_PYTHON "/etc/profile"; then
  print "export JAVA_HOME=/opt/lang-tools/java/jdk\n \
    export PYSPARK_PYTHON=/home/alanding/software/lang-tools/miniconda/bin/python3.7" >> /etc/profile
fi

pip install -r "$HOME/.SpaceVim.d/extools/lang-install/python3-list.txt"

# if [ ! -e "/home/alanding/software/anaconda3/envs/py37" ]; then
  # conda creat -n py37 python=3.7
  # pip install -r $HOME/.SpaceVim.d/extools/lang-install/python3-list.txt
# fi

jupyter-nbextension install rise --py --sys-prefix
jupyter-nbextension enable rise --py --sys-prefix

