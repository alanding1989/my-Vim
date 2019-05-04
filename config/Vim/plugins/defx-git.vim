"================================================================================
" File Name    : config/Vim/plugins/defx-git.vim
" Author       : AlanDing
" mail         :
" Created Time : Sat 04 May 2019 12:44:54 AM CST
"================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1




let g:defx_git#indicators = {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✭',
  \ 'Untracked' : '✚',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ }
auto FileType defx
      \ nnoremap <buffer><silent> [c <Plug>(defx-git-prev) |
      \ nnoremap <buffer><silent> ]c <Plug>(defx-git-next)

