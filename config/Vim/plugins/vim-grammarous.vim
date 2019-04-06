"=========================================================================
" File Name    : config/Vim/plugins/vim-grammarous.vim
" Author       : AlanDing
" mail         :
" Created Time : Thu 04 Apr 2019 01:10:53 AM CST
"=========================================================================
scriptencoding utf-8



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
    nmap <buffer>[s <Plug>(grammarous-move-to-next-error)
    nmap <buffer>]s <Plug>(grammarous-move-to-previous-error)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer>[s
    nunmap <buffer>]s
endfunction
