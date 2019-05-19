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
  augroup layer_langtools
    autocmd!
    auto FileType Far nnoremap qq :try bd\|catch\|endtry<CR>
    auto FileType Far nnoremap Y  :Fardo<CR>
  augroup END
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
    call SpaceVim#custom#SPC('nnoremap', ['s', 'm'], 'call feedkeys(":Far ")', 
          \ 'replace symbol in multiple files', 1)
    call SpaceVim#custom#SPC('nnoremap', ['s', 'M'], 'Fardo', 
          \ 'comfirm replace symbol in multiple files', 1)
  else
    nnoremap <Space>sm :call feedkeys(':Far ')<CR>
    nnoremap <Space>sM :call feedkeys(':Fardo ')<CR>
  endif
endfunction
