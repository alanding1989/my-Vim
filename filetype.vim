"=========================================================================
" File Name    : filetype.vim
" Author       : AlanDing
" description  : ftdetect
" Created Time : Tue 02 Apr 2019 06:59:07 AM CST
"=========================================================================
scriptencoding utf-8



augroup my_filetype_detection
  autocmd!
  " autocmd BufNewFile,BufRead *.ps1               setlocal filetype=powershell
  autocmd BufNewFile,BufRead *.spacemacs         setlocal filetype=lisp


  autocmd FileType c,cpp                         setlocal commentstring=//\ %s
  autocmd FileType markdown                      setlocal nowrap textwidth=120
  " autocmd FileType qf                            setlocal nonumber

  " plantuml
  " autocmd BufRead,BufNewFile * if !did_filetype() && getline(1) =~# '@startuml\>'| setfiletype plantuml | endif
  " autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml,*.puml,*.iuml set filetype=plantuml
augroup END



" vim:set sw=2 ts=2 sts=2 et tw=78
