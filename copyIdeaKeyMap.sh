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

src=$HOME/$(ls -a $HOME | grep IntelliJIdea)

# Specific Setting
keyMap=config/keymaps/Alanding-perfect.xml
codeStyle="config/codestyles/AlanDing prefer-Code Style.xml"

stringManipulation="config/options/stringManipulation.xml"
stringManipulationPopupMenu="config/options/customization.xml"


for item in "${ides[@]}"; do
  dist_name=$HOME/$(ls -a "$HOME" | grep "$item")
  if [ -e "$dist_name" ]; then
    cp -f "$src"/"$keyMap"                        "$dist_name"/"$keyMap"
    cp -f "$src"/"$codeStyle"                     "$dist_name"/"$codeStyle"

    cp -f "$src"/"$stringManipulation"            "$dist_name"/"$stringManipulation"
    cp -f "$src"/"$stringManipulationPopupMenu"   "$dist_name"/"$stringManipulationPopupMenu"

  else
    print "file [ $dist_name ] does not exit, or the file has changed, please checked!!!"
  fi
done
