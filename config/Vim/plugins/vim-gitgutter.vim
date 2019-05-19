"================================================================================
" File Name    : config/Vim/plugins/vim-gitgutter.vim
" Author       : AlanDing
" Created Time : Sat 04 May 2019 02:49:19 AM CST
"================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1



let g:gitgutter_map_keys = 0
nmap     [g  <Plug>GitGutterPrevHunk
nmap     ]g  <Plug>GitGutterNextHunk
if !hasmapto('<Plug>(coc-git-chunkinfo)', 'n')
  exec 'nmap  gp  <Plug>GitGutterPreviewHunk'
endif


if g:is_vim8
  let g:gtgutter_highlight_lines = 1
endif

" use custom diff sign
" if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'coc'
  " let g:gitgutter_signs                 = 0
" endif
let g:gitgutter_max_signs               = 300
let g:gitgutter_sign_added              = '✚'
let g:gitgutter_sign_removed            = '✖'
let g:gitgutter_sign_removed_first_line = '▤'
let g:gitgutter_sign_modified           = '✹'
let g:gitgutter_sign_modified_removed   = '≃'
