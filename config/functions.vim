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
  call  append(line('.')+1 , a:cmsign.repeat(a:reptsign, 80))
  call  append(line('.')+2 , '')
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
    call s:insfhead('#', '', '', '/*')

  elseif &filetype ==# 'cpp'
    call s:insfhead('#', '#include <iostream>', 'using namespace std;', '/*')

  elseif &filetype ==# 'c'
    call s:insfhead('#', '#include <stdio.h>', '', '/*')
  endif
endfunc

function! s:insfhead(cmsign, head1, head2, ...) abort
  if a:0 == 0
    let head = [
          \ (&ft ==# 'sh' ? a:head1 : ''),
          \ a:cmsign. repeat('=', 80),
          \ a:cmsign. ' File Name    : '. expand('%'),
          \ a:cmsign. ' Author       : AlanDing',
          \ a:cmsign. ' mail         : ',
          \ a:cmsign. ' Created Time : '. strftime('%c'),
          \ a:cmsign. repeat('=', 80),
          \ ]
  elseif a:0 == 1
    let head = [
          \ a:1     . repeat('=', 80),
          \ a:cmsign. ' File Name    : '. expand('%'),
          \ a:cmsign. ' Author       : AlanDing',
          \ a:cmsign. ' mail         : ',
          \ a:cmsign. ' Created Time : '. strftime('%c'),
          \ a:cmsign. repeat('=', 80). join(reverse(split(a:1)), ''),
          \ ]
  endif
  if a:head1 !=# '' && a:head2 ==# ''
    call map([&ft ==# 'sh' ? '' : a:head1, '', ''], {key, val -> add(head, val)})
  elseif a:head2 !=# ''
    call map([a:head1, a:head2, '', ''], {key, val -> add(head, val)})
  else
    call map(['', ''], {key, val -> add(head, val)})
  endif
  call setline(1, head)
  call setpos('.', [0, len(head), 1])
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


function! Tabjump(n) abort " {{{
  call util#tabline#tabjump(a:n)
endfunction

function! Winjump(n) abort
  call util#tabline#winjump(a:n)
endfunction "}}}


function! Statusline(name) abort " {{{
  return util#statusline#{a:name}()
endfunction "}}}
