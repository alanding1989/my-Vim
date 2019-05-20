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
  function! mapping#tab#Super_Tab() abort
    if pumvisible()
      if neosnippet#expandable()
        return g:neosnippet#enable_complete_done
              \ ? ( s:md ==# 'deoplete' ? "\<C-y>"
              \ : CurChar(0, '(') ? ( s:md ==# 'asyncomplete' ? asyncomplete#close_popup() : "\<c-y>" ) 
              \ :  "\<c-e>\<plug>(neosnippet_expand)" )
              \ : "\<plug>(neosnippet_expand)"
      elseif RightPair() && !empty(v:completed_item)
        return "\<right>"
      elseif neosnippet#jumpable() && CurChar(1, '(')
        return empty(v:completed_item) 
              \ ? "\<C-y>" : "\<plug>(neosnippet_jump)"
      else " fix ncm2
        return WithinEmptyPair() ? "\<c-y>\<Del>\<Right>"
              \ : s:md ==# 'asyncomplete' ? asyncomplete#close_popup() 
              \ : "\<c-y>"
      endif
    else
      if neosnippet#expandable() && !CurChar(0, '(')
        return "\<plug>(neosnippet_expand)"
      elseif !neosnippet#jumpable() && s:check_bs() && !CurChar(1, '') && RightPair()
        return "\<right>"
      elseif neosnippet#jumpable()
        " call mapping#util#jback('CurChar', {
              " \ "\<Esc>hviwc"     : [1 ,'('],
              " \ "\<left>,\<Space>": [1 ,')'],
              " \ })
        return "\<plug>(neosnippet_jump)"
      elseif !s:check_bs()
        return "\<tab>"
      else
        return    s:md ==# 'coc'          ? coc#refresh()
              \ : s:md ==# 'deoplete'     ? deoplete#manual_complete()
              \ : s:md ==# 'ncm2'         ? "\<C-r>=ncm2#manual_trigger()\<CR>"
              \ : s:md ==# 'ycm'          ? "\<tab>"
              \ : s:md ==# 'asyncomplete' ? asyncomplete#force_refresh()
              \ : ''
      endif
    endif
  endfunction

  function! mapping#tab#S_Tab() abort
    smap <expr> <TAB>
          \ neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)" :
          \ "\<TAB>"
    xmap <TAB>  <Plug>(neosnippet_expand_target)
    inoremap <C-o> <Esc>:call mapping#util#JumpBack()<CR>
    snoremap <C-o> <Esc>:call mapping#util#JumpBack()<CR>
  endfunction
  "}}}

" ================================================================================
" ultisnips
" ============================================================================= {{{
" NOTE: g:ulti_expand_or_jump_res (0: fail, 1: expand, 2: jump)
elseif get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine')) ==# 'ultisnips'
  function! mapping#tab#Super_Tab() abort
    return pumvisible()
          \ ? "\<c-r>=mapping#tab#popup()\<CR>"
          \ : "\<c-r>=mapping#tab#no_popup()\<CR>"
  endfunction
  function! mapping#tab#popup() abort
    let snip = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res == 1
      return snip
    elseif g:ulti_expand_or_jump_res == 2 && CurChar(0, '(')
      return snip
    elseif RightPair() && !empty(v:completed_item)
      return "\<right>"
    elseif CurChar(0, '(') && !CurChar(1, ')')
      return CurChar(1, '')
            \ ? ")\<left>" : ")\<Space>\<left>\<left>"
    else
      return s:md ==# 'asyncomplete' ? asyncomplete#close_popup() : "\<c-y>"
    endif
  endfunction
  function! mapping#tab#no_popup() abort
    if CurChar(0, '(') && !CurChar(1, ')')
      return CurChar(1, '')
            \ ? ")\<left>" : ")\<Space>\<left>\<left>"
    endif
    let sni = UltiSnips#ExpandSnippetOrJump()

    if g:ulti_expand_or_jump_res == 1
      return sni
    elseif g:ulti_expand_or_jump_res != 2 && RightPair() && s:check_bs() && !CurChar(1,  '')
      return "\<right>"
    elseif g:ulti_expand_or_jump_res == 2
      return sni
    elseif !s:check_bs()
      return "\<tab>"
    else
      return    s:md ==# 'coc'          ? coc#refresh()
            \ : s:md ==# 'deoplete'     ? deoplete#manual_complete()
            \ : s:md ==# 'ncm2'         ? "\<C-r>=ncm2#manual_trigger()\<CR>"
            \ : s:md ==# 'ycm'          ? "\<tab>"
            \ : s:md ==# 'asyncomplete' ? asyncomplete#force_refresh()
            \ : ''
    endif
  endfunction

  function! mapping#tab#S_Tab() abort
    snoremap <silent><tab>  <Esc>:call UltiSnips#ExpandSnippetOrJump()<CR>
    inoremap <silent><C-o>  <C-R>=UltiSnips#JumpBackwards()<CR>
    snoremap <silent><C-o>  <ESC>:call UltiSnips#JumpBackwards()<CR>
    xnoremap <silent><tab>  :call UltiSnips#SaveLastVisualSelection()<CR>gvs
    inoremap <silent><c-t>  <C-R>=UltiSnips#ListSnippets()<CR>
  endfunction
  "}}}

" ================================================================================
" coc
" ============================================================================= {{{
elseif s:md ==# 'coc'
  function! mapping#tab#Super_Tab() abort
    if pumvisible()
      if coc#expandable()
        return "\<Plug>(coc-snippets-expand)"
      elseif coc#jumpable() && CurChar(1, '(')
        return "\<Plug>(coc-snippets-expand-jump)"
      elseif RightPair() && !empty(v:completed_item)
        return "\<right>"
      else
        return "\<c-y>"
      endif
    else
      if coc#expandable()
        return "\<Plug>(coc-snippets-expand)"
      elseif !coc#jumpable() && RightPair() && s:check_bs() && !CurChar(1, '')
        return "\<right>"
      elseif coc#jumpable()
        return "\<Plug>(coc-snippets-expand-jump)"
      elseif !s:check_bs()
        return "\<tab>"
      else
        return coc#refresh()
      endif
    endif
  endfunction

  function! mapping#tab#S_tab() abort
    snoremap <silent><tab> <Esc>:call coc#rpc#request('snippetNext', [])<CR>
    snoremap <silent><c-o> <Esc>:call coc#rpc#request('snippetPrev', [])<CR>
    xmap <tab> <Plug>(coc-snippets-select)
  endfunction
endif
"}}}

function! s:check_bs() abort
  let col = col('.') - 1
  return col > 0 && getline('.')[col('.')-2] !~# '\s'
endfunction

