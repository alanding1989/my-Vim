"================================================================================
" File Name    : autoload/My_Vim/layer.vim
" Author       : AlanDing
" mail         :
" Created Time : Mon 13 May 2019 10:11:42 PM CST
"================================================================================
scriptencoding utf-8


let s:enabled_layers = []
let s:layers_vars = {}


function! My_Vim#layer#isLoaded(name) abort
  return index(g:enabled_layers, a:name) != -1
endfunction
