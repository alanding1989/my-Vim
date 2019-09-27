#! /usr/bin/env bash


# File Name    : extools/editor-install/copy-keymap.sh
# Author       : AlanDing
# Created Time : Fri 27 Sep 2019 11:33:47 PM CST
# Description  : 


declare -a ides

ides=("CLion"
      "GoLand"
      "PyCharm"
      "Rider"
      "WebStorm"
      )

src=$HOME/$(ls -a $HOME | grep IntelliJIdea)/config/keymaps/Alanding-perfect.xml

for item in "${ides[@]}"; do
  ide_name=$HOME/$(ls -a "$HOME" | grep "$item")
  if [ -e "$ide_name" ]; then
    cp -f "$src" "$ide_name/config/keymaps/Alanding-perfect.xml"
  else
    print "file [ $ide_name ] does not exit, or the file has changed, please checked!!!"
  fi
done
