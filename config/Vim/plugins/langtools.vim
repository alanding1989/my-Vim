" ================================================================================
" langtools layer global settings
" ================================================================================
scriptencoding utf-8


"================================================================================
" codi
"================================================================================
" NOTE: when debug set below value to 1
" let g:codi#raw = 1
let g:codi#log = $HOME.'/.cache/Vim/codi_log/'

" interpreter settings
let g:codi#interpreters = {
      \ 'python': {
      \ 'bin': 'python',
      \ 'prompt': '^\(>>>\|\.\.\.\) ',
      \ },
      \ }
let g:codi#interpreters = {
      \ 'javascript': {
      \ 'rightalign': 0,
      \ },
      \ }
let g:codi#aliases = {
      \ 'javascript.jsx': 'javascript',
      \ }



"================================================================================
" far
"================================================================================
let g:far#source = 'rgnvim'
let g:far#file_mask_favorites = [
      \ '%', '**/*.*', '**/*.py', '**/*.scala', '**/*.sh',
      \ '**/*.vim', '**/*.html', '**/*.js', '**/*.css'
      \ ]
