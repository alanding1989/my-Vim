"=============================================================================
" markdown.vim --- lang#markdown layer
"=============================================================================
scriptencoding utf-8



function! layers#lang#markdown#plugins() abort
  let plugins = []
  if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'ncm2'
    call add(plugins, ['ncm2/ncm2-markdown-subscope', {'on_ft': 'markdown', 'for': 'markdown'}])
  endif
  if !g:is_spacevim
    " call add(plugins, ['lvht/tagbar-markdown'               , {'merged': 0 }])
    call add(plugins, ['SpaceVim/vim-markdown'              , {'on_ft': 'markdown', 'for': 'markdown'}])
    call add(plugins, ['joker1007/vim-markdown-quote-syntax', {'on_ft': 'markdown', 'for': 'markdown'}])
    call add(plugins, ['mzlogin/vim-markdown-toc'           , {'on_ft': 'markdown', 'for': 'markdown'}])
    call add(plugins, ['iamcco/mathjax-support-for-mkdp'    , {'on_ft': 'markdown', 'for': 'markdown'}])
    call add(plugins, ['iamcco/markdown-preview.nvim'       , {'on_ft': 'markdown', 'for': 'markdown',
          \'depends': 'open-browser.vim', 'build' : 'cd app & yarn install', 'do': 'cd app & yarn install'}])
  endif
  return plugins
endfunction

function! layers#lang#markdown#config() abort
  if g:is_spacevim

  elseif !g:is_spacevim

  endif
endfunction

