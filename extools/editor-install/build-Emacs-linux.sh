#! /usr/bin/env bash

#================================================================================
# File Name    : extools/editor-install/linux-buildemacs.sh
# Author       : AlanDing
# Created Time : Mon 03 Jun 2019 09:52:07 AM CST
# Description  : build and install latest emacs
#================================================================================


srcpath=/mnt/fun+downloads/linux系统安装/code-software/emacs/emacs-src


[ -x emacs ] && emacs --version

function src_update() {
  if [ ! -e $srcpath ]; then
    git clone -b master git://git.sv.gnu.org/emacs.git $srcpath
    cd $srcpath || return
    # dependencies
    sudo apt-get install libncurses5-dev libgtk-3-dev 
    sudo apt-get install libjpeg-dev libtiff5-dev libgif-dev libpng-dev libxpm-dev libgnutls28-dev \
      libgnutls28-dev

  else
    cd $srcpath || return && git pull
  fi
}

function build_install() {
  if [ -e /opt/emacs/emacs-old ]; then
    sudo rm -rf /opt/emacs/emacs-old
  fi
  if [ -e /opt/emacs/emacs ]; then
    sudo mv -i /opt/emacs/emacs /opt/emacs/emacs-old
  fi

  cd $srcpath &&
    ./autogen.sh \
    ./configure \
    --prefix=/opt/emacs/emacs

  make && make install
 }

# src_update
build_install
[ -x emacs ] && emacs --version

