" ================================================================================
" enter mappings
" NOTE: this setting need to set completeopt-=noselect
" ================================================================================
scriptencoding utf-8


let s:md = get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'asyncomplete'))

" ================================================================================
" neosnippet
" ============================================================================= {{{
if get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet')) ==# 'neosnippet'
  function! mapping#enter#Super_Enter() abort
    if pumvisible()
      if neosnippet#expandable()
        if g:neosnippet#enable_complete_done == 1
          if CurChar(0, '(')
            return s:md ==# 'asyncomplete' ? asyncomplete#close_popup() : "\<c-y>"
          else
            return "\<c-e>\<plug>(neosnippet_expand)"
          endif
        else
          return "\<plug>(neosnippet_expand)"
        endif
      elseif !WithinEmptyPair() && CurChar(1, '}')
        return "\<c-y>\<CR>"
      elseif !CurChar(1, '}')
        if empty(v:completed_item)
          return "\<c-e>"
        else
          return "\<esc>o"
        endif
      endif
    elseif !pumvisible()
      if neosnippet#jumpable()
        return "\<plug>(neosnippet_jump)"
      elseif CurChar(0, '\s') || CurChar(1, '\s') || CurChar(1, '\w') 
        return "\<CR>"
      elseif !CurChar(1, ']') && !CurChar(1, '}') && !CurChar(1, '', 1)
        return "\<esc>o"
      elseif CurChar(0, '\d')
        return "\<esc>o"
      elseif CurChar(1, '}') || CurChar(1, ']')
        return "\<CR>\\\<Space>\<Esc>ko\\\<Space>"
      else
        return "\<CR>"
      endif
    endif
  endfunction
  "}}}

" ================================================================================
" ultisnips
" ============================================================================= {{{
" NOTE: g:ulti_expand_or_jump_res (0: fail, 1: expand, 2: jump)
elseif get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine')) ==# 'ultisnips'
  function! mapping#enter#Super_Enter() abort
    if pumvisible()
      return "\<c-r>=mapping#enter#popup()\<CR>"
    elseif !pumvisible()
      return "\<c-r>=mapping#enter#no_popup()\<CR>"
    endif
  endfunction
  function! mapping#enter#popup() abort
    let sni = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
      return sni
    elseif !WithinEmptyPair() && CurChar(1, '}')
      return "\<c-y>\<CR>"
    elseif !CurChar(1, '}')
      if empty(v:completed_item)
        return "\<c-e>"
      elseif g:ulti_expand_or_jump_res == 2
        return sni
      else
        return "\<esc>o"
      endif
    endif
  endfunction
  function! mapping#enter#no_popup() abort
    let sni = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res == 2
      return sni
    elseif CurChar(0, '\s') || CurChar(1, '\s') || CurChar(1, '\w') 
      return "\<CR>"
    elseif !CurChar(1, ']') && !CurChar(1, '}') && !CurChar(1, '', 1)
      return "\<esc>o"
    elseif CurChar(0, '\d')
      return "\<esc>o"
    elseif CurChar(1, '}') || CurChar(1, ']')
      return "\<CR>\\\<Space>\<Esc>ko\\\<Space>"
    else
      return "\<CR>"
    endif
  endfunction
  "}}}

" ================================================================================
" coc
" ============================================================================= {{{
elseif get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine')) ==# 'coc'
  function! mapping#enter#Super_Enter() abort
    if pumvisible()
      if coc#expandable()
        return "\<plug>(coc-snippets-expand)"
      elseif !WithinEmptyPair() && CurChar(1, '}')
        return "\<c-y>\<CR>"
      elseif !CurChar(1, '}')
        if empty(v:completed_item)
          return "\<c-e>"
        else
          return "\<esc>o"
        endif
      endif
    elseif !pumvisible()
      if CurChar(0, '\s') || CurChar(1, '\s') || CurChar(1, '\w') 
        return "\<CR>"
      elseif !CurChar(1, ']') && !CurChar(1, '}') && !CurChar(1, '', 1)
        return "\<esc>o"
      elseif CurChar(0, '\d')
        return "\<esc>o"
      elseif CurChar(1, '}') || CurChar(1, ']')
        return "\<CR>\\\<Space>\<Esc>ko\\\<Space>"
      else
        return "\<CR>"
      endif
    endif
  endfunction
endif
"}}}
