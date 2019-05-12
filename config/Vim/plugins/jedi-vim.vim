"================================================================================
" File Name    : config/Vim/plugins/jedi-vim.vim
" Author       : AlanDing
" mail         : 
" Created Time : Sun 12 May 2019 07:51:54 PM CST
"================================================================================
scriptencoding utf-8


" in neovim, we can use deoplete-jedi together with jedi-vim,
" but we need to disable the completions of jedi-vim.
let g:jedi#completions_enabled    = 0
let g:jedi_auto_vim_configuration = 0
let g:jedi#completions_command    = ''
let g:jedi#use_splits_not_buffers = 'left'
let g:jedi#show_call_signatures   = '1'
let g:jedi#force_py_version       = 3
