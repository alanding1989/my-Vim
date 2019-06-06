#! /usr/bin/env bash

#================================================================================
# File Name    : extools/lang-install/python.sh
# Author       : AlanDing
# Created Time : Thu 06 Jun 2019 01:39:15 PM CST
# Description  : 
#================================================================================


if [ ! -x "/usr/bin/pip" ]; then
  ln -s /home/alanding/software/anaconda3/envs/py36/bin/pip usr/bin/pip
fi

if ! grep -q PYSPARK_PYTHON "/etc/profile"; then
  print "export JAVA_HOME=/opt/lang-tools/java/jdk \
    \nexport PYSPARK_PYTHON=/home/alanding/software/anaconda3/envs/py36/bin/python3.6" >> /etc/profile
fi
