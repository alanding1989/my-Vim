"================================================================================
" File Name    : config/highlight.vim
" Author       : AlanDing
" Created Time : Sat 25 May 2019 08:35:40 PM CST
" Description  : highlight customize
"================================================================================
scriptencoding utf-8




" Param: [guifg, guibg, ctermfg, ctermbg, italic, bold],
"        -1 if None or Negative.
let g:_defhighlight_var = { 'hlcolor' : {} }


" Default Highlight: {{{

" Util Function: {{{
function! s:addColor(dict, lang) abort
  for [key, val] in items(a:dict)
    let g:_defhighlight_var.hlcolor[a:lang][key] = val
  endfor
endfunction " }}}

" don`t change {{{
hi! clear        SpellBad
hi! clear        SpellCap
hi! clear        SpellRare
hi! clear        SpellLocal
hi! SignColumn   guibg=NONE       ctermbg=NONE
hi! LineNr       ctermfg=DarkGrey ctermbg=NONE cterm=NONE    term=bold 
hi! LineNr       guifg=DarkGrey   guibg=NONE   gui=NONE 
hi! Pmenu        guifg=black      guibg=gray   ctermfg=black ctermbg=gray  
hi! PmenuSel     guifg=brown      guibg=gray   ctermfg=gray  ctermbg=brown 
 " }}}
  
let s:general_enable_bright     = 0
let s:general_enable_darkstring = 0
let g:_defhighlight_var.hlcolor.general = extend({
      \ 'Constant'    : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \ 'String'      : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \ 'Character'   : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \
      \ 'Number'      : ['#d19a66',        -1,  -1, -1, 0, 0],
      \ 'Boolean'     : ['#d19a66',        -1,  -1, -1, 0, 0],
      \ 'Float'       : ['#d19a66',        -1,  -1, -1, 0, 0],
      \
      \ 'Function'    : ['#a3e234',        -1,  -1, -1, 0, 0],
      \
      \ 'Statement'   : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Conditional' : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Repeat'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Label'       : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Operator'    : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Keyword'     : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Exception'   : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Include'     : ['#f92672',        -1,  -1, -1, 0, 0],
      \
      \ 'Structure'   : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'StorageClass': ['#aab6e1',        -1,  -1, -1, 1, 0],
      \ }, s:general_enable_bright ? {
      \ 'Statement'   : ['#c678dd',        -1,  -1, -1, 0, 0],
      \ 'Type'        : ['#d19a66', '#3b4048',  -1, -1, 1, 0],
      \ } : {})
      " \ 'Type'        : ['#607fbf',        -1, 207, -1, 1, 0],
      " \ 'Identifier'  : ['#ffaf00',        -1, 214, -1, 0, 0],

" darker String background
let s:general_darkstring = {
      \ 'Constant'    : ['#98c379', '#3c3836',  -1, -1, 1, 0],
      \ 'String'      : ['#98c379', '#3c3836',  -1, -1, 1, 0],
      \ 'Character'   : ['#98c379', '#3c3836',  -1, -1, 1, 0],
      \ }
if s:general_enable_darkstring
  call s:addColor(s:general_darkstring, 'general')
endif
" }}}


" Language Highlight: {{{

" Python: {{{
let s:pythonClass_bright       = 0
let s:enable_python_altbuiltin = 0
let g:python_highlight_all     = g:is_vim8
let g:_defhighlight_var.hlcolor.python = extend({
      \ 'pythonStatement'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonInclude'        : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonKeyword'        : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonConditional'    : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonException'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonRepeat'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonOperator'       : ['#f92672',        -1,  -1, -1, 0, 0],
      \
      \ 'semshiImported'       : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'semshiBuiltin'        : ['#607fbf',        -1, 207, -1, 1, 0],
      \
      \ 'semshiSelf'           : ['#b2b2b2',        -1, 249, -1, 0, 0],
      \ 'semshiAttribute'      : ['#c678dd',        -1,  -1, -1, 1, 0],
      \
      \ 'pythonFunction'       : ['#a3e234',        -1,  -1, -1, 0, 0],
      \ 'pythonDecoratorName'  : ['#a3e234',        -1,  -1, -1, 1, 0],
      \
      \ 'semshiParameter'      : ['#ffaf00',        -1, 214, -1, 0, 0],
      \ 'semshiGlobal'         : ['#5fafff',        -1,  75, -1, 0, 0],
      \
      \ 'pythonString'         : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \ 'pythonRawString'      : ['#b8bb26',        -1,  -1, -1, 1, 0],
      \ 'pythonDelimiter'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Number'               : ['#d19a66',        -1,  -1, -1, 0, 0],
      \ }, g:is_vim8 ? {
      \ 'pythonClass'          : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'pythonBuiltin'        : ['#c678dd',        -1,  -1, -1, 1, 0],
      \ 'pythonClassVar'       : ['#f1747e',        -1,  -1, -1, 0, 0],
      \ 'pythonSelf'           : ['#f1747e',        -1,  -1, -1, 1, 0],
      \ 'pythonParam'          : ['#ffaf00',        -1, 214, -1, 0, 0],
      \ } : {})
