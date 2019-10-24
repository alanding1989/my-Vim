#! /usr/bin/env bash


# File Name    : extools/lang-install/shell.sh
# Author       : AlanDing
# Created Time : Wed 02 Oct 2019 08:27:43 AM CST
# Description  : 


[ -d ./shellcheck-stable ] && sudo rm -rf ./shellcheck-stable*

cd /tmp && wget -q https://storage.googleapis.com/shellcheck/shellcheck-stable.linux.x86_64.tar.xz
tar -xf shellcheck* 

sudo cp -rf ./shellcheck-stable/shellcheck /usr/bin && printf "Installed successfully!\n"

[ -x /usr/bin/shellcheck ] && shellcheck --version

