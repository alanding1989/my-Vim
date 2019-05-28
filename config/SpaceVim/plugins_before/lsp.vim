"================================================================================
" File Name    : config/SpaceVim/plugins_before/lsp.vim
" Author       : AlanDing
" Created Time : Sun 26 May 2019 02:40:06 PM CST
" Description  : 
"================================================================================
scriptencoding utf-8


if g:spacevim_autocomplete_method ==# 'coc'
  finish
elseif g:pure_viml

else
  exec 'so ' g:vim_plugindir.'LanguageClient-neovim.vim'
endif
