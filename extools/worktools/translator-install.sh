#! /usr/bin/env bash


# File Name    : extools/tools/translator-install.sh
# Author       : AlanDing
# Created Time : Mon 21 Oct 2019 11:12:54 AM CST
# Description  : 

path="$HOME/.SpaceVim.d/extools/tools"

[ ! -d $path ] && git clone	git@github.com:skywind3000/translator.git $path
