#! /usr/bin/env bash
#================================================================================
# File Name    : extools/spacevim/test-SpaceVim.sh
# Author       : AlanDing
# mail         :
# Created Time : Sat 11 May 2019 11:44:02 PM CST
#================================================================================

checkout() {
  cd "$HOME/.SpaceVim" && git checkout "$1"
}

gitstage() {
  git add --all && git commit -m 'test init'
}


if [ ! -e "$HOME/.SpaceVim.d/init.toml" ]; then
  curpath=$(pwd)
  cp "$HOME/.SpaceVim.d/backup/init.toml" "$HOME/.SpaceVim.d"
  checkout master || (gitstage && checkout master)
  cd "$curpath" || return

elif [ -e "$HOME/.SpaceVim.d/init.toml" ]; then
  curpath1=$(pwd)
  rm -rf "$HOME/.SpaceVim.d/init.toml"
  checkout myspacevim || (gitstage && checkout myspacevim)
  cd "$curpath1" || return

fi
