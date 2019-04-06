" ================================================================================
" space mappings
" ================================================================================
scriptencoding utf-8


let g:_snippet = get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet'))

if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'coc'
  function! mapping#space#c_space() abort
    inoremap <expr><c-space> !pumvisible() ? coc#refresh() : "\<c-y>"
  endfunction

elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method')) ==# 'deoplete'
  function! mapping#space#c_space() abort
    inoremap <expr><c-space> !pumvisible() ? deoplete#manual_complete([g:_snippet, ]) : "\<c-y>"
  endfunction

elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method')) ==# 'ncm2'
  function! mapping#space#c_space() abort
    inoremap <expr><c-space> !pumvisible() ? "\<c-r>=ncm2#force_trigger(g:_snippet, )\<cr>" : "\<c-y>"
  endfunction
endif