let s:python_altbuiltin = {
      \ 'semshiBuiltin'        : ['#c678dd',        -1, 207, -1, 1, 0],
      \ 'semshiAttribute'      : ['#f1747e',        -1,  -1, -1, 1, 0],
      \ 'pythonDelimiter'      : ['#5fafff',        -1,  -1, -1, 0, 0],
      \ } 
let s:python_brightClass = {
      \ 'pythonClass'          : ['#56b6c2',        -1,  -1, -1, 0, 0],
      \ 'semshiImported'       : ['#56b6c2',        -1,  -1, -1, 0, 1],
      \ }

" Jupyter Notebook
let g:_defhighlight_var.hlcolor.ipynb = g:_defhighlight_var.hlcolor.python

if s:enable_python_altbuiltin
  call s:addColor(s:python_altbuiltin, 'python')
endif
if s:pythonClass_bright
  call s:addColor(s:python_brightClass, 'python')
endif

function! s:PythonSyntax() abort
  if g:is_vim8
    syn  keyword  pythonSelf         self
    syn  match    pythonBuiltin      '\v\.@<!<%(object|bool|int|float|tuple|str|list|dict|set|frozenset|bytearray|bytes)>'
    syn  match    pythonAttribute    'self\.\zs[_a-zA-Z.]*'
  endif
    syn  keyword  pythonBoolean    None False True
    syn  match    pythonDelimiter    '\V=\|-\|+\|*\|@\|/\|%\|&\||\|^\|~\|<\|>\|!='
endfunction
" }}}

" Scala: {{{
let g:_defhighlight_var.hlcolor.scala = extend({
      \ 'scalaExternal'                : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaTypeStatement'           : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaKeyword'                 : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaKeywordModifier'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaSpecialFunction'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaOperator'                : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaTypeOperator'            : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaTypeExtension'           : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaTypePostExtension'       : ['#f92672',        -1,  -1, -1, 0, 0],
      \
      \ 'scalaInstanceDeclaration'     : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'scalaTypeDeclaration'         : ['#607fbf',        -1, 207, -1, 1, 0],
      \ 'scalaInstanceHash'            : ['#607fbf',        -1, 207, -1, 1, 0],
      \ 'scalaCapitalWord'             : ['#c678dd',        -1, 176, -1, 1, 0],
      \
      \ 'scalaTypeAnnotation'          : ['#5fafff',        -1,  75, -1, 1, 0],
      \ 'scalaTypeAnnotationParameter' : ['#c678dd',        -1,  -1, -1, 1, 0],
      \
      \ 'scalaNameDefinition'          : ['#ffaf00',        -1,  -1, -1, 0, 0],
      \ 'scalaParameterAnnotation'     : ['#ffaf00',        -1, 214, -1, 0, 0],
      \ 'scalaInterpolation'           : ['#ffaf00',        -1, 214, -1, 0, 0],
      \ 'scalaFInterpolation'          : ['#ffaf00',        -1, 214, -1, 0, 0],
      \ 'scalaSymbol'                  : ['#ffaf00',        -1, 214, -1, 0, 0],
      \
      \ 'scalaString'                  : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \ 'scalaStringEmbeddedQuote'     : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \ 'scalaTripleString'            : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \ 'scalaTripleFString'           : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \ 'scalaChar'                    : ['#b8bb26',        -1,  -1, -1, 1, 0],
      \ 'scalaEscapedChar'             : ['#b8bb26',        -1,  -1, -1, 1, 0],
      \
      \ 'scalaNumber'                  : ['#d19a66',        -1,  -1, -1, 0, 0],
      \ }, {})
      " \ 'scalaSpecial'                 : ['#f92672',        -1,  -1, -1, 0, 0],
      " \ 'scalaAnnotation'              : ['#5fafff',        -1,  75, -1, 1, 0], " PreProc
      "
      " \ 'scalaCaseFollowing'           : ['#ffaf00',        -1, 214, -1, 0, 0], " Special
      " \ 'scalaUnicodeChar'             : ['#b8bb26',        -1,  -1, -1, 1, 0],
" }}}

