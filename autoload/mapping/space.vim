" ================================================================================
" space mappings
" ================================================================================
scriptencoding utf-8


let g:_snippet = get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet'))

if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'coc'
  function! mapping#space#C_Space() abort
    inoremap <expr><C-Space> !pumvisible() ? coc#refresh() : "\<C-y>"
  endfunction

elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method')) ==# 'deoplete'
  function! mapping#space#C_Space() abort
    if get(g:, 'spacevim_enable_javacomplete2_py', 0) || get(g:, 'enable_javacomplete2_py', 0)
      inoremap <expr><C-Space> !pumvisible() ? deoplete#manual_complete(['javacomplete2']) : "\<C-y>"
    else
      inoremap <expr><C-Space> !pumvisible() ? deoplete#manual_complete([g:_snippet, ]) : "\<C-y>"
      " inoremap <expr><C-Space> !pumvisible() ? deoplete#manual_complete(['omni']) : "\<C-y>"
    endif
  endfunction

elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method')) ==# 'ncm2'
  function! mapping#space#C_Space() abort
    inoremap <expr><C-Space> !pumvisible() ? "\<C-r>=ncm2#force_trigger(g:_snippet, )\<cr>" : "\<C-y>"
  endfunction

elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method')) ==# 'asyncomplete'
  function! mapping#space#C_Space() abort
    inoremap <expr><C-Space> !pumvisible() ? asyncomplete#force_refresh() : asyncomplete#close_popup()
  endfunction

elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method')) ==# 'ycm'
  function! mapping#space#C_Space() abort

  endfunction
endif
