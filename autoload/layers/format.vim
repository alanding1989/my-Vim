"=============================================================================
" format.vim --- format Layer
" Parent Section: layers
"=============================================================================
scriptencoding utf-8


function! layers#format#plugins() abort
  return [
        \ ['neoformat/neoformat', {'merged': 0, 'loadconf': 1 , 'loadconf_before' : 1}],
        \ ]
endfunction


function! layers#format#config() abort

  nnoremap <space>bf  :Neoformat<CR>
  nnoremap <space>gf  :Neoformat<CR>

  " augroup layer_format
    " autocmd!
    " autocmd BufWritePre * undojoin | Neoformat
  " augroup END
endfunction
