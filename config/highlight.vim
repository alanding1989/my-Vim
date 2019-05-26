"================================================================================
" File Name    : config/highlight.vim
" Author       : AlanDing
" Created Time : Sat 25 May 2019 08:35:40 PM CST
" Description  : highlight customize
"================================================================================
scriptencoding utf-8



" Language Highlight: {{{

"    Param: [guifg, guibg, ctermfg, ctermbg, italic, bold],
"           -1 if None or Negative.
let g:_defhighlight_var = { 'hlcolor' : {} }


" Python: {{{
let g:python_highlight_all = 1
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
      " blue
      " \ 'semshiParameter'      : ['#5fafff',        -1,  -1, -1, 1, 0],
      " \ 'pythonParam'          : ['#5fafff',        -1,  -1, -1, 1, 0],
      " brighter one
      " \ 'pythonClass'          : ['#56b6c2',        -1,  -1, -1, 0, 0],
      " \ 'semshiImported'       : ['#56b6c2',        -1,  -1, -1, 0, 1],
function! s:PythonSyntax() abort
  if g:is_vim8
    syn  keyword  pythonSelf         self
    syn  keyword  pythonStatement    None False True
    syn  match    pythonBuiltin      '\v\.@<!<%(object|bool|int|float|tuple|str|list|dict|set|frozenset|bytearray|bytes)>'
    syn  match    pythonAttribute    'self\.\zs[_a-zA-Z.]*'
  endif
    syn  match    pythonDelimiter    '\V=\|-\|+\|*\|@\|/\|%\|&\||\|^\|~\|<\|>\|!='
endfunction
" }}}
" }}}


" ColorScheme: {{{
augroup highlight_related
  auto!
  autocmd VimEnter *  auto FileType python call <sid>PythonSyntax()
  autocmd ColorScheme one         hi clear Folded | hi Folded guifg=#5C6370 ctermfg=59
  autocmd ColorScheme PaperColor  hi clear Folded | hi Folded guifg=#5C6370 ctermfg=59
  autocmd ColorScheme gruvbox     hi clear Folded | hi Folded guifg=#928374 ctermfg=245
  autocmd ColorScheme OceanicNext hi clear Folded | hi Folded guifg=#65737e ctermfg=243
        \                       | hi  Cursorline    guibg=#2c323c    ctermbg=16
  autocmd ColorScheme *           hi! MatchParen    gui=italic,bold  cterm=italic,bold
        \                       | hi! Folded        gui=italic       cterm=italic
        \                       | hi! Comment       gui=italic       cterm=italic
        \                       | hi! String        guifg=#98c379    guibg=#3c3836  gui=italic  cterm=italic
        \                       | hi! storageclass  guifg=#aab6e1                   gui=italic  cterm=italic
        " \                       | hi! clear Statement | hi! Statement     guifg=#f92672                                            " default purple
        " \                       | hi! function      guifg=#a3e234    ctermfg = 73
        " \                       | hi! Statement     guifg=#c678dd                                             " grass green
        " \                       | hi! Define        guifg=#c678dd                   gui=italic  cterm=italic  " light green
        " \                       | hi! Type          guifg=#d19a66    guibg=#3e4452  gui=italic  cterm=italic  " light green, white bg
        " \                       | hi! String        guifg=#98c379    guibg=#3b4048  gui=italic  cterm=italic
augroup END
" }}}


" Default Highlight: {{{
hi! clear        SpellBad
hi! clear        SpellCap
hi! clear        SpellRare
hi! clear        SpellLocal
hi! SignColumn   guibg=NONE       ctermbg=NONE
hi! LineNr       ctermfg=DarkGrey ctermbg=NONE cterm=NONE    term=bold 
hi! LineNr       guifg=DarkGrey   guibg=NONE   gui=NONE 
hi! Pmenu        guifg=black      guibg=gray   ctermfg=black ctermbg=gray  
hi! PmenuSel     guifg=brown      guibg=gray   ctermfg=gray  ctermbg=brown 
"}}}


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
