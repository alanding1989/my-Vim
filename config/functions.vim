"================================================================================
" File Name    : config/functions.vim
" Author       : AlanDing
" Created Time : Sun 12 May 2019 09:48:38 PM CST
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
          \ a:cmsign. repeat('=', 80),
          \ a:cmsign. ' File Name    : '. expand('%'),
          \ a:cmsign. ' Author       : AlanDing',
          \ a:cmsign. ' Created Time : '. strftime('%c'),
          \ a:cmsign. repeat('=', 80),
          \ ]
    let head = &ft ==# 'sh' ? insert(head, a:head1, 0) : head
  elseif a:0 == 1
    let head = [
          \ a:1     . repeat('=', 80),
          \ a:cmsign. ' File Name    : '. expand('%'),
          \ a:cmsign. ' Author       : AlanDing',
          \ a:cmsign. ' Created Time : '. strftime('%c'),
          \ a:cmsign. repeat('=', 80). join(reverse(split(a:1)), ''),
          \ ]
  endif
  if a:head1 !=# '' && a:head2 ==# ''
    let lst = &ft ==# 'sh' ? ['', ''] : [a:head1, '', '']
    call map(lst, {key, val -> add(head, val)})
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


" Delimter edit Enhancement {{{

" Params init {{{ 
let s:withinpairs = get(b:, 'autopairs', get(g:, 'autopairs', {
      \ '('  : ')' ,
      \ '['  : ']' ,
      \ '{'  : '}' ,
      \ '<'  : '>' ,
      \ "'"  : "'" ,
      \ '"'  : '"' ,
      \ '`'  : '`' ,
      \ '*'  : '*' ,
      \ '《' : '》',
      \ }))

let s:withinquotes = get(b:, 'withinquotes', get(g:, 'autopairs', {
      \ "'"  : "'" ,
      \ '"'  : '"' ,
      \ '`'  : '`' ,
      \ '*'  : '*' ,
      \ }))
