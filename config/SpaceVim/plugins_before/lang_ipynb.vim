"================================================================================
" File Name    : config/SpaceVim/plugins_before/lang_ipynb.vim
" Author       : AlanDing
" mail         : 
" Created Time : Sun 12 May 2019 08:39:17 PM CST
"================================================================================
scriptencoding utf-8


if !SpaceVim#layers#isLoaded('lsp')
  exec 'so' g:vim_plugindir.'jedi-vim.vim'
endif
