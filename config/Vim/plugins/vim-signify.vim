"================================================================================
" File Name    : config/Vim/plugins/vim-signify.vim
" Author       : AlanDing
" mail         :
" Created Time : Sat 04 May 2019 12:07:40 AM CST
"================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1



if g:is_spacevim
  if SpaceVim#layers#isLoaded('git')
    auto VimEnter * let g:signify_vcs_list = ['git']
  else
    auto VimEnter * let g:signify_vcs_list = ['hg']
  endif
else
  if My_Vim#layer#isLoaded('git')
    let g:signify_vcs_list = ['git']
  else
    let g:signify_vcs_list = ['hg']
  endif
endif


let g:signify_vcs_cmds               = {
      \ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
      \}


" let g:signify_disable_by_default     = 0
" let g:signify_line_highlight         = 0
let g:signify_update_on_focusgained  = 1
let g:signify_fold_context           = [0, 3]

let g:signify_sign_add               = '✚'
let g:signify_sign_delete            = '✖'
let g:signify_sign_delete_first_line = '▤'
let g:signify_sign_change            = '✹'
let g:signify_sign_changedelete      = '≃'
