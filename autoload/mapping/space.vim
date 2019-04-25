" ================================================================================
" space mappings
" ================================================================================
scriptencoding utf-8


let g:_snippet = get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet'))

if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'coc'
  function! mapping#space#c_space() abort
    inoremap <expr><C-Space> !pumvisible() ? coc#refresh() : "\<C-y>"
  endfunction

elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method')) ==# 'deoplete'
  function! mapping#space#c_space() abort
    inoremap <expr><C-Space> !pumvisible() ? deoplete#manual_complete([g:_snippet, ]) : "\<C-y>"
  endfunction

elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method')) ==# 'ncm2'
  function! mapping#space#c_space() abort
    inoremap <expr><C-Space> !pumvisible() ? "\<C-r>=ncm2#force_trigger(g:_snippet, )\<cr>" : "\<C-y>"
  endfunction

elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method')) ==# 'asyncomplete'
  function! mapping#space#c_space() abort
    inoremap <expr><C-Space> !pumvisible() ? asyncomplete#force_refresh() : asyncomplete#close_popup()
  endfunction

elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method')) ==# 'ycm'
  function! mapping#space#c_space() abort

  endfunction
endif
