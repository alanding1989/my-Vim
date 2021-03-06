"================================================================================
" File Name    : config/functions.vim
" Author       : AlanDing
" Created Time : Sun 12 May 2019 09:48:38 PM CST
"================================================================================
scriptencoding utf-8



function! Tabjump(n) abort " {{{
  call util#tabline#tabjump(a:n)
endfunction

function! Winjump(n) abort
  call util#tabline#winjump(a:n)
endfunction "}}}


function! Statusline(name) abort " {{{
  return util#statusline#{a:name}()
endfunction 
"}}}


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


" Delimiter edit Enhancement " 1{{{

" Params init 2{{{
let s:autodelimiter_debug = get(g:, 'autodelimiter_debug', 1)
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
let s:emptypairs = extend(deepcopy(s:withinpairs), {'\':'\', '\s':'\s'}) 

let s:withinquotes = get(b:, 'withinquotes', get(g:, 'autopairs', {
      \ "'"  : "'" ,
      \ '"'  : '"' ,
      \ '`'  : '`' ,
      \ '*'  : '*' ,
      \ }))

let s:exc_rchar = ['}', ']', ')']
" }}}

" AutoClo 2{{{
function! AutoClo(char, ...) abort
  if col('.') == 1
    return a:0 ? a:0 == 1
          \ ? a:char. a:1. "\<left>" : a:1
          \ : a:char. a:char. "\<left>"
  endif

  if col('.') == col('$')-1
    " at the last col
    let charnr = count(getline('.'), a:char)
    " cursor at the end of line
    if !a:0
      " signs e.g: *, ", ', `
      if fmod(charnr, 2) == 0 && !CurChar(0, a:char)
        return a:char. a:char. "\<left>"
      elseif fmod(charnr, 2) > 0
        return a:char
      endif
    else
      " signs e.g: {, ], >, (
      let a1nr = count(getline('.'), a:1)
      if charnr > a1nr
        let nr = charnr - a1nr
        return repeat(a:1, nr).repeat("\<left>", nr)
      endif
      return a:0 == 2 ? 
            \ CurChar(1, a:1) ? "\<right>" : a:1
            \ : a:char. a:1. "\<left>"
    endif
  else
    let charnr   = count(getline('.'), a:char)
    let l_charnr = count(s:getcln(0), a:char)
    " cursor is not at the end of line
    if !a:0
      " signs e.g: *, ", ', `
      if fmod(charnr, 2) == 0
        return a:char. a:char. "\<left>"
      else
        if fmod(l_charnr, 2) == 0
          return a:char. a:char. "\<left>"
        else
          return a:char
        endif
      endif
    else
      " signs e.g: {, ], >, (
      let a1nr   = count(getline('.'), a:1)
      let l_a1nr = count(s:getcln(0), a:char)
      if l_charnr == l_a1nr
        return a:0 == 2 ? a:1 : a:char.a:1."\<left>"
      elseif l_charnr > l_a1nr
        let nr = l_charnr - l_a1nr
        return a:0 == 2 
              \ ? repeat(a:1, nr).repeat("\<left>", nr)
              \ : a:char. a:1. "\<left>"
      else
        return a:0 == 2 ? a:1 : a:char. a:1. "\<left>"
      endif
    endif
  endif

  if CurChar(1, a:char)
    return "\<Right>"
  elseif Within('pair')[0]
    return a:char
  endif
  return a:char
endfunction
" get current line char {{{
function! s:getcln(pos, ...) abort
  " a:pos, cursor pos: left 0, right 1
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
" }}}

" MatchDel 2{{{
function! MatchDel(char, regex, ...) abort
  if Within('pair')
    echo 'within pair'
    return a:0 && a:1 !~? '\d' ? a:char.a:1."\<left>" : a:char
  endif

  " Matched {{{
  if match(getline('.'), a:regex) > -1
    if s:autodelimiter_debug "{{{
      call util#echohl('Matched')
    endif "}}}
    if a:char =~# '\d'
      return "\<BS>".a:char
    endif

    if CurChar(0, '\s')
      return CurChar(1, '\s') ? "\<BS>".a:char : "\<BS>".a:char."\<Space>"
    elseif a:char ==? '!' || a:char ==? '-'
      return CurChar(0, '\w') ? "\<Space>".a:char : a:char
    else
      return CurChar(0, '\w') ? "\<Space>".a:char."\<Space>" : a:char."\<Space>"
    endif
  endif " }}}

  " Nomatch Echo reminder {{{
  if s:autodelimiter_debug
    call util#echohl('Nomatch')
  endif
  "}}}

  if a:0 && a:1 !~# '\d'
    return a:char =~# '<' 
          \ ? "\<C-r>=AutoClo(".string(a:char).', '.string(a:1).")\<CR>"
          \ : "\<C-r>=AutoClo(".string(a:char).', '.string(a:1).", 1)\<CR>"
  elseif CurChar(0, '\') || a:char =~# '\d' || a:char =~# '\w'
    return a:char
  endif

  " Nomatch, noextra param " {{{
  if CurChar(0, a:char)
    " before is operator itself
    return CurChar(1, '\s') ? a:char : a:char."\<Space>"
  elseif CurChar(0, '\s')
    " before is space
    if CurChar(0, a:char, -3)
      return "\<BS>".a:char."\<Space>"
    elseif a:0 && a:1 ==# '1'
      return CurChar(1, '\s') ? a:char : a:char."\<Space>"
    elseif a:0 && a:1 ==# '0'
      return a:char
    endif
  elseif a:0 && a:0 == 2 && CurChar(0, '\w')
    " before is word character
    if a:2 ==# '11'
      return CurChar(1, '\s') ? "\<Space>".a:char : "\<Space>".a:char."\<Space>"
    elseif a:2 ==# '10'
      return "\<Space>".a:char
    elseif a:2 ==# '01'
      return CurChar(1, '\s') ? a:char : a:char."\<Space>"
    elseif a:2 ==# '00'
      return a:char
    endif
  else
    " before is sign operator
    return CurChar(0, '\W') && !CurChar(0, '!')
          \ ? CurChar(1, '\s') ? "\<Space>".a:char : "\<Space>".a:char."\<Space>"
          \ : CurChar(1, '\s') ? a:char : a:char."\<Space>"
  endif " }}}
endfunction " }}}

" EmptyPair 2{{{
function! DelEmptyPair() abort
  return WithinEmptyPair() ? "\<Right>\<BS>\<BS>" : "\<BS>"
endfunction

function! ExpandEmptyPair() abort
  return WithinEmptyPair() ? "\<Space>\<Space>\<left>" : "\<Space>"
endfunction " }}}

" Utils 2{{{
" check char before or after cursor {{{
function! CurChar(pos, char, ...) abort 
  " args: 
  " char character under cursor
  " pos  left 0, right 1, 
  " a:1  pos offset
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
function! Within(mode, ...)abort
  " param a:mode can be pair and quote
  " if a:1 provided, return list contain [1, pair]
  let pairs = a:mode ==# 'pair' ? s:withinpairs
        \   : a:mode ==# 'emptypair' ? s:emptypairs
        \   : s:withinquotes
  let ln  = getline('.')
  let col = col('.')
  if col == 1
    return a:0 && a:1 == 1 ? [0, 0] : 0
  endif
  for [l, r] in items(pairs)
    if l ==# '['
      let str   = matchstrpos(ln, '\'.l.'.*'.r)
      let idxstart = str[1]
      let idxend   = str[2]
    elseif l ==# '*'
      let str   = matchstrpos(ln, '\'.l.'.*\'.r)
      let idxstart = str[1]
      let idxend   = str[2]
    else
      let str   = matchstrpos(ln, l.'.*'.r)
      let idxstart = str[1]
      let idxend   = str[2]
    endif
    while idxstart<= col && col<= idxend

      return a:0 && a:1 == 1 ? [1, l]: 1
    endwhile
  endfor
  return a:0 && a:1 == 1 ? [0, 0] : 0
endfunction

if s:autodelimiter_debug
  " debug use
  " inoremap <expr> g9 Within('pair', 1)[0] ? 'within' : '0000'
  " inoremap g7 <esc>:echo matchstrpos(   getline('.'), '(.*)')<CR>
  " inoremap g8 <esc>:echo matchend(getline('.'), '.*\')
endif 
" function! Within(mode, ...)abort " {{{
"   " param a:mode can be pair and quote
"   let pairs = a:mode ==# 'pair' ? s:withinpairs
"         \   : a:mode ==# 'emptypair' ? s:emptypairs
"         \   : s:withinquotes
"   let ln  = getline('.')
"   let g:col = col('.')
"   if g:col == 1
"     return a:0 && a:1 == 1 ? [0, 0] : 0
"   endif
"   for [l, r] in items(pairs)
"     if l ==# '['
"       let g:str   = matchstrpos(ln, '\'.l.'.*'.r)
"       let g:idxstart = g:str[1]
"       let g:idxend   = g:str[2]
"     elseif l ==# '*'
"       let g:str   = matchstrpos(ln, '\'.l.'.*\'.r)
"       let g:idxstart = g:str[1]
"       let g:idxend   = g:str[2]
"     else
"       let g:str   = matchstrpos(ln, l.'.*'.r)
"       let g:idxstart = g:str[1]
"       let g:idxend   = g:str[2]
"     endif
"     if g:idxstart < g:col && g:col < g:idxend
"       let g:strl = split(g:str[0][:g:col-g:idxstart-2], '\zs')
"       let g:countl = count(g:strl, l)
"       let g:countr = count(g:strl, r)
"       let g:mod    = fmod(count(g:str, l), 2)
"       if g:countl != g:countr && g:mod == 0
"         let g:within = [1, l]
"         break
"       endif
"     endif
"   endfor
"   if get(g:, 'within', [0, 0])[0]
"     return a:0 && a:1 == 1 ? g:within : 1
"   else
"     return a:0 && a:1 == 1 ? [0, 0] : 0
"   endif
" endfunction
"  " }}}
"  " }}}

" check pairs around cursor {{{
function! WithinEmptyPair() abort
  for [l, r] in items(s:emptypairs)
    while CurChar(0, l) && CurChar(1 , r)
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
  return 0
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
  return 0
endfunction
"}}}

" check curline match pattern or not {{{
function! MatchCl(reg, ...) abort
  if !a:0 && match(getline('.'), a:reg) > -1
    if s:autodelimiter_debug
      echo 'matched'
    endif
    return 1
  elseif a:0 && a:1 ==# 1
    let res = matchstr(getline('.'), a:reg)
    if s:autodelimiter_debug
      echo res
    endif
    return len(res) ? [1, res] : [0, '']
  endif
  return 0
endfunction " }}}
" }}}
" 1}}}

