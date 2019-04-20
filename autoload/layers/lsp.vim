"=============================================================================
" lsp.vim
"=============================================================================
scriptencoding utf-8



function! layers#lsp#plugins() abort
  let plugins = []

  if get(g:, 'autocomplete_method') ==# 'coc'
    " nop
  elseif has('nvim') && has('python3')
    if g:is_win
      call add(plugins, ['autozimu/LanguageClient-neovim',
            \ {'merged': 0, 'build': 'powershell -executionpolicy bypass -File install.ps1',
            \ 'do': 'powershell -executionpolicy bypass -File install.ps1'}])
    else
      call add(plugins, ['autozimu/LanguageClient-neovim',
            \ {'merged': 0, 'build': 'bash install.sh',
            \ 'do': 'bash install.sh'}])
    endif
  else
    call add(plugins, ['prabirshrestha/async.vim', {'merged' : 0}])
    call add(plugins, ['prabirshrestha/vim-lsp'  , {'merged' : 0}])
  endif
  return plugins
endfunction

function! layers#lsp#config() abort
  return
  let g:lsp_async_completion = 1
endfunction
