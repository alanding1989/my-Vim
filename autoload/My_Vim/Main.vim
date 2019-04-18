" ================================================================================
" My_Vim.vim
" Core file of my vimrc
" ================================================================================
scriptencoding utf-8



" init
function! My_Vim#Main#init() abort
  call util#so_file('config.vim', 'Vim')
  try
    call s:Mainbegin()
  catch
    call s:Mainfallback()
  endtry
endfunction


function! s:Mainbegin() abort
  call My_Vim#layer#plug_begin()
  call My_Vim#layer#plug_end()
endfunction

function! s:Mainfallback() abort
  let g:my_cs = 'nord'
  let g:My_Vim_layers = {}
  call My_Vim#layer#plug_begin()
  call My_Vim#layer#plug_end()
endfunction
