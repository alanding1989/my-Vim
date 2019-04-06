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
  let g:neosnippet#snippets_directory       = [
        \ '~/.cache/vimfiles/repos/github.com/alanding1989/my-vim-snippets/snippets',
        \ '~/.cache/vimfiles/repos/github.com/alanding1989/my-neosnippet-snippets/neosnippets',
        \ ]
  let g:neosnippet#scope_aliases            = {
        \ 'ipynb' : 'python',
        \ }
  " let g:neosnippet#disable_runtime_snippets = {
        " \   'c' : 1, 'cpp' : 1,
        " \ }


" " ================================================================================
" ultisnips
" ================================================================================
elseif get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine')) ==# 'ultisnips'
      " \ || get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine')) ==# 'coc'
  " NOTE: inoremap don`t use this
  let g:UltiSnipsExpandTrigger                   = '<Plug>(ultisnips_expand_jump)'
  let g:UltiSnipsJumpForwardTrigger              = '<Plug>(ultisnips_expand_jump)'
  let g:UltiSnipsJumpBackwardTrigger             = '<Plug>(ultisnips_prev)'
  let g:UltiSnipsEditSplit                       = 'vertical'
  let g:UltiSnipsSnippetsDir                     =
        \ '~/.cache/vimfiles/repos/github.com/alanding1989/my-vim-snippets/UltiSnips'
  let g:UltiSnipsSnippetDirectories              = [
        \ '~/.cache/vimfiles/repos/github.com/alanding1989/my-vim-snippets/'
        \ ]
  let g:UltiSnipsUsePythonVersion                = 3
  let g:complete_parameter_use_ultisnips_mapping = 1
endif
