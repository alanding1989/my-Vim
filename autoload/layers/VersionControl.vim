"=============================================================================
" VersionControl.vim --- version control layer
" Section: layers
"=============================================================================
scriptencoding utf-8



function! layers#VersionControl#plugins() abort
  let plugins = []
  if g:is_nvim
    " call add(plugins, ['iamcco/sran.nvim' , {'build': 'yarn', 'do': 'yarn'}])
    " call add(plugins, ['iamcco/git-p.nvim', {'merged': 0}])
  endif
  if !g:is_spacevim
    let plugins = [
          \ ['mhinz/vim-signify' , {'merged' : 0}],
          \ ]
    call add(plugins, ['tpope/vim-fugitive', {'merged' : 0}])
  endif
  return plugins
endfunction


function! layers#VersionControl#config() abort
  if g:is_spacevim
    call SpaceVim#mapping#space#def('nmap', ['g', 'D'],
          \ '<Plug>(git-p-diff-preview)', '@ view git diff virtual', 0)
  else
    nmap <space>gD <Plug>(git-p-diff-preview)
  endif
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
