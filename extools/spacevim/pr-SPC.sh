#! /usr/bin/env bash
#================================================================================
# File Name    : extools/plugin-in-up/pr-SPC.sh
# Author       : AlanDing
# mail         : 
# Created Time : Sat 11 May 2019 10:16:21 PM CST
#================================================================================

#! /usr/bin/env bash

branchname=$1

cd /tmp
rm -rf ./SpaceVim | git clone git@github.com:SpaceVim/SpaceVim.git SpaceVim && cd ./SpaceVim
git checkout -b "$branchname"
git remote remove origin && git remote add origin git@github.com:alanding1989/SpaceVim.git
git remote add upstream git@github.com:SpaceVim:SpaceVIm.git
git push -u origin dev
