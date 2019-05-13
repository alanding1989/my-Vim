"================================================================================
" File Name    : autoload/My_Vim/layer.vim
" Author       : AlanDing
" mail         :
" Created Time : Mon 13 May 2019 10:11:42 PM CST
"================================================================================
scriptencoding utf-8


let s:enabled_layers = []
let s:layers_vars = {}


function! My_Vim#layer#load(layer, ...) abort
  if index(s:enabled_layers, a:layer) == -1
    call add(s:enabled_layers, a:layer)
  endif
  if a:0 == 1 && type(a:1) == 4
    try
      call layers#{a:layer}#set_variable(a:1)
      let s:layers_vars[a:layer] = a:1
    catch /^Vim\%((\a\+)\)\=:E117/
    endtry
  endif
  if a:0 > 0 && type(a:1) == 1 
    for layer in a:000
      call My_Vim#layer#load(layer)
    endfor
  endif
endfunction


function! My_Vim#layer#isLoaded(name) abort
  return index(g:enabled_layers, a:name) != -1
endfunction
"}}}
