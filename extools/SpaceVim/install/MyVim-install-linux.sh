#!/usr/bin/env bash

# ================================================================================
#  File Name    : vim-install/linux/my-config-install.sh
#  Author       : AlanDing
#  Created Time : Thu 18 Apr 2019 10:40:27 PM CST
# ================================================================================


if [ ! -e "/home/alanding/.SpaceVim" ]; then
  git clone git@github.com:alanding1989/SpaceVim.git "/home/alanding/.SpaceVim"
  git clone git@github.com:alanding1989/my-Vim.git "/home/alanding/.SpaceVim.d"
fi

if [ "$(whoami)" = 'root' ] && [ ! -e "/root/.SpaceVim" ]; then
  ln -s /home/alanding/.SpaceVim    /root/.SpaceVim
  ln -s /home/alanding/.SpaceVim.d  /root/.SpaceVim.d
  ln -s /home/alanding/.SpaceVim.d  /root/.vim
  ln -s /root/.SpaceVim             /root/.config/nvim
fi


if [ ! -e "/home/alanding/.vim" ]; then
  ln -s /home/alanding/.SpaceVim.d  /home/alanding/.vim
  ln -s /home/alanding/.SpaceVim    /home/alanding/.config/nvim
fi

