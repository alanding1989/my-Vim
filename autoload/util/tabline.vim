"=========================================================================
" File Name    : autoload/util/tabline.vim
" Author       : AlanDing
" mail         :
" Created Time : Wed 03 Apr 2019 02:29:50 PM CST
"=========================================================================
scriptencoding utf-8



" jump window
function! util#tabline#winjump(n) abort
  if winnr('$') >= a:n
    exec a:n.'wincmd w'
  endif
endfunction


" tabline jump {{{
let s:_altmoveignoreft = ['Tagbar', 'vimfiler', 'defx', 'vista_kind']
function! util#tabline#tabjump(num) abort
  if index(get(s:, '_altmoveignoreft' ,[]), &filetype) == -1
    if a:num ==# 'next'
      if tabpagenr('$') > 1
        tabnext
      else
        bnext
      endif
    elseif a:num ==# 'prev'
      if tabpagenr('$') > 1
        tabprevious
      else
        bprev
      endif
    else
      let ls = split(execute(':ls'), "\n")
      let buffers = []
      for b in ls
        let nr = matchstr(b, '\d\+')
        call add(buffers, nr)
      endfor
      if len(buffers) >= a:num
        exec 'buffer ' . buffers[a:num - 1]
      endif
    endif
  endif
endfunction "}}}
