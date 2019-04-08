"================================================================================
" functions.vim -- global func
"================================================================================
scriptencoding utf-8



function! Insert_headbox() abort " {{{
  if &ft ==# 'vim'
    call setline(line('.')   , '"'.repeat('=', 80))
    call  append(line('.')   , '"')
    call  append(line('.')+1 , '"')
    call  append(line('.')+2 , '"'.repeat('=', 80))
    call  append(line('.')+3 , '')
  elseif &ft ==# 'sh' || &ft ==# 'python'
    call setline(line('.')   , '# '.repeat('=', 80))
    call  append(line('.')   , '# ')
    call  append(line('.')+1 , '# ')
    call  append(line('.')+2 , '# '.repeat('=', 80))
    call  append(line('.')+3 , '')
  endif
  silent exec 'normal! 03j'
endfunc
function! Insert_emptybox() abort
  if &ft ==# 'vim'
    call setline(line('.')   , '"'.repeat('-', 80))
    call  append(line('.')   , '"')
    call  append(line('.')+1 , '"')
    call  append(line('.')+2 , '"'.repeat('-', 80))
    call  append(line('.')+3 , '')
  elseif &ft ==# 'sh' || &ft ==# 'python'
    call setline(line('.')   , '# '.repeat('-', 80))
    call  append(line('.')   , '# ')
    call  append(line('.')+1 , '# ')
    call  append(line('.')+2 , '# '.repeat('-', 80))
    call  append(line('.')+3 , '')
  endif
  silent exec 'normal! 03j'
endfunc
"}}}


function! SetFileHead() abort " {{{
  if &filetype ==# 'vim'
    call setline(1,          '"'.repeat('=', 80))
    call append(line('.'),   '" File Name    : '.expand('%'))
    call append(line('.')+1, '" Author       : AlanDing')
    call append(line('.')+2, '" mail         :')
    call append(line('.')+3, '" Created Time : '.strftime('%c'))
    call append(line('.')+4, '"'.repeat('=', 80))
    call append(line('.')+5, 'scriptencoding utf-8')
    call append(line('.')+6, '')
    call append(line('.')+7, '')
  elseif &filetype ==# 'sh'
    call setline(1,          '# '.repeat('=', 80))
    call append(line('.'),   '#  File Name    : '.expand('%'))
    call append(line('.')+1, '#  Author       : AlanDing')
    call append(line('.')+2, '#  mail         :')
    call append(line('.')+3, '#  Created Time : '.strftime('%c'))
    call append(line('.')+4, '# '.repeat('=', 80))
    call append(line('.')+5, '# !/usr/bin/env bash')
    call append(line('.')+6, '')
    call append(line('.')+7, '')
  elseif &filetype ==# 'python' || &filetype ==# 'ipynb'
    call setline(1,          '# '.repeat('=', 80))
    call append(line('.'),   '#  File Name    : '.expand('%'))
    call append(line('.')+1, '#  Author       : AlanDing')
    call append(line('.')+2, '#  mail         :')
    call append(line('.')+3, '#  Created Time : '.strftime('%c'))
    call append(line('.')+4, '# '.repeat('=', 80))
    call append(line('.')+5, '# !/usr/bin/env python3')
    call append(line('.')+6, '# -*- coding: utf-8 -*-')
    call append(line('.')+7, '')
    call append(line('.')+8, '')
  elseif &filetype ==# 'scala'
    call setline(1,          '/*'.repeat('=', 80))
    call append(line('.'),   '# File Name    : '.expand('%'))
    call append(line('.')+1, '# Author       : AlanDing')
    call append(line('.')+2, '# Mail         :')
    call append(line('.')+3, '# Created Time : '.strftime('%c'))
    call append(line('.')+4, repeat('=', 80).'*/')
    call append(line('.')+5, '')
    call append(line('.')+6, '')
  endif
  if &filetype ==# 'cpp'
    call append(line('.')+6, '#include<iostream>')
    call append(line('.')+7, 'using namespace std;')
    call append(line('.')+8, '')
  elseif &filetype ==# 'c'
    call append(line('.')+6, '#include<stdio.h>')
    call append(line('.')+7, '')
    call append(line('.')+8, '')
  endif
  " after creat new file, move the cursor to the last line
  silent exec 'normal! G'
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
