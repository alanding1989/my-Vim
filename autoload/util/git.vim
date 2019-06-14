"================================================================================
" File Name    : autoload/util/github.vim
" Author       : AlanDing
" Created Time : Mon 03 Jun 2019 03:39:27 PM CST
" Description  : 
"================================================================================
scriptencoding utf-8



function! util#git#cache_commits(...) abort
  if a:0
    let dir = glob(a:1)
    if !len(glob(a:1))
      call util#echohl('invalid dirname')
      return
    endif
    let rst = systemlist('git -C '.dir." log --oneline -n 50 --pretty=format:'%h %s' --abbrev-commit")
  else
    let rst = systemlist("git log --oneline -n 50 --pretty=format:'%h %s' --abbrev-commit")
  endif
  return rst
endfunction

