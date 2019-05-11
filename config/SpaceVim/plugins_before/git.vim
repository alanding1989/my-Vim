"================================================================================
" File Name    : config/SpaceVim/plugins_before/git.vim
" Author       : AlanDing
" mail         :
" Created Time : Sat 04 May 2019 12:38:47 AM CST
"================================================================================
scriptencoding utf-8


if g:spacevim_filemanager ==# 'defx'
  exec 'so '.g:vim_plugindir.'defx-git.vim'
endif


if SpaceVim#layers#isLoaded('git') && index(g:spacevim_disabled_plugins, 'vim-gitgutter') == -1
  exec 'so '.g:vim_plugindir.'vim-gitgutter.vim'
endif
