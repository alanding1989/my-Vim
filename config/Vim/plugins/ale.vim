"================================================================================
" ale settings
"================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1



" if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplte_method', 'ncm2')) ==# 'coc'
  " auto FileType python,scala,ipynb,sh let g:ale_enabled = 0
" endif

let g:ale_echo_cursor                = 1
let g:ale_echo_delay                 = 20
let g:ale_echo_msg_format            = '%severity%: %linter%: %s'
let g:ale_virtualtext_cursor         = 1
let g:ale_virtualtext_prefix         = '❯ '
let g:ale_open_list                  = 0
let g:ale_list_window_size           = 1
let g:ale_lint_on_save               = 1
if get(g:, 'spacevim_lint_on_the_fly', get(g:, 'lint_on_the_fly', 0))
  let g:ale_lint_on_text_changed     = 'always'
  let g:ale_lint_delay               = 750
else
  let g:ale_lint_on_text_changed     = 'never'
endif
 " 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
if !g:is_win
  let g:ale_command_wrapper          = 'nice -n5'
endif


" Linter {{{
let g:ale_linters = {
      \ 'c'          : ['gcc'     , 'cppcheck'],
      \ 'cpp'        : ['gcc'     , 'cppcheck'],
      \ 'lua'        : ['luac']   ,
      \ 'go'         : ['go build', 'gofmt']   ,
      \ 'java'       : ['javac']  ,
      \ 'javascript' : ['eslint'] ,
      \ 'python'     : ['flake8'  , 'pylint']  ,
      \ 'scala'      : ['scalac'] ,
      \ 'vim'        : ['vint']   ,
      \ 'zsh'        : ['shell']  ,
      \ }
let g:ale_linter_aliases = {
      \ 'ipynb': 'python',
      \ 'sbt'  : 'scala' ,
      \ 'html' : ['html' , 'javascript', 'css'],
      \ }
let g:ale_linters.text   = ['textlint', 'write-good', 'languagetool']


" access pylint, flake8 config file
function s:lintcfg(name)
  let confp = g:home . 'extools/conf/'
  let path1 = expand(confp . a:name)
  let path2 = expand('~/.vim/linter/'. a:name)
  if filereadable(path2)
    return path2
  endif
  return shellescape(filereadable(path2)? path2 : path1)
endfunc

" set flake8/pylint, c param
let g:ale_python_flake8_options  = '--conf='.s:lintcfg('flake8.conf')
let g:ale_python_pylint_options  = '--rcfile='.s:lintcfg('pylint.conf')
let g:ale_python_pylint_options .= ' --disable=W'

let g:ale_c_gcc_options          = '-Wall -O2 -std = c99'
let g:ale_cpp_gcc_options        = '-Wall -O2 -std = c++14'
let g:ale_c_cppcheck_options     = ''
let g:ale_cpp_cppcheck_options   = ''
if !executable('gcc') && executable('clang')
  let g:ale_linters.c += ['clang']
  let g:ale_linters.cpp += ['clang']
endif
"}}}


" Lsp  {{{
" NOTE:must set lsp cmd dic
" let g:ale_completion_enabled     = 1
" let g:ale_completion_delay       = 500
" let g:ale_lsp_root               = deepcopy(g:project_root_marker)
"}}}


" Highlight sign "{{{
let g:ale_sign_column_always     = 1
let g:ale_sign_error             = '✖'
let g:ale_sign_warning           = 'ⓦ'
let g:ale_sign_info              = '➤'
augroup ALE_Settings
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
  autocmd ColorScheme *
        \ hi link ALEVirtualTextError    SpellBad  |
        \ hi link ALEVirtualTextWarning  SpellCap  |
        \ hi link ALEVirtualTextInfo     SpellRare |
        \ hi link ALEErrorSign           SpellBad  |
        \ hi link ALEWarningSign         SpellCap  |
  if get(g:, 'spacevim_colorscheme', get(g:, 'my_cs')) ==# 'gruvbox'
    autocmd ColorScheme *
          \ hi link ALEErrorSign    GruvboxRedSign |
          \ hi link ALEWarningSign  GruvboxYellowSign
  endif
  if g:is_gui
    autocmd ColorScheme *
          \ hi! clear SpellBad                     |
          \ hi! clear SpellCap                     |
          \ hi! clear SpellRare                    |
          \ hi! SpellBad  gui=undercurl guisp=red  |
          \ hi! SpellCap  gui=undercurl guisp=blue |
          \ hi! SpellRare gui=undercurl guisp=magenta
  endif
augroup END "}}}


" vim:set sw=2 ts=2 sts=2 et tw=78
