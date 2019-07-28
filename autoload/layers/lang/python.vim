"=============================================================================
" python.vim --- lang#python layer
" Parent Section: layers
"=============================================================================
scriptencoding utf-8


let s:autocomplete_method = get(g:, 'spacevim_autocomplete_method',
      \ get(g:, 'autocomplete_method', 'deoplete'))


function! layers#lang#python#plugins() abort
  let plugins = []
  if g:is_nvim
    call add(plugins, ['numirias/semshi'         , {'on_ft': 'python', 'for': 'python'}])
  else
    call add(plugins, ['vim-python/python-syntax', {'merged': 0}])
  endif
  if g:is_spacevim
    if s:autocomplete_method ==# 'ncm2' && !SpaceVim#layers#lsp#check_filetype('python')
      call add(plugins, ['ncm2/ncm2-jedi'       , {'on_ft': 'python', 'for': 'python'}])
    endif
  else
    if !layers#lsp#check_ft('python')
      call add(plugins, ['davidhalter/jedi-vim' , {'on_ft': 'python', 'for': 'python'}])
      if s:autocomplete_method ==# 'deoplete'
        call add(plugins, ['zchee/deoplete-jedi', {'on_ft': 'python', 'for': 'python'}])
      elseif s:autocomplete_method ==# 'ncm2'
        call add(plugins, ['ncm2/ncm2-jedi'     , {'on_ft': 'python', 'for': 'python'}])
      endif
    endif
    call add(plugins, ['heavenshell/vim-pydocstring'  , {'on_cmd': 'Pydocstring', 'on' : 'Pydocstring'}])
    call add(plugins, ['Vimjas/vim-python-pep8-indent', {'on_ft' : 'python'     , 'for': 'python'}])
    call add(plugins, ['jeetsukumaran/vim-pythonsense', {'on_ft' : 'python'     , 'for': 'python'}])
    call add(plugins, ['alfredodeza/coveragepy.vim'   , { 'merged' : 0}])
  endif
  return plugins
endfunction


let s:format_on_save = 0
function! layers#lang#python#config() abort
  if g:is_spacevim
    call SpaceVim#custom#Reg_langSPC('python', function('s:language_specified_mappings'))
  else
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
      if s:format_on_save
        auto BufWritePost *.py Neoformat yapf
      endif
    augroup END
  endif
endfunction

function! s:language_specified_mappings() abort
  if g:is_spacevim
    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'b'], 'call call('
          \ . string(s:_function('s:set_trace')) . ', [])',
          \ '@ set breakpoint', 1)
  else
    nnoremap <silent><buffer> gd         :call <sid>go_to_def()<CR>
    nnoremap <silent><buffer><Space>lis  :Neoformat isort<CR>
    nnoremap <silent><buffer><Space>lir  :Neoformat autoflake<CR>
    nnoremap <silent><buffer><Space>lg   :Pydocstring<CR>
    if layers#lsp#check_ft('python')
      nnoremap <silent><buffer> K         :call layers#lsp#show_doc()<CR>
      nnoremap <silent><buffer> <Space>ld :call layers#lsp#show_doc()<CR>
      nnoremap <silent><buffer> <Space>le :call layers#lsp#rename()<CR>
      nnoremap <silent><buffer> <Space>lr :call layers#lsp#references()<CR>
    else
      nnoremap <silent><buffer> K         :call jedi#show_documentation()<CR>
      nnoremap <silent><buffer> <Space>ld :call jedi#show_documentation()<CR>
      nnoremap <silent><buffer> <Space>le :call jedi#rename()<CR>
      nnoremap <silent><buffer> <Space>lr :call jedi#usages()<CR>
    endif

    nnoremap <silent><buffer> <Space>lcr  :Coveragepy report<CR>
    nnoremap <silent><buffer> <Space>lcs  :Coveragepy show<CR>
    nnoremap <silent><buffer> <Space>lce  :Coveragepy session<CR>
    nnoremap <silent><buffer> <Space>lcf  :Coveragepy refresh<CR>
    inoremap <silent><buffer> <c-;>       <Esc>:VimpyterInsertPythonBlock<CR>i
    nnoremap <silent><buffer> <Space>lj   :VimpyterInsertPythonBlock<CR>
    nnoremap <silent><buffer> <Space>ls   :VimpyterStartJupyter<CR>
    nnoremap <silent><buffer> <Space>lu   :vimpyter#updateNotebook()<CR>
    nnoremap <silent><buffer> <Space>lv   :vimpyter#createView()<CR>
    nnoremap <silent><buffer> <Space>ln   :VimpyterStartNteract<CR>

    nnoremap <silent><buffer> <Leader>jj  :VimpyterInsertPythonBlock<CR>
    nnoremap <silent><buffer> <Leader>js  :VimpyterStartJupyter<CR>
    nnoremap <silent><buffer> <Leader>ju  :vimpyter#updateNotebook<CR>
    nnoremap <silent><buffer> <Leader>jv  :vimpyter#createView<CR>
    nnoremap <silent><buffer> <Leader>jn  :VimpyterStartNteract<CR>
  endif
endfunction

function! s:set_trace() abort
  let line = search('\%^\_.\{-}\zsipdb\.set')
  if line
    call setpos('.', [0, line, 1])
    normal! dd
  else
    call append(line('.'), 'import ipdb; ipdb.set_trace()')
    normal! j==k
  endif
endfunction

function! s:go_to_def() abort
  if layers#lsp#check_ft('python')
    call layers#lsp#go_to_def()
  else
    call jedi#goto()
  endif
endfunction

" function() wrapper "{{{
if v:version > 703 || v:version == 703 && has('patch1170')
  function! s:_function(fstr) abort
    return function(a:fstr)
  endfunction
else
  function! s:_SID() abort
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze__SID$')
  endfunction
  let s:_s = '<SNR>' . s:_SID() . '_'
  function! s:_function(fstr) abort
    return function(substitute(a:fstr, 's:', s:_s, 'g'))
  endfunction
endif "}}}
