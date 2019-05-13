#! /usr/bin/env bash
#================================================================================
# File Name    : extools/plugin-in-up/pr-SPC.sh
# Author       : AlanDing
# mail         : 
# Created Time : Sat 11 May 2019 10:16:21 PM CST
#================================================================================

#! /usr/bin/env bash

branchname=$1


# creat pr temp branch
if [ ! -d "/tmp/SpaceVim" ] && [ ! -d "$HOME/.SpaceVim_origin" ]; then
  cd /tmp || return
  rm -rf ./SpaceVim | git clone git@github.com:SpaceVim/SpaceVim.git SpaceVim && (cd SpaceVim || return)
  git remote remove origin && git remote add origin git@github.com:alanding1989/SpaceVim.git
  git remote add upstream git@github.com:SpaceVim/SpaceVIm.gi
  if -n "$(git branch -a | grep "$branchname")"; then
    git checkout -b "$branchname"
  else
    git push -u origin "$branchname"
  fi

elif [ -d "/tmp/SpaceVim" ] && [ ! -d "$HOME/.SpaceVim_origin" ]; then
  mv "$HOME/.SpaceVim" "$HOME/.SpaceVim_origin" && cp -r "/tmp/SpaceVim" "$HOME/.SpaceVim"

elif [ -d "/tmp/SpaceVim" ] && [ -d "$HOME/.SpaceVim_origin" ]; then
  rm -rf "$HOME/.SpaceVim" && mv "$HOME/.SpaceVim_origin" "$HOME/.SpaceVim"
  rm -rf "/tmp/SpaceVim"
fi
