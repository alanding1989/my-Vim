"=========================================================================
" File Name    : config/Vim/plugins/vim-visual-multi.vim
" Author       : AlanDing
" mail         :
" Created Time : Wed 27 Mar 2019 06:01:07 AM CST
"=========================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


let g:table_mode_tableize_map     = '<leader>tc'
let g:table_mode_toggle_map       = '<leader>tt'
let g:table_mode_add_formula_map  = '<Leader>ta'
let g:table_mode_eval_formula_map = '<Leader>te'
let g:table_mode_realign_map      = '<Leader>tf'


" diable easymotion leader
auto VimEnter * unmap ;;


let g:VM_leader = ';;'
let g:VM_maps   = {
      \ 'Select All'         : '<M-a>',
      \ 'Visual All'         : '<M-a>',
      \ 'Select Cursor Down' : '<M-j>',
      \ 'Select Cursor Up'   : '<M-K>',
      \ 'Select l'           : '<M-l>',
      \ 'Select h'           : '<M-h>',
      \ 'Undo'               : 'u'    ,
      \ 'Redo'               : '<C-R>',
      \ }
