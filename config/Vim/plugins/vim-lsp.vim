"================================================================================
" File Name    : config/Vim/plugins/vim-lsp.vim
" Created Time : Mon 22 Apr 2019 02:12:12 PM CST
"================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


let g:lsp_diagnostics_enabled  = get(g:, 'g:lsp_diagnostics_enabled', 0)
" let g:lsp_edit_enabled         = 1
let g:lsp_async_completion       = 1
