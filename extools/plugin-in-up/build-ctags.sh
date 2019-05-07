#================================================================================
# File Name    : extools/plugin-in-up/build-ctags.sh
# Author       : AlanDing
# mail         :
# Created Time : Tue 07 May 2019 10:26:36 PM CST
#================================================================================
#! /usr/bin/env bash

sudo apt-get install libjansson-dev
./autogen.sh && ./configure --prefix=/opt/vim/universal-ctags && make && sudo make install

