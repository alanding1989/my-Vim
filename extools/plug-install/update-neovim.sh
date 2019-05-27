#! /usr/bin/env bash

#================================================================================
# File Name    : extools/plugin-in-up/update-neovim.sh
# Author       : AlanDing
# Created Time : Sat 25 May 2019 08:52:21 PM CST
# Description  : 
#================================================================================

cd /opt/vim/ && mv -i /opt/vim/nvim-linux64 /opt/vim/nvim-linux64-old
sudo curl -fSLO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
tar -zxvf nvim-linux64.tar.gz && rm -rf nvim-linux64.tar.gz

if [ -e /opt/vim/nvim-linux64 ]; then
  rm -rf /opt/vim/nvim-linux64-old
fi
