"================================================================================
" File Name    : config/Vim/plugins/asyncomplete.vim
" Author       : AlanDing
" mail         :
" Created Time : Sat 20 Apr 2019 06:42:11 PM CST
"================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


let g:asyncomplete_auto_completeopt = 0

auto VimEnter * inoremap <expr><c-e>
      \ pumvisible() ? (g:pure_viml ?
      \ asyncomplete#cancel_popup() : "\<c-e>") : "\<end>"
