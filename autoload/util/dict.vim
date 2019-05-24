"================================================================================
" File Name    : autoload/util/dict.vim
" Author       : AlanDing
" Created Time : Mon 13 May 2019 11:27:37 PM CST
"================================================================================
scriptencoding utf-8


function! util#dict#valid(...) abort
  for item in a:000
    if type(item) != type({}) || len(item) == 0
      return 0
    endif
  endfor
  return 1
endfunction
