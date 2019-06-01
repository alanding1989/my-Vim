"=============================================================================
" ipynb.vim --- lang#ipynb layer
" Parent Section: layers
"=============================================================================
scriptencoding utf-8


let s:autocomplete_method = get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete'))


function! layers#lang#ipynb#plugins() abort
  let plugins = [
        \ ['wsdjeg/vimpyter', {'merged': 0}],
        \ ]
  call add(plugins, ['jeetsukumaran/vim-pythonsense', {'on_ft' : 'ipynb', 'for': 'ipynb'}])
  call add(plugins, ['heavenshell/vim-pydocstring'  , {'on_cmd': 'Pydocstring', 'on': 'Pydocstring'}])
  " call add(plugins, ['Vimjas/vim-python-pep8-indent', \ { 'on_ft' : 'ipynb'}])
  if s:autocomplete_method ==# 'coc'
    " nop
  elseif g:is_spacevim && SpaceVim#layers#isLoaded('lsp')
    if !SpaceVim#layers#lsp#check_filetype('ipynb') 
      let g:LanguageClient_serverCommands['ipynb'] = ['pyls']
    else
      return plugins
    endif
  elseif !layers#lsp#check_ft('ipynb') || !SpaceVim#layers#isLoaded('lsp')
    call add(plugins, ['davidhalter/jedi-vim' , {'on_ft':'ipynb', 'for':'ipynb',
          \ 'if': has('python') || has('python3')}])
    if s:autocomplete_method ==# 'deoplete'
      call add(plugins, ['zchee/deoplete-jedi', {'on_ft':'ipynb', 'for':'ipynb'}])
    elseif s:autocomplete_method ==# 'ncm2'
      call add(plugins, ['ncm2/ncm2-jedi', {'on_ft': ['ipynb'], 'for': ['ipynb']}])
    endif
  endif
  return plugins
endfunction


let s:format_on_save = 0
function! layers#lang#ipynb#config() abort
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
  if g:is_spacevim
    call SpaceVim#layers#edit#add_ft_head_tamplate('python',
          \ ['#!/usr/bin/env python',
          \ '# -*- coding: utf-8 -*-',
          \ '']
          \ )
    call SpaceVim#mapping#space#regesit_lang_mappings('ipynb', function('s:language_specified_mappings'))
    call SpaceVim#mapping#gd#add('ipynb', function('s:go_to_def'))
    if s:format_on_save
      augroup layer_lang_ipynb
        autocmd!
        auto BufWritePost *.ipynb Neoformat yapf
      augroup END
    endif
  else
    augroup layer_lang_ipynb
      autocmd!
      auto FileType ipynb call s:language_specified_mappings()
      if s:format_on_save
        auto BufWritePost *.ipynb Neoformat yapf
      endif
    augroup END
  endif
endfunction


if g:is_spacevim
  function! s:language_specified_mappings() abort
    let g:_spacevim_mappings_space.l.j = {'name' : '+Jupyter Notebook'}
    imap <silent><buffer> <c-;> <esc>:VimpyterInsertPythonBlock<CR>i
    call SpaceVim#mapping#space#langSPC('nmap', ['l','u'],
          \ 'vimpyter#updateNotebook()',
          \ 'update Notebook'        , 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','p'],
          \ 'VimpyterInsertPythonBlock',
          \ 'insert python code block', 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','j'],
          \ 'VimpyterStartJupyter',
          \ 'start Jupyter Notebook' , 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','n'],
          \ 'VimpyterStartNteract',
          \ 'start Nteract Notebook' , 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','v'],
          \ 'vimpyter#createView()',
          \ 'create view of Notebook', 1)

    let g:_spacevim_mappings_space.l.i = {'name' : '+Imports'}
    call SpaceVim#mapping#space#langSPC('nmap', ['l','i','s'],
          \ 'Neoformat isort',
          \ 'sort Imports', 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','i','r'],
          \ 'Neoformat autoflake',
          \ 'remove unused imports', 1)

    let g:_spacevim_mappings_space.l.g = {'name' : '+Generate'}
    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'g'],
          \ 'Pydocstring',
          \ 'generate Docstring', 1)

    if SpaceVim#layers#isLoaded('lsp')
      nnoremap <silent><buffer> K :call SpaceVim#lsp#show_doc()<CR>
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'd'],
            \ 'call SpaceVim#lsp#show_doc()', 'show Document', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'e'],
            \ 'call SpaceVim#lsp#rename()', 'rename Symbol', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'r'],
            \ 'call SpaceVim#lsp#references()', 'find References', 1)
    else
      nnoremap <silent><buffer> K :call jedi#show_documentation()<CR>
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'd'],
            \ 'call jedi#show_documentation()', 'show Document', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'e'],
            \ 'call jedi#rename()', 'rename Symbol', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'r'],
            \ 'call jedi#usages()', 'find References', 1)
    endif
  endfunction
else
  function! layers#lang#ipynb#config() abort
    nmap <silent><buffer> gd         :call <sid>go_to_def()<CR>
    nmap <silent><buffer><space>lis  :Neoformat isort<CR>
    nmap <silent><buffer><space>lir  :Neoformat autoflake<CR>
    nmap <silent><buffer><space>lg   :Pydocstring<CR>
    if My_Vim#layer#isLoaded('lsp')
      nnoremap <silent><buffer> K         :call layers#lsp#show_doc()<CR>
      nnoremap <silent><buffer> <space>ld :call layers#lsp#show_doc()<CR>
      nnoremap <silent><buffer> <space>le :call layers#lsp#rename()<CR>
      nnoremap <silent><buffer> <space>lr :call layers#lsp#references()<CR>
    else
      nnoremap <silent><buffer> K         :call jedi#show_documentation()<CR>
      nnoremap <silent><buffer> <space>ld :call jedi#show_documentation()<CR>
      nnoremap <silent><buffer> <space>le :call jedi#rename()<CR>
      nnoremap <silent><buffer> <space>lr :call jedi#usages()<CR>
    endif

    imap <silent><buffer> <c-;>       <esc>:VimpyterInsertPythonBlock<CR>i
    nmap <silent><buffer> <space>lj   :VimpyterInsertPythonBlock<CR>
    nmap <silent><buffer> <space>ls   :VimpyterStartJupyter<CR>
    nmap <silent><buffer> <space>lu   :vimpyter#updateNotebook()<CR>
    nmap <silent><buffer> <space>lv   :vimpyter#createView()<CR>
    nmap <silent><buffer> <space>ln   :VimpyterStartNteract<CR>

    nmap <silent><buffer> <Leader>jj  :VimpyterInsertPythonBlock<CR>
    nmap <silent><buffer> <Leader>js  :VimpyterStartJupyter<CR>
    nmap <silent><buffer> <Leader>ju  :vimpyter#updateNotebook<CR>
    nmap <silent><buffer> <Leader>jv  :vimpyter#createView<CR>
    nmap <silent><buffer> <Leader>jn  :VimpyterStartNteract<CR>
  endfunction
endif


if g:is_spacevim
  function! s:go_to_def() abort
    if SpaceVim#layers#isLoaded('lsp')
      call SpaceVim#lsp#go_to_def()
    else
      call jedi#goto()
    endif
  endfunction
else
  function! s:go_to_def() abort
    if My_Vim#layer#isLoaded('lsp')
      call layers#lsp#go_to_def()
    else
      call jedi#goto()
    endif
  endfunction
endif
