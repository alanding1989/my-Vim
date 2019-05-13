"================================================================================
" File Name    : config/SpaceVim/plugins_before/lang_python.vim
" Author       : AlanDing
" mail         : 
" Created Time : Mon 13 May 2019 10:59:05 AM CST
"================================================================================
scriptencoding utf-8


if !SpaceVim#layers#isLoaded('lsp')
  exec 'so' g:vim_plugindir.'jedi-vim.vim'
endif

exec 'so' g:vim_plugindir.'semshi.vim'
