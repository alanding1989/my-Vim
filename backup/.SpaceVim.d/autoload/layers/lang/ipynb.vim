"=============================================================================
" ipynb.vim --- lang#ipynb layer
" Parent Section: layers
"=============================================================================
scriptencoding utf-8


function! layers#lang#ipynb#plugins() abort
  let plugins = [
        \ ['wsdjeg/vimpyter'            , {'merged': 0}],
        \ ]
  call add(plugins, ['heavenshell/vim-pydocstring',
        \ { 'on_cmd' : 'Pydocstring'}])
  " call add(plugins, ['Vimjas/vim-python-pep8-indent',
        " \ { 'on_ft' : 'ipynb'}])
  if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'coc'
    " nop
  elseif g:is_spacevim && !SpaceVim#layers#lsp#check_filetype('ipynb')
      let g:LanguageClient_serverCommands['ipynb'] = ['pyls']
    " call Spacevim#lsp#reg_server({'ipynb' : ['pyls']})
  elseif !exists(':LanguageClientStart')
    call add(plugins, ['davidhalter/jedi-vim', {'on_ft' : 'ipynb', 'for': 'ipynb',
          \ 'if' : has('python') || has('python3')}])
    if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'deoplete'
      call add(plugins, ['zchee/deoplete-jedi', {'on_ft' : 'ipynb', 'for': 'ipynb'}])
    elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'ncm2'
      call add(plugins, ['ncm2/ncm2-jedi', {'merged': 0, 'on_ft': ['python', 'ipynb'], 'for': ['python', 'ipynb']}])
    endif
  endif
  return plugins
endfunction


let s:format_on_save = 0
function! layers#lang#ipynb#config() abort
  if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) !=# 'coc'
        \ && !exists(':LanguageClientStart')
    " in neovim, we can use deoplete-jedi together with jedi-vim,
    " but we need to disable the completions of jedi-vim.
    let g:jedi#completions_enabled    = 0
    let g:jedi#completions_command    = ''
    let g:jedi_auto_vim_configuration = 0
    let g:jedi#use_splits_not_buffers = 1
    let g:jedi#force_py_version       = 3
  endif

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
        autocmd BufWritePost *.ipynb Neoformat yapf
      augroup END
    endif

  else
    augroup layer_lang_ipynb
      autocmd!
      autocmd FileType ipynb call s:language_specified_mappings()
      if s:format_on_save
        autocmd BufWritePost *.ipynb Neoformat yapf
      endif
    augroup END
  endif
endfunction


function! s:language_specified_mappings() abort
  if g:is_spacevim
    let g:_spacevim_mappings_space.l.j = {'name' : '+Jupyter Notebook'}
    imap <silent><buffer> <c-o> <esc>:VimpyterInsertPythonBlock<CR>i
    call SpaceVim#mapping#space#langSPC('nmap', ['l','j','u'],
          \ 'vimpyter#updateNotebook()',
          \ 'update Notebook'        , 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','j','j'],
          \ 'VimpyterInsertPythonBlock',
          \ 'insert python code block', 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','j','s'],
          \ 'VimpyterStartJupyter',
          \ 'start Jupyter Notebook' , 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','j','n'],
          \ 'VimpyterStartNteract',
          \ 'start Nteract Notebook' , 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','j','v'],
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

    if get(g:, 'spacevim_autocomplete_method') ==# 'coc'
          \ || exists(':LanguageClientStart')
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

  else
    nmap <silent><buffer> gd         :call <sid>go_to_def()<CR>
    nmap <silent><buffer><space>lis  :Neoformat isort<CR>
    nmap <silent><buffer><space>lir  :Neoformat autoflake<CR>
    nmap <silent><buffer><space>lg   :Pydocstring<CR>
    if get(g:, 'autocomplete_method') ==# 'coc'
      nnoremap <silent><buffer> K         :call CocActionAsync('doHover')<CR>
      nnoremap <silent><buffer><space>ld  :call CocActionAsync('doHover')<CR>
      nnoremap <silent><buffer><space>le  :call CocActionAsync('rename')<CR>
      nnoremap <silent><buffer><space>lr  :call CocActionAsync('jumpReferences')<CR>
    elseif exists(':LanguageClientStart')
      nnoremap <silent><buffer> K         :call LanguageClient_textDocument_hover()<CR>
      nnoremap <silent><buffer> <space>ld :call LanguageClient_textDocument_hover()<CR>
      nnoremap <silent><buffer> <space>le :call LanguageClient_textDocument_rename()<CR>
      nnoremap <silent><buffer> <space>lr :call LanguageClient_textDocument_references()<CR>
    else
      nnoremap <silent><buffer> K         :call jedi#show_documentation()<CR>
      nnoremap <silent><buffer> <space>ld :call jedi#show_documentation()<CR>
      nnoremap <silent><buffer> <space>le :call jedi#rename()<CR>
      nnoremap <silent><buffer> <space>lr :call jedi#usages()<CR>
    endif

    imap <silent><buffer> <c-o>       <esc>:VimpyterInsertPythonBlock<CR>i
    nmap <silent><buffer> <space>ljj  :VimpyterInsertPythonBlock<CR>
    nmap <silent><buffer> <space>ljs  :VimpyterStartJupyter<CR>
    nmap <silent><buffer> <space>lju  :vimpyter#updateNotebook()<CR>
    nmap <silent><buffer> <space>ljv  :vimpyter#createView()<CR>
    nmap <silent><buffer> <space>ljn  :VimpyterStartNteract<CR>

    nmap <silent><buffer> <Leader>jj  :VimpyterInsertPythonBlock<CR>
    nmap <silent><buffer> <Leader>js  :VimpyterStartJupyter<CR>
    nmap <silent><buffer> <Leader>ju  :vimpyter#updateNotebook<CR>
    nmap <silent><buffer> <Leader>jv  :vimpyter#createView<CR>
    nmap <silent><buffer> <Leader>jn  :VimpyterStartNteract<CR>
  endif
endfunction


function! s:go_to_def() abort
  if get(g:, 'spacevim_autocomplete_method',
        \ get(g:, 'autocomplete_method', 'deoplete')) ==# 'coc'
    call CocActionAsync('jumpDefinition')
  elseif exists(':LanguageClientStart')
    call LanguageClient_textDocument_definition()
  else
    call jedi#goto()
  endif
endfunction