let s:emptypairs = extend(deepcopy(s:withinpairs), {'\':'\'}) 

let s:exc_rchar = ['}', ']', ')']
"}}}

function! DelEmptyPair() abort
  return (WithinEmptyPair() || (CurChar(0, '\s') && CurChar(1, '\s')))
        \ ? "\<Right>\<BS>\<BS>" : "\<BS>"
endfunction

function! ExpandEmptyPair() abort
  return WithinEmptyPair() ? "\<Space>\<Space>\<left>" : "\<Space>"
endfunction

let s:jumpsign = []
function! DirecJumpCR() abort
  if index(s:jumpsign, getline('.')[col('.')-1]) > -1

  endif
endfunction

function! AutoClo(char, ...) abort
  if a:0
    return a:char. a:1. "\<left>"
  elseif CurChar(1, a:char)
    return "\<Right>"
  elseif WithinWhat('pairs')
    return a:char
  endif
  " if CurChar(1, '\w')
  "   call mapping#util#jback()
  "   echohl WarningMsg
  "   echo ' JumpBack Mapping is ready!'
  "   echohl NONE
  "   return a:char."\<End>".a:1
  " endif
  "
  " " add Space or not
  " return  CurChar(0, '\') ? a:char : CurChar(0, '\s') ? a:char
  "       \ : ( !LeftPair() || index(s:exc_rchar, getline('.')[col('.')-2]) > -1
  "       \ ? "\<Space>".a:char : a:char )
  " return  CurChar(0, '\') ? a:char : CurChar(0, '\s')
  "       \ ? ( RightPair() ? a:char : a:char."\<Space>" )
  "       \ : ( CurChar(0, '\w') || CurChar(0, '\d') ||
  "       \ index(s:exc_rchar, getline('.')[col('.')-2]) > -1
  "       \ ? ( RightPair() ? "\<Space>".a:char : "\<Space>".a:char."\<Space>" )
  "       \ : ( RightPair() ? a:char : a:char."\<Space>" )
  "       \ )
  let autoclose = get(b:, 'autoclose', get(g:, 'autoclose', [
        \ ')' , ']' , '}' , '-' , '+' , '?' ,
        \ ]))
  return  CurChar(0, '\') ? a:char : CurChar(0, '\s')
        \ ? ( CurChar(1, '\s') ? a:char : a:char."\<Space>" )
        \ : ( index(s:exc_rchar, getline('.')[col('.')-2]) > -1
        \ ? ( CurChar(1, '\s') ? "\<Space>".a:char : "\<Space>".a:char."\<Space>" )
        \ : ( CurChar(1, '\s') ? a:char : a:char."\<Space>" )
        \ )
endfunction

" Default
" +, -, add Space after
"
" num           : done
" MatchDel char :
" AutoClo char  :
" -,
inoremap <expr> =   MatchDel('=', '\v(\=+\s\_$)\|(\>+\s\_$)\|(\<+\s\_$)\|(\++\s\_$)\|(-+\s\_$)')
inoremap <expr> #   MatchDel('#', '\v(\=+\s)\|(\=\~)\|(!\=)\|(!\~)')
inoremap <expr> >   MatchDel('>', '\v(\>+\s)\|(\=\s\_$)\|(-\s\_$)')
inoremap <expr> <   MatchDel('<', '\v^\s*(if\|el\|wh\|let)', '>')
inoremap <expr> ~   MatchDel('~', '\(=\+\s\)$')

inoremap <expr> \|  MatchDel('\|', '\|\+\s$')
inoremap <expr> &   MatchDel('&', '&\+\s$')


" MatchDel function " {{{
function! MatchDel(char, regex, ...) abort
  if WithinWhat('quotes')
    return a:0 ? a:char.a:1."\<left>" : a:char
  endif

  if match(getline('.'), a:regex) > -1
    echohl WarningMsg "{{{
    echo ' Matched'
    echohl NONE "}}}
    if a:char =~# '\d'
      return "\<BS>".a:char
    endif

    if CurChar(0, '\s')
      return CurChar(1, '\s') ? "\<BS>".a:char : "\<BS>".a:char."\<Space>"
    else
      return CurChar(1, a:char) ? a:char."\<Right>" : "\<Space>".a:char."\<Space>"
    endif
  endif

  " Echo reminder {{{
  echohl WarningMsg
  echo ' Nomatch'
  echohl NONE
  " for debug using
  " if 1
    " return a:char
  " endif "}}}

  " nomatch, but extra param " {{{
  if a:0 
    " return AutoClo(a:char, a:1)
    return "\<C-r>=AutoClo(".string(a:char).', '.string(a:1).")\<CR>"
  elseif a:char =~#  '\d' || CurChar(0, '\')
        \ || index(get(b:, 'NoAutoSpaceChar', get(g:, 'NoAutoSpaceChar', [])), a:char) > -1
    return a:char
  endif " }}}

  " char specify " {{{
  if a:char ==# '#' && match(expand('%'), 'autoload') && &ft ==# 'vim'
    return '#'
  endif " }}}

  " nomatch, noextra param " {{{
  if CurChar(0, a:char, -3)
    return "\<BS>".a:char."\<Space>"
  elseif CurChar(0, '\s')
    return RightPair() ? a:char : a:char."\<Space>"
  else
    let lchar = getline('.')[col('.') - 2]
    let exc_rchar = ['}', ']', ')']
    if CurChar(0, '\w') || CurChar(0, '\d') || index(exc_rchar, lchar) > -1
      return RightPair() ? "\<Space>".a:char : "\<Space>".a:char."\<Space>"
    else
      return RightPair() ? a:char : a:char."\<Space>"
    endif
  endif " }}}
endfunction " }}}

" check char before or after cursor {{{
function! CurChar(pos, char, ...) abort 
  " left 0, right 1
  let isregex = a:char[0] ==# '\'
  if a:pos ==# 0
    return !a:0 ? ( isregex
        \ ? getline('.')[col('.')-2] =~# a:char
        \ : getline('.')[col('.')-2] ==# a:char )
        \ : ( isregex
        \ ? getline('.')[col('.')+a:1] =~# a:char
        \ : getline('.')[col('.')+a:1] ==# a:char )
  elseif a:pos ==# 1
    return !a:0 ? ( isregex
        \ ? getline('.')[col('.')-1] =~# a:char
        \ : getline('.')[col('.')-1] ==# a:char )
        \ : ( isregex
        \ ? getline('.')[col('.')+a:1] =~# a:char
        \ : getline('.')[col('.')+a:1] ==# a:char )
  endif
endfunction " }}}

" check if cusor within pairs or quotes {{{
" param a:mode can be pairs and quotes
function! WithinWhat(mode) abort
  let pairs = a:mode ==# 'pairs'
        \ ? s:withinpairs : s:withinquotes
  let ln  = getline('.')
  let col = col('.')
  for [key, val] in items(pairs)
    if key ==# '['
      let idxstart = match(   ln, '\'.key.'.*'.val) + 1
      let idxend   = matchend(ln, '\'.key.'.*'.val)
    elseif key ==# "'"
      let idxstart = match(   ln, '"'.key.'.*'.val.'"') + 1
      let idxend   = matchend(ln, '"'.key.'.*'.val.'"')
    elseif key ==# '*'
      let idxstart = match(   ln, "'".key.'.*\'.val."'") + 1
      let idxend   = matchend(ln, "'".key.'.*\'.val."'")
    else
      " exec 'imap <expr> gh  match('.ln.', '. key .'.*'.val.')'
      let idxstart = match(   ln, key.'.*'.val) + 1
      let idxend   = matchend(ln, key.'.*'.val)
    endif
    while idxstart <= col && col <= idxend
      return 1
    endwhile
  endfor
  return 0
endfunction " }}}

" check pairs around cursor {{{
function! WithinEmptyPair() abort
  for [key, val] in items(s:emptypairs)
    while CurChar(0, key) && CurChar(1 , val)
      return 1
    endwh
  endfor
  return 0
endfunction

function! RightPair(...) abort
  let r = getline('.')[col('.') - 1]
  " default dict, or list
  if index(a:0 ? a:1 : values(s:emptypairs), r) > -1
    return 1
  endif
endfunction

function! LeftPair(...) abort
  if col('.') == 1
    return 0
  endif
  let l = getline('.')[col('.') - 2]
  " default dict, or list
  if index(a:0 ? a:1 : keys(s:emptypairs), l) > -1
    return 1
  endif
endfunction

function! s:NearPair() abort
  return RightPair() || LeftPair() ? 1 : 0
endfunction "}}}

" check curline if match pattern {{{
function! MatchCl(reg, ...) abort
  if a:0
    return match(getline(a:1), a:reg) > -1
  elseif match(getline('.'), a:reg) > -1
    echo 'match'
    return 1
  endif

  return a:0 
        \ ? match(getline(a:1), a:reg) > -1
        \ : match(getline('.'), a:reg) > -1
endfunction " }}}

" get current line char {{{
function! s:getcln(pos, ...) abort
  " a:pos, cursor pos: before 0, after 1
  " a:1, regex pattern
  let char  = getline('.')
  let col   = col('.') - 1
  let char0 = char[:col]   " include curpos
  let char1 = char[col+1:] " exinclude
  if !a:0
    return a:pos ? char1 : char0
  else
    return a:pos ? match(char1, a:1) > -1
          \ : match(char0, a:1) > -1
  endif
endfunction " }}}
"}}}


" Autoload functions wrapper " {{{
function! Statusline(name) abort
  return util#statusline#{a:name}()
endfunction 

function! UtilMap(name, ...) abort
  return a:0 ? mapping#util#{a:name}(a:1)
        \ : mapping#util#{a:name}()
endfunction
"}}}
