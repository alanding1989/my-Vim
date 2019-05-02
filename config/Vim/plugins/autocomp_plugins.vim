"=========================================================================
" File Name    : config/Vim/plugins/autocomp_plugins.vim
" Author       : AlanDing
" Created Time : 2019年04月05日 星期五 23时32分41秒
"=========================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


"--------------------------------------------------------------------------------
" delimitMate settings
"--------------------------------------------------------------------------------
let g:delimitMate_autoclose = 1
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_inside_quotes = 1
let g:delimitMate_jump_expansion = 1
let g:delimitMate_balance_matchpairs = 1
" let g:delimitMate_excluded_regions = 'Comment,String'
" let g:delimitMate_excluded_ft = "mail,txt"

let g:delimitMate_matchpairs = '(:),[:],{:},<:>'
let g:delimitMate_quotes = "\" ' ` *"
let g:delimitMate_nesting_quotes = ['"','`']
" let delimitMate_smart_quotes = '\w\%#'

auto FileType c,cpp,perl        let b:delimitMate_insert_eol_marker = 2
auto FileType c,cpp,perl,scala  let b:delimitMate_eol_marker = ";"
auto FileType markdown,txt      let b:delimitMate_matchpairs = "(:),[:],{:},<:>,《:》"


"--------------------------------------------------------------------------------
" tmux-complete
"--------------------------------------------------------------------------------
let g:tmuxcomplete#asyncomplete_source_options = {
      \ 'name'     : 'tmux',
      \ 'whitelist': ['*'] ,
      \ 'config'   : {
      \     'splitmode'       : 'words',
      \     'filter_prefix'   : 1,
      \     'show_incomplete' : 1,
      \     'sort_candidates' : 0,
      \     'scrollback'      : 0,
      \     'truncate'        : 0
      \     }
    \ }


"--------------------------------------------------------------------------------
" echodoc settings
"--------------------------------------------------------------------------------
let g:echodoc#enable_at_startup = 1


"--------------------------------------------------------------------------------
" neopairs.vim
"--------------------------------------------------------------------------------
if get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet')) ==# 'neosnippet'
  let g:neopairs#enable = get(g:, 'neosnippet#enable_complete_done', 0) ? 0 : 1
else
  let g:neopairs#enable = 1
endif


"--------------------------------------------------------------------------------
" core layer settings
"--------------------------------------------------------------------------------
let g:matchup_enabled = 1
let g:matchup_surround_enabled = 1
