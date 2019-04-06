"=========================================================================
" File Name    : filetype.vim
" Author       : AlanDing
" description  : ftdetect
" Created Time : Tue 02 Apr 2019 06:59:07 AM CST
"=========================================================================
scriptencoding utf-8


augroup my_filetype_detection
  autocmd!
  autocmd BufNewFile,BufRead *.sbt,*.sc setlocal filetype=scala


  autocmd FileType scala    setlocal sts=4 sw=4 noet
  autocmd FileType c,cpp    setlocal commentstring=//\ %s
  autocmd FileType markdown setlocal wrap
  autocmd FileType qf       setlocal nonumber
augroup END




" vim:set sw=2 ts=2 sts=2 et tw=78
