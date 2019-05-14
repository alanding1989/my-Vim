"=============================================================================
" langtools.vim --- langtools layer
" Parent Section: layers
"=============================================================================
scriptencoding utf-8


function! layers#langtools#plugins() abort
  let plugins = [
      \ ['metakirby5/codi.vim', {'on_cmd': 'Codi', 'on': 'Codi'}],
      \ ['brooth/far.vim',      {'on_cmd': ['Far', 'Fardo'], 'on': ['Far', 'Fardo']}],
      \ ]
  return plugins
endfunction


function! layers#langtools#config() abort
  call s:codi()
  call s:far()

endfunction


function! s:codi() abort
  if g:is_spacevim
    let g:_spacevim_mappings.l = {'name': '+@ Language tools' }
    call SpaceVim#mapping#def('noremap', '<leader>lc', ':Codi!! ',
          \ 'toggle codi for current buffer', '', 'toggle codi for current buffer')
  else
    noremap <leader>lc :Codi!!
  endif
endfunction

function! s:far() abort
  if g:is_spacevim
    call SpaceVim#custom#SPC('nnoremap', ['s', 'a'], 'call feedkeys(":Far ")', 
          \ 'replace symbol in multiple files', 1)
  else
    nnoremap <Space>sa :call feedkeys(':Far ')<CR>
  endif
endfunction
