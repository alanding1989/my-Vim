"================================================================================
" vimpyter
"================================================================================
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


let g:vimpyter_color = 1
" let g:vimpyter_jupyter_notebook_flags = '--browser=google --port=8855'
" let g:vimpyter_nteract_notebook_flags = '--browser=google --port=8855'
let g:vimpyter_view_directory = expand('$HOME/.cache/Vim/vimpyter_views')
