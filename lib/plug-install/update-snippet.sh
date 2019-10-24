#! /usr/bin/env bash

path=$(pwd)

cd "$HOME/.cache/vimfiles-alan/repos/github.com/alanding1989/my-neosnippet-snippets" || return
git remote add upstream git@github.com:Shougo/neosnippet-snippets.git
git pull upstream master
git push origin master

cd "$HOME/.cache/vimfiles-alan/repos/github.com/alanding1989/my-vim-snippets" || return
git remote add upstream git@github.com:honza/vim-snippets.git
git pull upstream master
git push origin master

cd "$path" || return
