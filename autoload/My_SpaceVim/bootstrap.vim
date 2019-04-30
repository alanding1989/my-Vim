"================================================================================
" bootstrap.vim -- for init.toml entry
" Section: My_SpaceVim
"================================================================================
scriptencoding utf-8




function! My_SpaceVim#bootstrap#before() abort
  " vim home path
  let g:home = glob('~/.SpaceVim.d/')
  call default#load()
  auto VimEnter * call util#so_file('keymap.vim', 'SPC')
endfunction


function! My_SpaceVim#bootstrap#after() abort

endfunction
