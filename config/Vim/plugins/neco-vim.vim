" ================================================================================
" neco-vim settings
" ================================================================================
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


if !exists('g:necovim#complete_functions')
    let g:necovim#complete_functions = {}
endif
let g:necovim#complete_functions.Ref =
            \ 'ref#complete'
