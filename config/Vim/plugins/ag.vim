" ================================================================================
" ag settings
" ================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


let g:ag_prg= get(g:, 'ag_prg', 'ag  --vimgrep')
let g:ag_working_path_mode= get(g:, 'ag_working_path_mode', 'r')
