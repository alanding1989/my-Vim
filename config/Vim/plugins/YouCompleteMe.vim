"=========================================================================
" File Name    : config/Vim/plugins/YouCompleteMe.vim
" Author       : AlanDing
" Created Time : Wed 03 Apr 2019 11:08:02 PM CST
"=========================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1



let g:ycm_add_preview_to_completeopt                    = 0
let g:ycm_show_diagnostics_ui                           = 0
let g:ycm_server_log_level                              = 'info'
let g:ycm_min_num_identifier_candidate_chars            = 2
let g:ycm_seed_identifiers_with_syntax                  = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files           = 1
let g:ycm_complete_in_strings                           = 1
let g:ycm_key_invoke_completion                         = '<C-Space>'
let g:ycm_key_list_select_completion                    = []
let g:ycm_key_list_previous_completion                  = []


" auto trigger complete with input 2 char
let g:ycm_semantic_triggers =  {
      \ 'c,cpp,python,java,scala,go,erlang,perl': ['re!\w{2}'],
      \ 'vim,cs,lua,javascript': ['re!\w{2}'],
      \ }


" g:ycm_filetype_whitelist {{{
let g:ycm_filetype_whitelist = {
      \ 'c'          : 1,
      \ 'cpp'        : 1,
      \ 'objc'       : 1,
      \ 'objcpp'     : 1,
      \ 'python'     : 1,
      \ 'java'       : 1,
      \ 'javascript' : 1,
      \ 'coffee'     : 1,
      \ 'vim'        : 1,
      \ 'go'         : 1,
      \ 'cs'         : 1,
      \ 'lua'        : 1,
      \ 'perl'       : 1,
      \ 'perl6'      : 1,
      \ 'php'        : 1,
      \ 'ruby'       : 1,
      \ 'rust'       : 1,
      \ 'erlang'     : 1,
      \ 'asm'        : 1,
      \ 'nasm'       : 1,
      \ 'masm'       : 1,
      \ 'tasm'       : 1,
      \ 'asm68k'     : 1,
      \ 'asmh8300'   : 1,
      \ 'asciidoc'   : 1,
      \ 'basic'      : 1,
      \ 'vb'         : 1,
      \ 'make'       : 1,
      \ 'cmake'      : 1,
      \ 'html'       : 1,
      \ 'css'        : 1,
      \ 'less'       : 1,
      \ 'json'       : 1,
      \ 'cson'       : 1,
      \ 'typedscript': 1,
      \ 'haskell'    : 1,
      \ 'lhaskell'   : 1,
      \ 'lisp'       : 1,
      \ 'scheme'     : 1,
      \ 'sdl'        : 1,
      \ 'sh'         : 1,
      \ 'zsh'        : 1,
      \ 'bash'       : 1,
      \ 'man'        : 1,
      \ 'markdown'   : 1,
      \ 'matlab'     : 1,
      \ 'maxima'     : 1,
      \ 'dosini'     : 1,
      \ 'conf'       : 1,
      \ 'config'     : 1,
      \ 'zimbu'      : 1,
      \ 'ps1'        : 1,
      \ }
"}}}
