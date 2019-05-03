"================================================================================
" File Name    : config/SpaceVim/plugins_before/git.vim
" Author       : AlanDing
" mail         :
" Created Time : Sat 04 May 2019 12:38:47 AM CST
"================================================================================
scriptencoding utf-8


if g:is_nvim
  exec 'so '.g:vim_plugindir.'git-p.vim'
endif


if g:spacevim_filemanager ==# 'defx'
  exec 'so '.g:vim_plugindir.'defx-git.vim'
endif


exec 'so '.g:vim_plugindir.'vim-gitgutter.vim'
