"=============================================================================
" python.vim --- lang#python layer
" Parent Section: layers
"=============================================================================
scriptencoding utf-8


function! layers#lang#python#plugins() abort
  let plugins = []
  if g:is_nvim
    call add(plugins, ['numirias/semshi', {'on_ft': 'python', 'for': 'python'}])
  else
    call add(plugins, ['vim-python/python-syntax', {'on_ft': 'python', 'for': 'python'}])
    let g:python_highlight_all = 1
  endif
  if !g:is_spacevim
    if !My_Vim#layer#isLoaded('lsp')
      call add(plugins, ['davidhalter/jedi-vim', {'on_ft': 'python', 'for': 'python'}])
      if g:autocomplete_method ==# 'deoplete'
        call add(plugins, ['zchee/deoplete-jedi', {'on_ft': 'python', 'for': 'python'}])
      endif
    endif
    call add(plugins, ['heavenshell/vim-pydocstring'  , {'on_cmd': 'Pydocstring', 'on' : 'Pydocstring'}])
    call add(plugins, ['Vimjas/vim-python-pep8-indent', {'on_ft' : 'python'     , 'for': 'python'}])
    call add(plugins, ['jeetsukumaran/vim-pythonsense', {'on_ft' : 'python'     , 'for': 'python'}])
  endif
  return plugins
endfunction


let s:format_on_save = 0
if !g:is_spacevim
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
    augroup layer_lang_python
      autocmd!
      auto FileType python call s:language_specified_mappings()
      " \ | Semshi enable
      if s:format_on_save
        auto BufWritePost *.py Neoformat yapf
      endif
    augroup END
  endfunction
endif

function! s:language_specified_mappings() abort
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


function! s:go_to_def() abort
  if My_Vim#layer#isLoaded('lsp')
    call layers#lsp#go_to_def()
  else
    call jedi#goto()
  endif
endfunction
