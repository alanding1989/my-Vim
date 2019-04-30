"================================================================================
" File Name    : config/functions.vim
" Author       : AlanDing
" mail         :
" Created Time : Tue 30 Apr 2019 10:56:20 PM CST
"================================================================================
scriptencoding utf-8



function! Insert_headbox() abort " {{{
  if &ft ==# 'vim'
    call s:inshbox('"', '=')
  elseif &ft ==# 'sh' || &ft ==# 'python' || &ft ==# 'ps1'
    call s:inshbox('# ', '=')
  elseif &ft ==# 'scala' || &ft ==# 'cpp' || &ft ==# 'c'
    call s:inshbox('//', '=')
  endif
endfunc
function! Insert_emptybox() abort
  if &ft ==# 'vim'
    call s:inshbox('"', '-')
  elseif &ft ==# 'sh' || &ft ==# 'python' || &ft ==# 'ps1'
    call s:inshbox('# ', '-')
  elseif &ft ==# 'scala' || &ft ==# 'cpp' || &ft ==# 'c'
    call s:inshbox('//', '-')
  endif
endfunc

function! s:inshbox(cmsign, reptsign) abort
  call setline(line('.')   , a:cmsign.repeat(a:reptsign, 80))
  call  append(line('.')   , a:cmsign)
  call  append(line('.')+1 , a:cmsign)
  call  append(line('.')+2 , a:cmsign.repeat(a:reptsign, 80))
  call  append(line('.')+3 , '')
  silent exec 'normal! 03j'
endfunc
"}}}


function! SetFileHead() abort " {{{
  if &filetype ==# 'vim'
    call s:insfhead('"', 'scriptencoding utf-8', '')

  elseif &filetype ==# 'sh'
    call s:insfhead('#', '#! /usr/bin/env bash', '')

  elseif &filetype ==# 'ps1'
    call s:insfhead('#', '', '')

  elseif &filetype ==# 'python' || &filetype ==# 'ipynb'
    call s:insfhead('#', '#! /usr/bin/env python3', '# -*- coding: utf-8 -*-')

  elseif &filetype ==# 'scala'
    call s:insfhead('', '', '', '/*', '*/')

  elseif &filetype ==# 'cpp'
    call s:insfhead('', '#include <iostream>', 'using namespace std;', '/*', '*/')

  elseif &filetype ==# 'c'
    call s:insfhead('', '#include <stdio.h>', '', '/*', '*/')
  endif
endfunc

function! s:insfhead(cmsign, head1, head2, ...) abort
  if a:0 == 0
    call setline(1,          a:cmsign.repeat('=', 80))
    call append(line('.'),   a:cmsign.' File Name    : '.expand('%'))
    call append(line('.')+1, a:cmsign.' Author       : AlanDing')
    call append(line('.')+2, a:cmsign.' mail         :')
    call append(line('.')+3, a:cmsign.' Created Time : '.strftime('%c'))
    call append(line('.')+4, a:cmsign.repeat('=', 80))
  elseif a:0 == 2
    call setline(1,          a:1.repeat('=', 80))
    call append(line('.'),   a:cmsign.' File Name    : '.expand('%'))
    call append(line('.')+1, a:cmsign.' Author       : AlanDing')
    call append(line('.')+2, a:cmsign.' mail         :')
    call append(line('.')+3, a:cmsign.' Created Time : '.strftime('%c'))
    call append(line('.')+4, a:cmsign.repeat('=', 78).a:2)
  endif
  if a:head1 !=# '' && a:head2 ==# ''
    call append(line('.')+5, a:head1)
    call append(line('.')+6, '')
    call append(line('.')+7, '')
  elseif a:head2 !=# ''
    call append(line('.')+5, a:head1)
    call append(line('.')+6, a:head2)
    call append(line('.')+7, '')
    call append(line('.')+8, '')
  else
    call append(line('.')+5, '')
    call append(line('.')+6, '')
  endif
  silent exec 'normal! 08j'
endfunc "}}}


function! Foldtext() abort " {{{
  " get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~# '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let foldsymbol='+F'
  let repeatsymbol=''
  let prefix = foldsymbol . ' '

  let w = winwidth(0) - &foldcolumn - (&number ? 20 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = ' ' . foldSize . ' lines '
  let foldLevelStr = repeat('+--', v:foldlevel)
  let lineCount = line('$')
  let foldPercentage = printf('[%.1f', (foldSize*1.0)/lineCount*100) . '%] '
  let expansionString = repeat(repeatsymbol, w - strwidth(prefix.foldSizeStr.line.foldLevelStr.foldPercentage))
  return prefix . line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction "}}}


function! Tabjump(n) abort "{{{
  call util#tabline#tabjump(a:n)
endfunction

function! Winjump(n) abort
  call util#tabline#winjump(a:n)
endfunction "}}}
