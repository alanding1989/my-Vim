"================================================================================
" File Name    : config/Vim/plugins/defx-icons.vim
" Author       : AlanDing
" mail         :
" Created Time : Sat 04 May 2019 12:45:24 AM CST
"================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1



let g:defx_icons_enable_syntax_highlight = 1
let g:column_length                      = 5
let g:mark_icon               = ''
let g:nested_closed_tree_icon = ''
let g:nested_opened_tree_icon = ''
let g:parent_icon             = get(g:, 'defx_icons_parent_icon'            , '')
let g:directory_icon          = get(g:, 'defx_icons_directory_icon'         , '')
let g:default_icon            = get(g:, 'defx_icons_default_icon'           , '')
let g:root_opened_tree_icon   = get(g:, 'defx_icons_root_opened_tree_icon'  , '')
let g:directory_symlink_icon  = get(g:, 'defx_icons_directory_symlink_icon' , '')

" let g:nested_closed_tree_icon = get(g:, 'defx_icons_nested_closed_tree_icon', '''')
" let g:nested_opened_tree_icon = get(g:, 'defx_icons_nested_opened_tree_icon', '''')
