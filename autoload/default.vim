"================================================================================
" default.vim  minial settings
"================================================================================
scriptencoding utf-8



" The same configurations for SpaceVim and My Vim
function! default#load() abort
  call util#so_file('general.vim'       , 'g')
  call util#so_file('option.vim'        , 'g')
  call util#so_file('option-enhance.vim', 'g')
  call util#so_file('autocmds.vim'      , 'g')
  call util#so_file('commands.vim'      , 'g')
  call util#so_file('functions.vim'     , 'g')
  call util#so_file('highlight.vim'     , 'g')
  call mapping#basic#load()
endfunction
