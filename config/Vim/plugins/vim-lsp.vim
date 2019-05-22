"================================================================================
" File Name    : config/Vim/plugins/vim-lsp.vim
" Created Time : Mon 22 Apr 2019 02:12:12 PM CST
"================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


" let g:lsp_auto_enable          = 1
let g:lsp_diagnostics_enabled  = get(g:, 'g:lsp_diagnostics_enabled', 0)
" let g:lsp_preview_keep_focus   = 1
" let g:lsp_insert_text_enabled  = 1
" let g:lsp_edit_enabled         = 1
" let g:lsp_signs_enabled        = 1
" let g:lsp_virtual_text_enabled = 1
" let g:lsp_use_event_queue      = 1
let g:lsp_async_completion       = 1


for [ft, cmds] in items(g:serverCommands)
  if index(g:My_Vim_lsp_ft, ft) > -1
    exec 'au User lsp_setup call lsp#register_server({'
          \ . "'name': 'LSP',"
          \ . "'cmd': {server_info -> " . string(cmds) . '},'
          \ . "'whitelist': ['" .  ft . "' ],"
          \ . '})'
    exec 'autocmd FileType ' . ft . ' setlocal omnifunc=lsp#complete'
  endif
endfor
