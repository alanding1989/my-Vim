"=============================================================================
" python.vim --- lang#python layer
" Parent Section: layers
"=============================================================================
scriptencoding utf-8


function! layers#lang#python#plugins() abort
  let plugins = []
  call add(plugins, ['jeetsukumaran/vim-pythonsense', 
        \ {'on_ft': 'python', 'for': 'python'}])
  if g:is_nvim
    call add(plugins, ['numirias/semshi', {'on_ft': 'python', 'for': 'python'}])
  else
    call add(plugins, ['vim-python/python-syntax', {'on_ft': 'python', 'for': 'python'}])
  endif
  if !g:is_spacevim
    if g:My_Vim_layers['lsp'] != 1
      if has('nvim')
        call add(plugins, ['zchee/deoplete-jedi', {'on_ft': 'python', 'for': 'python'}])
        " in neovim, we can use deoplete-jedi together with jedi-vim,
        " but we need to disable the completions of jedi-vim.
        let g:jedi#completions_enabled = 0
      endif
      call add(plugins, ['davidhalter/jedi-vim', {'on_ft': 'python', 'for': 'python',
            \ 'if' : g:has_py}])
    endif
    call add(plugins, ['heavenshell/vim-pydocstring',
          \ {'on_cmd' : 'Pydocstring'}])
    call add(plugins, ['Vimjas/vim-python-pep8-indent',
          \ {'on_ft' : 'python', 'for': 'python'}])
  endif
  return plugins
endfunction

function! layers#lang#python#config() abort
  " heavenshell/vim-pydocstring {{{

  " If you execute :Pydocstring at no `def`, `class` line.
  " g:pydocstring_enable_comment enable to put comment.txt value.
  let g:pydocstring_enable_comment = 0

  " Disable this option to prevent pydocstring from creating any
  " key mapping to the `:Pydocstring` command.
  " Note: this value is overridden if you explicitly create a
  " mapping in your vimrc, such as if you do:
  let g:pydocstring_enable_mapping = 0

  " }}}

  " call plugins#runner#reg_runner('python',
  " \ {
  " \ 'exe' : function('s:getexe'),
  " \ 'opt' : ['-'],
  " \ 'usestdin' : 1,
  " \ })
  " call mapping#gd#add('python', function('s:go_to_def'))
  " call mapping#space#regesit_lang_mappings('python', function('s:language_specified_mappings'))
  " call layers#edit#add_ft_head_tamplate('python',
  " \ ['#!/usr/bin/env python',
  " \ '# -*- coding: utf-8 -*-',
  " \ '']
  " \ )
  " if executable('ipython')
  " call plugins#repl#reg('python', 'ipython --no-term-title')
  " elseif executable('python')
  " call plugins#repl#reg('python', ['python', '-i'])
  " endif
endfunction

function! s:language_specified_mappings() abort
  call mapping#space#langSPC('nmap', ['l','r'],
        \ 'call plugins#runner#open()',
        \ 'execute current file', 1)
  let g:_spacevim_mappings_space.l.i = {'name' : '+Imports'}
  call mapping#space#langSPC('nmap', ['l','i', 's'],
        \ 'Neoformat isort',
        \ 'sort imports', 1)
  call mapping#space#langSPC('nmap', ['l','i', 'r'],
        \ 'Neoformat autoflake',
        \ 'remove unused imports', 1)
  let g:_spacevim_mappings_space.l.s = {'name' : '+Send'}
  call mapping#space#langSPC('nmap', ['l','s', 'i'],
        \ 'call plugins#repl#start("python")',
        \ 'start REPL process', 1)
  call mapping#space#langSPC('nmap', ['l','s', 'l'],
        \ 'call plugins#repl#send("line")',
        \ 'send line and keep code buffer focused', 1)
  call mapping#space#langSPC('nmap', ['l','s', 'b'],
        \ 'call plugins#repl#send("buffer")',
        \ 'send buffer and keep code buffer focused', 1)
  call mapping#space#langSPC('nmap', ['l','s', 's'],
        \ 'call plugins#repl#send("selection")',
        \ 'send selection and keep code buffer focused', 1)

  " +Generate {{{

  let g:_spacevim_mappings_space.l.g = {'name' : '+Generate'}

  call mapping#space#langSPC('nnoremap', ['l', 'g', 'd'],
        \ 'Pydocstring', 'generate docstring', 1)

  " }}}

  if layers#lsp#check_filetype('python')
    nnoremap <silent><buffer> K :call lsp#show_doc()<CR>

    call mapping#space#langSPC('nnoremap', ['l', 'd'],
          \ 'call lsp#show_doc()', 'show_document', 1)
    call mapping#space#langSPC('nnoremap', ['l', 'e'],
          \ 'call lsp#rename()', 'rename symbol', 1)
  endif

  " Format on save
  if g:format_on_save
    augroup SpaceVim_layer_lang_python
      autocmd!
      autocmd BufWritePost *.py Neoformat yapf
    augroup end
  endif
endfunction

func! s:getexe() abort
  let line = getline(1)
  if line =~# '^#!'
    let exe = split(line)
    let exe[0] = exe[0][2:]
    return exe
  endif
  return ['python']
endf

function! s:go_to_def() abort
  if !layers#lsp#check_filetype('python')
    call jedi#goto()
  else
    call lsp#go_to_def()
  endif
endfunction
