"=============================================================================
" VersionControl.vim --- version control layer
" Section: layers
"=============================================================================
scriptencoding utf-8



function! layers#VersionControl#plugins() abort
  let plugins = []
  " signify can not only support git
  if !g:is_spacevim
    call add(plugins, ['mhinz/vim-signify' , {'merged' : 0}])
  endif
  return plugins
endfunction


function! layers#VersionControl#config() abort


endfunction



" function() wrapper {{{
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
endif
" }}}
