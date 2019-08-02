" ================================================================================
" enter mappings
" NOTE: this setting need to set completeopt-=noselect
" ================================================================================
scriptencoding utf-8


let s:md = get(g:, 'spacevim_autocomplete_method',
      \ get(g:, 'autocomplete_method', 'asyncomplete'))
let s:autocomplete_parens = get(g:, 'spacevim_autocomplete_parens',
      \ get(g:, 'autocomplete_parens', 0))

" ================================================================================
" neosnippet
" ============================================================================= {{{
if get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet')) ==# 'neosnippet'
  function! mapping#enter#Super_Enter() abort
    if pumvisible()
      if neosnippet#expandable()
        return g:neosnippet#enable_complete_done
              \ ? ( s:md ==# 'deoplete' ? "\<C-y>"
              \ : CurChar(0, '(') ? ( s:md ==# 'asyncomplete' ? asyncomplete#close_popup() : "\<C-y>" ) 
              \ :  "\<C-e>\<Plug>(neosnippet_expand)" )
              \ : "\<Plug>(neosnippet_expand)"
      elseif !WithinEmptyPair() && CurChar(1, '}')
        return "\<C-y>\<CR>"
      elseif !CurChar(1, '}')
        return empty(v:completed_item) ? "\<C-e>" : "\<Esc>o"
      endif
    elseif !pumvisible()
      if neosnippet#jumpable()
        return "\<Plug>(neosnippet_jump)"
      elseif CurChar(0, '\s') || CurChar(1, '\s') || CurChar(1, '\w') 
        return "\<CR>"
      elseif !CurChar(1, ']') && !CurChar(1, '}') && !CurChar(1, '', 1)
        return "\<Esc>o"
      elseif CurChar(0, '\d')
        return "\<Esc>o"
      elseif CurChar(1, '}') || CurChar(1, ']')
        return <sid>SmartCR()
      else
        return "\<Plug>(EolCR)"
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
    return pumvisible()
          \ ? "\<C-r>=mapping#enter#popup()\<CR>"
          \ : "\<C-r>=mapping#enter#no_popup()\<CR>"
  endfunction
  function! mapping#enter#popup() abort
    let sni = UltiSnips#ExpandSnippetOrJump()
    if empty(v:completed_item)
      return "\<C-e>"
    elseif RightPair()
      return "\<Right>"
    elseif g:ulti_expand_or_jump_res == 2
      return sni
    else
      return "\<Plug>(EolCR)"
    endif
  endfunction

  function! mapping#enter#no_popup() abort
    let sni = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res == 2
      return sni
    elseif CurChar(0, '\s') || CurChar(1, '\s') || CurChar(1, '\w') 
      return "\<CR>"
    elseif !CurChar(1, ']') && !CurChar(1, '}') && !CurChar(1, '', 1)
      return "\<Esc>o"
    elseif CurChar(0, '\d')
      return "\<Esc>o"
    elseif CurChar(1, '}') || CurChar(1, ']')
      return <sid>SmartCR()
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
        return "\<Plug>(coc-snippets-expand)"
      elseif !WithinEmptyPair() && CurChar(1, '}')
        return "\<C-y>\<CR>"
      elseif !CurChar(1, '}')
        return empty(v:completed_item) ? "\<C-e>" : "\<Esc>o"
      endif
    elseif !pumvisible()
      if CurChar(0, '\s') || CurChar(1, '\s') || CurChar(1, '\w') 
        return "\<CR>"
      " elseif !CurChar(1, ']') && !CurChar(1, '}') && !CurChar(1, '', 1)
        " return "\<Esc>o"
      elseif CurChar(0, '\d')
        return "\<Esc>o"
      elseif CurChar(1, '}') || CurChar(1, ']')
        return <sid>SmartCR()
      else
        return "\<Plug>(EolCR)"
      endif
    endif
  endfunction
endif
"}}}



"--------------------------------------------------------------------------------
" mapping
"--------------------------------------------------------------------------------
" MatchCl('^$')
if s:autocomplete_parens
  imap <Plug>(EolCR)  <Plug>delimitMateCR
else
  inoremap <expr><Plug>(EolCR)  exists('b:eol_marker')
        \ && ( CurChar(0, '\w') \|\| MatchCl('return.*)') )
        \ ? b:eol_marker."\<CR>" 
        \ : "\<CR>"
endif


inoremap <expr><Plug>(SmartCR)  <sid>SmartCR()
function! s:SmartCR() abort " {{{
  let ftwhitelist = [
        \ 'vim',
        \ ]
  if index(ftwhitelist, &ft) > -1
    return "\<CR>\\\<Space>\<Esc>ko\\\<Space>"
  else
    return "\<CR>\<Esc>ko"
  endif
endfunction  " }}}

