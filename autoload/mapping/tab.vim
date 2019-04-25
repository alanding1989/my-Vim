" ================================================================================
" tab mappings
" NOTE: this setting need to set completeopt-=noselect
" ================================================================================
scriptencoding utf-8



let s:md = get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'asyncomplete'))

" ================================================================================
" neosnippet
" ============================================================================= {{{
if get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet')) ==# 'neosnippet'
  function! mapping#tab#super_tab() abort
    if pumvisible()
      if neosnippet#expandable()
        if g:neosnippet#enable_complete_done == 1
          if getline('.')[col('.')-2] ==# '('
            return s:md ==# 'asyncomplete' ? asyncomplete#close_popup() : "\<c-y>"
          else
            return "\<c-e>\<plug>(neosnippet_expand)"
          endif
        else
          return "\<plug>(neosnippet_expand)"
        endif
      elseif neosnippet#jumpable() && getline('.')[col('.')-1] ==# '('
        return "\<plug>(neosnippet_jump)"
      else
        return s:md ==# 'asyncomplete' ? asyncomplete#close_popup() : "\<c-y>"
      endif
    else
      if neosnippet#expandable() && getline('.')[col('.')-2] !=# '('
        return "\<plug>(neosnippet_expand)"
      elseif !neosnippet#jumpable() && delimitMate#ShouldJump()
            \ && s:check_bs() && getline('.')[col('.')-1] !=? ''
        return "\<right>"
      elseif neosnippet#jumpable()
        return "\<plug>(neosnippet_jump)"
      elseif !s:check_bs()
        return "\<tab>"
      else
        if s:md ==# 'coc'
          return coc#refresh()
        elseif s:md ==# 'deoplete'
          return deoplete#manual_complete()
        elseif s:md ==# 'ncm2'
          return "\<c-r>=ncm2#manual_trigger()\<cr>"
        elseif s:md ==# 'asyncomplete'
          return asyncomplete#force_refresh()
        elseif s:md ==# 'ycm'
          return "\<tab>"
        endif
      endif
    endif
  endfunction

  function! mapping#tab#S_tab() abort
    smap <expr><TAB>
          \ neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)" :
          \ "\<TAB>"
  endfunction
  "}}}

" ================================================================================
" ultisnips
" ============================================================================= {{{
" NOTE: g:ulti_expand_or_jump_res (0: fail, 1: expand, 2: jump)
elseif get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine')) ==# 'ultisnips'
  function! mapping#tab#super_tab() abort
    if pumvisible()
      return "\<c-r>=mapping#tab#popup()\<cr>"
    else
      return "\<c-r>=mapping#tab#no_popup()\<cr>"
    endif
  endfunction
  function! mapping#tab#popup() abort
    let snip = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res == 1
      return snip
    elseif g:ulti_expand_or_jump_res == 2 && getline('.')[col('.')-2] ==# '('
      return snip
    else
      return s:md ==# 'asyncomplete' ? asyncomplete#close_popup() : "\<c-y>"
    endif
  endfunction
  function! mapping#tab#no_popup() abort
    let sni = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res == 1
      return sni
    elseif g:ulti_expand_or_jump_res != 2 && delimitMate#ShouldJump()
          \ && s:check_bs() && getline('.')[col('.')-1] !=? ''
      return "\<right>"
    elseif g:ulti_expand_or_jump_res == 2
      return sni
    elseif !s:check_bs()
      return "\<tab>"
    else
      if s:md ==# 'coc'
        return coc#refresh()
      elseif s:md ==# 'deoplete'
        return deoplete#manual_complete()
      elseif s:md ==# 'ncm2'
        return "\<c-r>=ncm2#manual_trigger()\<cr>"
      elseif s:md ==# 'asyncomplete'
        return asyncomplete#force_refresh()
      elseif s:md ==# 'ycm'
        return "\<tab>"
      endif
    endif
  endfunction

  function! mapping#tab#S_tab() abort
    snoremap <silent><tab>  <Esc>:call UltiSnips#ExpandSnippetOrJump()<CR>
    xnoremap <silent><tab>  :call UltiSnips#SaveLastVisualSelection()<cr>gvs"
    snoremap <silent><c-o>  <ESC>:call UltiSnips#JumpBackwards()<CR>
    inoremap <silent><c-o>  <ESC>:call UltiSnips#JumpBackwards()<CR>
    inoremap <silent><c-t>  <C-R>=UltiSnips#ListSnippets()<cr>
  endfunction
  "}}}

" ================================================================================
" coc
" ============================================================================= {{{
elseif s:md ==# 'coc'
  function! mapping#tab#super_tab() abort
    if pumvisible()
      if coc#expandable()
        return "\<Plug>(coc-snippets-expand)"
      elseif coc#jumpable() && getline('.')[col('.')-1] ==# '('
        return coc#rpc#request('doKeymap', ['snippets-jump', ''])
      else
        return "\<c-y>"
      endif
    else
      if coc#expandable()
        return "\<Plug>(coc-snippets-expand)"
      elseif !coc#jumpable() && delimitMate#ShouldJump()
            \ && s:check_bs() && getline('.')[col('.')-1] !=? ''
        return "\<right>"
      elseif coc#jumpable() && s:check_bs()
        return coc#rpc#request('doKeymap', ['snippets-jump', ''])
      elseif !s:check_bs()
        return "\<tab>"
      else
        return coc#refresh()
      endif
    endif
  endfunction

  function! mapping#tab#S_tab() abort
    xmap <tab> <Plug>(coc-snippets-select)
  endfunction
endif
"}}}

function! s:check_bs() abort
  let col = col('.') - 1
  return col > 0 && getline('.')[col('.')-2] !~# '\s'
endfunction
