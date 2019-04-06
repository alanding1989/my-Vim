"=========================================================================
" File Name    : config/Vim/plugins/vcs.vim
" Author       : AlanDing
" mail         :
" Created Time : Thu 04 Apr 2019 12:39:49 AM CST
"=========================================================================
scriptencoding utf-8



"--------------------------------------------------------------------------------
" vim-signify
"--------------------------------------------------------------------------------
let g:signify_vcs_cmds = {
      \ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
      \}
let g:signify_vcs_list = ['git', 'svn']
let g:signify_sign_add               = '✚'
let g:signify_sign_change            = '✹'
let g:signify_sign_delete            = '▤'
let g:signify_sign_delete_first_line = '✖'
let g:signify_sign_changedelete      = g:signify_sign_change



"--------------------------------------------------------------------------------
" git-p.nvim
"--------------------------------------------------------------------------------
if g:is_nvim
  let g:gitp_blame_virtual_text = 1
  " use custom highlight for blame virtual text
  " change GitPBlameLineHi to your highlight group
  highlight link GitPBlameLine IncSearch

  " format blame virtual text {{{
  " hash: commit hash
  " account: commit account name
  " date: YYYY-MM-DD
  " time: HH:mm:ss
  " ago: xxx ago
  " zone: +xxxx
  " commit: commit message
  " lineNum: line number }}}
  let g:gitp_blame_format = '   %{account} * %{ago} * %{date}    '

  " use custom highlight for diff sign
  " change the GitPAddHi GitPModifyHi GitPDeleteHi to your highlight group
  highlight link GitPAdd                GitPAddHi
  highlight link GitPModify             GitPModifyHi
  highlight link GitPDeleteTop          GitPDeleteHi
  highlight link GitPDeleteBottom       GitPDeleteHi
  highlight link GitPDeleteTopAndBottom GitPDeleteHi

  " let your sign column background same as line number column
  highlight! link SignColumn LineNr

  " use custom highlight for float diff preview window
  " change Pmenu to your highlight group
  highlight link GitPDiffFloat Pmenu

  " use custom diff sign
  let g:gitp_add_sign                   = '✚'
  let g:gitp_modify_sign                = '✹'
  let g:gitp_delete_top_sign            = '▤'
  let g:gitp_delete_bottom_sign         = '▤'
  let g:gitp_delete_top_and_bottom_sign = '✖'
endif
