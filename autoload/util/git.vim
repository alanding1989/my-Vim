"================================================================================
" File Name    : autoload/util/github.vim
" Author       : AlanDing
" Created Time : Mon 03 Jun 2019 03:39:27 PM CST
" Description  : 
"================================================================================
scriptencoding utf-8



function! util#git#cache_commits() abort
  let rst = systemlist("git log --oneline -n 50 --pretty=format:'%h %s' --abbrev-commit")
  return rst
endfunction

