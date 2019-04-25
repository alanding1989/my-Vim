# ================================================================================
#  File Name    : snippet-update.sh
#  Author       : AlanDing
#  mail         :
#  Created Time : Tue 23 Apr 2019 09:06:07 PM CST
# ================================================================================
#!/usr/bin/env bash

cd $HOME/.cache/vimfiles/repos/github.com/alanding1989/my-neosnippet-snippets
git remote add upstream git@github.com:Shougo/neosnippet-snippets
git pull upstream master
git push

cd $HOME/.cache/vimfiles/repos/github.com/alanding1989/my-vim-snippets
git remote add upstream git@github.com:honza/vim-snippets
git pull upstream master
git push
