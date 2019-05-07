# ================================================================================
#  File Name    : snippet-update.sh
#  Author       : AlanDing
#  mail         :
#  Created Time : Tue 23 Apr 2019 09:06:07 PM CST
# ================================================================================
#! /usr/bin/env bash

path=`pwd`

cd "$HOME/.cache/vimfiles-alan/repos/github.com/alanding1989/my-neosnippet-snippets"
git remote add upstream git@github.com:Shougo/neosnippet-snippets
git pull upstream master
git push origin master

cd "$HOME/.cache/vimfiles-alan/repos/github.com/alanding1989/my-vim-snippets"
git remote add upstream git@github.com:honza/vim-snippets
git pull upstream master
git push origin master

cd "$path"
