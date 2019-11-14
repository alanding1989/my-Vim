#! /usr/bin/env bash


# File Name    : lib/editor-install/copy-keymap.sh
# Author       : AlanDing
# Created Time : Fri 27 Sep 2019 11:33:47 PM CST
# Description  : 


declare -a ideas

ideas=("CLion"
      "GoLand"
      "PyCharm"
      "IdeaIC"
      )
      # "WebStorm"

src="$HOME/$(ls -a $HOME | grep IntelliJIdea)"
SPC_path="$HOME/.SpaceVim.d"

# Specific Setting
keyMap=config/keymaps/Alanding-perfect.xml
codeStyle="config/codestyles/AlanDing prefer-Code Style.xml"
colors="config/colors"
vmoptions="config/idea64.vmoptions"
properties="config/idea.properties"

stringManipulation="config/options/stringManipulation.xml"
stringManipulationPopupMenu="config/options/customization.xml"


for item in "${ideas[@]}"; do
  dist_name=$HOME/$(ls -a "$HOME" | grep "$item")
  if [ -e "$dist_name" ]; then
    cp -f  "$src/$keyMap"                        "$dist_name/$keyMap"
    cp -f  "$src/$codeStyle"                     "$dist_name/$codeStyle"
    cp -rf "$src/$colors"                        "$dist_name/config"

    # 将变量全转小写
    typeset -l idea=$item
    if [ $idea == 'ideaic' ]; then
      cp -rf "$src/$vmoptions"                   "$dist_name/config/idea64.vmoptions"
    else
      cp -rf "$src/$vmoptions"                   "$dist_name/config/${idea}64.vmoptions"
    fi 
    cp -rf "$src/$properties"                    "$dist_name/config/"


    cp -f  "$src/$stringManipulation"            "$dist_name/$stringManipulation"
    cp -f  "$src/$stringManipulationPopupMenu"   "$dist_name/$stringManipulationPopupMenu"

  else
    print "file [ $dist_name ] does not exit, or the file has changed, please checked!!!"
  fi
done


cp -rf "$src/$vmoptions"      "$SPC_path/etc/conf/idea"
cp -rf "$src/$properties"     "$SPC_path/etc/conf/idea"

cp -rf "$HOME/.ideavimrc"     "$SPC_path"
cp -rf "$HOME/.spacemacs"     "$SPC_path"
