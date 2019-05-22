" markdown-preview.nvim
"================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help',
      \ ]

" " set to 1, the vim will open the preview window once enter the markdown buffer
" let g:mkdp_auto_start = 1
"
" " set to 1, the vim will auto open preview window when you edit the markdown file
" let g:mkdp_auto_open = 1
