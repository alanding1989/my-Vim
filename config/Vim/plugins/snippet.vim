" ================================================================================
" snippet global settings
" -- for SpaceVim & Vim
" ================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


" ================================================================================
" neosnippet
" ================================================================================
if get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet')) ==# 'neosnippet'
  let g:neosnippet#expand_word_boundary     = 1
  let g:neosnippet#enable_completed_snippet = 1
  let g:neosnippet#enable_complete_done     = get(g:, 'neosnippet#enable_complete_done')
  " the later same snips will overwrite the former snippets
  let g:neosnippet#snippets_directory       = g:is_win ? [
        \ expand('D:/.cache/vimfiles/repos/github.com/alanding1989/my-vim-snippets/snippets'),
        \ expand('D:/.cache/vimfiles/repos/github.com/alanding1989/my-neosnippet-snippets/neosnippets'),
        \ ] : [
        \ expand('/home/alanding/.cache/vimfiles-alan/repos/github.com/alanding1989/my-vim-snippets/snippets'),
        \ expand('/home/alanding/.cache/vimfiles-alan/repos/github.com/alanding1989/my-neosnippet-snippets/neosnippets'),
        \ ]
  let g:neosnippet#scope_aliases            = {
        \ 'ipynb' : 'python',
        \ }


" ================================================================================
" ultisnips
" ================================================================================
elseif get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine')) ==# 'ultisnips'
  " NOTE: inoremap don`t use this
  let g:UltiSnipsExpandTrigger                   = '<Plug>(UltiSnips_Expand_Jump)'
  let g:UltiSnipsJumpForwardTrigger              = '<Plug>(UltiSnips_Expand_Jump)'
  let g:UltiSnipsJumpBackwardTrigger             = '<Plug>(UltiSnips_JumpBackwards)'
  let g:UltiSnipsEditSplit                       = 'vertical'
  " if edit snippets, first search '&ft.snippets' in the follow 1th dir,
  " then the 2nd dir, if none create new '&ft.snippets'
  let g:UltiSnipsSnippetsDir                     = g:is_win ?
        \ expand('D:/.cache/vimfiles/repos/github.com/alanding1989/my-vim-snippets/UltiSnips') :
        \ expand('/home/alanding/.cache/vimfiles-alan/repos/github.com/alanding1989/my-vim-snippets/UltiSnips')
  let g:UltiSnipsSnippetDirectories              = g:is_win ? [
        \ expand('D:/.cache/vimfiles/repos/github.com/alanding1989/my-vim-snippets/UltiSnips')
        \ ] : [
        \ expand('/home/alanding/.cache/vimfiles-alan/repos/github.com/alanding1989/my-vim-snippets/UltiSnips')
        \ ]
  let g:UltiSnipsUsePythonVersion                = 3
  let g:complete_parameter_use_ultisnips_mapping = 1
endif
