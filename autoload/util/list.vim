"================================================================================
" File Name    : autoload/util/list.vim
" Author       : AlanDing
" mail         : 
" Created Time : Tue 14 May 2019 01:16:52 PM CST
"================================================================================
scriptencoding utf-8


function! util#list#valid(...) abort
  for item in a:000
    if type(item) != type([]) || len(item) == 0
      return 0
    endif
  endfor
  return 1
endfunction
