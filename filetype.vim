"=========================================================================
" File Name    : filetype.vim
" Author       : AlanDing
" description  : ftdetect
" Created Time : Tue 02 Apr 2019 06:59:07 AM CST
"=========================================================================
scriptencoding utf-8



augroup my_filetype_detection
  autocmd!
  autocmd BufNewFile,BufRead *.ps1               setlocal filetype=ps1
  autocmd BufNewFile,BufRead *.spacemacs         setlocal filetype=lisp


  autocmd FileType c,cpp                         setlocal commentstring=//\ %s tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType markdown                      setlocal nowrap textwidth=120
  autocmd FileType qf                            setlocal nonumber
  autocmd FileType java,rust,html,css,styl,vue
        \ setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END



" vim:set sw=2 ts=2 sts=2 et tw=78
