#! /usr/bin/env bash
#================================================================================
# File Name    : lib/plugin-in-up/pr-SPC.sh
# Author       : AlanDing
# mail         : 
# Created Time : Sat 11 May 2019 10:16:21 PM CST
#================================================================================


branchname=$1
path="$HOME/0_Dev/SpaceVim-PR/SpaceVim-$branchname"

  rm -rf $path && git clone git@github.com:SpaceVim/SpaceVim.git $path

  cd $path && \
    git remote remove origin && \
    git remote add origin   git@github.com:alanding1989/SpaceVim.git && \
    git remote add upstream git@github.com:SpaceVim/SpaceVim.git

  if ! (git branch -a | grep -q "$branchname") ; then
    git checkout -b "$branchname" && git push -uf origin "$branchname"
  else
    git checkout "$branchname"
  fi
