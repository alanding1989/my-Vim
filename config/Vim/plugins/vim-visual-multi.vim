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


let g:table_mode_toggle_map     = 't'
let g:table_mode_tableize_map   = '<Leader>tc'
let g:table_mode_tableize_d_map = '<Leader>tC'

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
