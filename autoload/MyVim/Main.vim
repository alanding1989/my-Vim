" ================================================================================
" MyVim.vim
" Core file of my vimrc
" ================================================================================
scriptencoding utf-8



" init
function! MyVim#Main#init() abort
  call util#so_file('config.vim', 'Vim')
  " try
    call s:Mainbegin()
  " catch
    " call s:Mainfallback()
  " endtry
endfunction


function! s:Mainbegin() abort
  call MyVim#plugin#begin()
  call MyVim#plugin#end()
endfunction

function! s:Mainfallback() abort
  let s:is_fallback = 1
  let g:my_cs = 'nord'
  let g:MyVim_layers = {}
  call MyVim#plugin#begin()
  call MyVim#plugin#end()
endfunction

function! MyVim#Main#isfallback() abort
  return get(s:, 'is_fallback', 0)
endfunction
