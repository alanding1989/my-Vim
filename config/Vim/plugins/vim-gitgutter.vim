"================================================================================
" File Name    : config/Vim/plugins/vim-gitgutter.vim
" Author       : AlanDing
" mail         :
" Created Time : Sat 04 May 2019 02:49:19 AM CST
"================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


let g:gitgutter_map_keys         = 0
nmap  <silent> [c  <Plug>GitGutterPrevHunk
nmap  <silent> ]c  <Plug>GitGutterNextHunk

if g:is_vim8
  let g:gtgutter_highlight_lines = 1
endif

" use custom diff sign
let g:gitgutter_sign_added              = '✚'
let g:gitgutter_sign_removed            = '✖'
let g:gitgutter_sign_removed_first_line = '▤'
let g:gitgutter_sign_modified           = '✹'
let g:gitgutter_sign_modified_removed   = '≃'
