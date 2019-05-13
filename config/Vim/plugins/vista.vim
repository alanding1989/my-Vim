"=========================================================================
" File Name    : config/Vim/plugins/vista.vim
" Author       : AlanDing
" mail         :
" Created Time : Wed 27 Mar 2019 08:04:05 AM CST
"=========================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


" only have right and left
if g:filetree_direction ==# 'right'
  let g:vista_sidebar_position = 'vertical topleft'
else
  let g:vista_sidebar_position = 'vertical botright'
endif
let g:vista_sidebar_width = 0 ? g:sidebar_width : 30


let g:vista_echo_strategy                 = 'floating_win'
let g:vista_stay_on_open                  = 1

let g:vista_icon_indent                   = 1 ? ['', ''] : ['╰─▸ ', '├─▸ ']
let g:vista_fzf_preview                   = ['right:50%']
let g:vista_finder_alternative_executives = ['coc', 'lcn']
let g:vista_default_executive             = 'ctags'
let g:vista_executive_for                 = {
      \ 'vim'  : 'ctags',
      \ }
let g:vista_ctags_cmd                     = {
      \ 'haskell': 'hasktags -o - -c',
      \ }
