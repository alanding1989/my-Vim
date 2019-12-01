#! /usr/bin/env bash


# File Name    : lib/lang-install/java.sh
# Author       : AlanDing
# Created Time : Fri 25 Oct 2019 06:05:58 PM CST
# Description  : 

path=$HOME/software/lang-tools/Java/Arthas/

[ ! -d $path ] && mkdir $path

curl https://arthas.gitee.io/arthas-boot.jar -o $HOME/software/lang-tools/Java/Arthas/

