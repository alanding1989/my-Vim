"================================================================================
" File Name    : config/highlight.vim
" Author       : AlanDing
" Created Time : Sat 25 May 2019 08:35:40 PM CST
" Description  : highlight customize
"================================================================================
scriptencoding utf-8


" [ guifg, guibg, ctermfg, ctermbg, italic, bold],
" -1 if None or Negative.

let g:_defhighlight_var = { 'hlcolor' : {} }


" Python: {{{
" let g:python_highlight_all = 1
let g:_defhighlight_var.hlcolor.python = extend({
      \ 'pythonStatement'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonKeyword'        : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonOperator'       : ['#f92672',        -1,  -1, -1, 0, 0],
      \
      \ 'semshiImported'       : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'semshiBuiltin'        : ['#1aa3a1',        -1,  -1, -1, 1, 0],
      \
      \ 'semshiSelf'           : ['#b467aa',        -1,  -1, -1, 1, 0],
      \ 'semshiAttribute'      : ['#c6c071',        -1,  -1, -1, 0, 0],
      \
      \ 'pythonFunction'       : ['#a3e234',        -1,  -1, -1, 0, 0],
      \ 'pythonDecoratorName'  : ['#a3e234',        -1,  -1, -1, 1, 0],
      \
      \ 'semshiParameter'      : ['#e06c75',        -1,  -1, -1, 0, 0],
      \
      \ 'pythonString'         : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \ 'pythonRawString'      : ['#b8bb26',        -1,  -1, -1, 1, 0],
      \
      \ 'pythonDelimiter'      : ['#5fafff',        -1,  -1, -1, 0, 0],
      \ 'Number'               : ['#d19a66',        -1,  -1, -1, 0, 0],
      \ 'StorageClass'         : ['#aab6e1',        -1,  -1, -1, 1, 0],
      \ }, g:is_vim8 || 1 ? {
      \ 'pythonInclude'        : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonConditional'    : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonException'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonRepeat'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \
      \ 'pythonClass'          : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'pythonBuiltin'        : ['#1aa3a1',        -1,  -1, -1, 1, 0],
      \ 'pythonClassVar'       : ['#b467aa',        -1,  -1, -1, 0, 0],
      \ 'pythonSelf'           : ['#b467aa',        -1,  -1, -1, 1, 0],
      \ 'pythonAttribute'      : ['#c6c071',        -1,  -1, -1, 0, 0],
      \ 'pythonParam'          : ['#e06c75',        -1,  -1, -1, 0, 0],
      \ } : {})
      " \ 'Statement'            : ['#c678dd',        -1,  -1, -1, 0, 1],  " default purple
      " \ 'Define'               : ['#c678dd',        -1,  -1, -1, 1, 0],
      " \ 'function'             : ['#a3e234',        -1,  73, -1, 0, 0],  " grass green
      " \ 'String'               : ['#98c379',        -1,  -1, -1, 1, 0],  " light green
      " \ 'String'               : ['#98c379', '#3b4048',  -1, -1, 1, 0],  " light green, white bg 
      " \ 'Type'                 : ['#d19a66', '#3e4452',  -1, -1, 0, 1],
      " \
      " blue
      " \ 'semshiParameter'      : ['#5fafff',        -1,  -1, -1, 1, 0],
      " \ 'pythonParam'          : ['#5fafff',        -1,  -1, -1, 1, 0],
      " brighter one
      " \ 'pythonClass'          : ['#56b6c2',        -1,  -1, -1, 0, 0],
      " \ 'semshiImported'       : ['#56b6c2',        -1,  -1, -1, 0, 1],
function! s:python() abort
  syn  keyword  pythonSelf         self
  syn  keyword  pythonStatement    None False True
  syn  match    pythonBuiltin      '\v\.@<!<%(object|bool|int|float|tuple|str|list|dict|set|frozenset|bytearray|bytes)>'
  syn  match    pythonAttribute    'self\.\zs[_a-zA-Z.]*\>'
  syn  match    pythonDelimiter    '\V=\|-\|+\|*\|@\|/\|%\|&\||\|^\|~\|<\|>\|!='
endfunction
auto VimEnter * auto FileType python call <sid>python()
" }}}