" C Cpp: {{{
let g:_defhighlight_var.hlcolor.cpp = {
      \ 'Statement'           : ['#f92672',   -1,  -1, -1, 0, 0],
      \ 'cInclude'            : ['#f92672',   -1,  -1, -1, 0, 0],
      \ 'chromaticaKeyword'   : ['#f92672',   -1,  -1, -1, 0, 0],
      \ 'chromaticaException' : ['#f92672',   -1,  -1, -1, 0, 0],
      \ 'Repeat'              : ['#f92672',   -1,  -1, -1, 0, 0],
      \ 'Conditional'         : ['#f92672',   -1,  -1, -1, 0, 0],
      \
      \ 'Namespace'           : ['#1aa3a1',   -1,  -1, -1, 0, 1],
      \
      \ 'Type'                : ['#607fbf',   -1, 207, -1, 1, 0],
      \ 'Member'              : ['#c678dd',   -1,  -1, -1, 1, 0],
      \
      \ 'Function'            : ['#a3e234',   -1,  -1, -1, 0, 0],
      \ 'Variable'            : ['#ffaf00',   -1, 214, -1, 0, 0],
      \
      \ 'Number'              : ['#d19a66',   -1,  -1, -1, 0, 0],
      \ }
let g:_defhighlight_var.hlcolor.c = g:_defhighlight_var.hlcolor.cpp
" }}}

" Go: {{{
let g:_defhighlight_var.hlcolor.go = {
      \ 'Repeat'              : ['#f92672',   -1,  -1, -1, 0, 0],
      \ 'Conditional'         : ['#f92672',   -1,  -1, -1, 0, 0],
      \
      \ 
      \ 'goBuiltins'          : ['#1aa3a1',   -1, 207, -1, 1, 0],
      \ 'goType'              : ['#607fbf',   -1, 207, -1, 1, 0],
      \ 'goSignedInts'        : ['#607fbf',   -1, 207, -1, 1, 0],
      \ 'goUnsignedInts'      : ['#607fbf',   -1, 207, -1, 1, 0],
      \ 'goFloats'            : ['#607fbf',   -1, 207, -1, 1, 0],
      \ 'goComplexes'         : ['#607fbf',   -1, 207, -1, 1, 0],
      \ 'goExtraType'         : ['#607fbf',   -1, 207, -1, 1, 0],
      \ 'goFunctionCall'      : ['#607fbf',   -1, 207, -1, 1, 0],
      \
      \ 'goField'             : ['#c678dd',   -1,  -1, -1, 1, 0],
      \
      \ 'goFunction'          : ['#a3e234',   -1,  -1, -1, 0, 0],
      \ 'goParamName'         : ['#ffaf00',   -1, 214, -1, 0, 0],
      \ }
let g:_defhighlight_var.hlcolor.c = g:_defhighlight_var.hlcolor.cpp
" }}}
" }}}


" ColorScheme: {{{
augroup highlight_related
  auto!
  auto BufEnter * call <sid>PythonSyntax()
  autocmd ColorScheme gruvbox     hi clear Folded | hi Folded guifg=#928374 ctermfg=245
  autocmd ColorScheme nord        hi clear Folded | hi Folded guifg=#5C6370 ctermfg=59
  autocmd ColorScheme one         hi clear Folded | hi Folded guifg=#5C6370 ctermfg=59
  autocmd ColorScheme PaperColor  hi clear Folded | hi Folded guifg=#5C6370 ctermfg=59
  autocmd ColorScheme OceanicNext hi clear Folded | hi Folded guifg=#65737e ctermfg=243
        \                       | hi  Cursorline    guibg=#2c323c    ctermbg=16
  autocmd ColorScheme *           hi! MatchParen    gui=italic,bold  cterm=italic,bold
        \                       | hi! Folded        gui=italic       cterm=italic
        \                       | hi! Comment       gui=italic       cterm=italic
        \                       | hi! String        guifg=#98c379    gui=italic  cterm=italic
augroup END
" }}}


" Gui Setting Vim: {{{
if has('gui_running')
  hi! SpellBad   gui=undercurl  guisp=red
  hi! SpellCap   gui=undercurl  guisp=blue
  hi! SpellRare  gui=undercurl  guisp=magenta
  hi! SpellRare  gui=undercurl  guisp=cyan
else
  hi! SpellBad   term=underline cterm=underline term=standout ctermfg=1
  hi! SpellCap   term=underline cterm=underline
  hi! SpellRare  term=underline cterm=underline
  hi! SpellLocal term=underline cterm=underline
endif

" gui ui
if has('gui_running')
  set guioptions-=m " Hide menu bar.
  set guioptions-=T " Hide toolbar
  set guioptions-=L " Hide left-hand scrollbar
  set guioptions-=r " Hide right-hand scrollbar
  set guioptions-=b " Hide bottom scrollbar
  set showtabline=0 " Hide tabline
  set guioptions-=e " Hide tab

  if g:is_win
    set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI:qDRAFT
  elseif g:is_unix
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11
  else
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
  endif
endif
"}}}

