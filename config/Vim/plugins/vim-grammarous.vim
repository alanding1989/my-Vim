"=========================================================================
" File Name    : config/Vim/plugins/vim-grammarous.vim
" Author       : AlanDing
" mail         :
" Created Time : Thu 04 Apr 2019 01:10:53 AM CST
"=========================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


" Setting LanguageTool dir executable path {{{
function! s:set_languageTool() abort
  if exists('#dein')
    if g:is_spacevim
      let s:misc_path = g:spacevim_plugin_bundle_dir.'repos/github.com/rhysd/vim-grammarous/misc/'
    else
      let s:misc_path = g:My_Vim_plug_dir.'repos/github.com/rhysd/vim-grammarous/misc/'
    endif
  else
    if g:is_spacevim
      let s:misc_path = g:spacevim_plugin_bundle_dir.'vim-grammarous/misc/'
    else
      let s:misc_path = g:My_Vim_plug_dir.'vim-grammarous/misc/'
    endif
  endif

  if glob(s:misc_path) ==# ''
    call mkdir(expand(s:misc_path), 'p', 0700)
    if g:is_unix
      exec '!ln -s -d "'.expand($LANGUAGE_TOOL_HOME)
            \ .'" "'.expand(s:misc_path.'LanguageTool').'"'
    elseif g:is_win
      " TODO: fix windows
      exec '!mklink /h "'.expand(s:misc_path.'LanguageTool')
            \ .'" "'.expand('D:/devtools/LanguageTool').'"'
    endif
  endif
endfunction
"}}}
auto VimEnter * call <sid>set_languageTool()


let g:grammarous#default_comments_only_filetypes = {
            \ '*' : 1, 'help' : 0, 'markdown' : 0,
            \ }
let g:grammarous#disabled_rules = {
            \ '*' : ['WHITESPACE_RULE', 'EN_QUOTES'],
            \ 'help' : ['WHITESPACE_RULE', 'EN_QUOTES', 'SENTENCE_WHITESPACE', 'UPPERCASE_SENTENCE_START'],
            \ }
let g:grammarous#disabled_categories = {
            \ '*' : ['PUNCTUATION'],
            \ 'help' : ['PUNCTUATION', 'TYPOGRAPHY'],
            \ }

let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer>[s         <Plug>(grammarous-move-to-previous-error)
    nmap <buffer>]s         <Plug>(grammarous-move-to-next-error)
    nmap <buffer><space>ep  <Plug>(grammarous-move-to-previous-error)
    nmap <buffer><space>en  <Plug>(grammarous-move-to-next-error)
    nmap <buffer><space>el  <Plug>(grammarous-open-info-window)
    nmap <buffer><space>et  <Plug>(grammarous-reset)
    nmap <buffer><space>ef  <Plug>(grammarous-fixit)
    nmap <buffer><space>ea  <Plug>(grammarous-fixall)
    nmap <buffer>qu         ll<Plug>(grammarous-close-info-window)
    nmap <buffer><space>ee  <Plug>(grammarous-remove-error)
    nmap <buffer><space>ed  <Plug>(grammarous-disable-rule)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    unmap <buffer>[s
    unmap <buffer>]s
    unmap <buffer><space>ep
    unmap <buffer><space>en
    unmap <buffer><space>el
    unmap <buffer><space>et
    unmap <buffer><space>ef
    unmap <buffer><space>ea
    unmap <buffer>qu
    unmap <buffer><space>ee
    unmap <buffer><space>ed
endfunction
