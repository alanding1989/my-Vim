" ================================================================================
" langtools layer global settings
" ================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1



"================================================================================
" codi
"================================================================================
" NOTE: when debug set below value to 1
" let g:codi#raw = 1
if glob($HOME.'/.cache/Vim/codi_log/codi_log') ==# ''
  call mkdir(expand($HOME.'/.cache/Vim/codi_log'), 'p', 0700)
  let g:codi#log = expand($HOME.'/.cache/Vim/codi_log/codi_log')
endif

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
      \ 'ipynb'         : 'python',
      \ 'sbt'           : 'scala',
      \ }



"================================================================================
" far
"================================================================================
let g:far#source = 'rgnvim'
if g:is_win
  let g:far#file_mask_favorites = [
        \ '%', '**\*.*', '**\*.py', '**\*.scala', '**\*.sh',
        \ '**\*.vim', '**\*.html', '**\*.js', '**\*.css'
        \ ]
else
  let g:far#file_mask_favorites = [
        \ '%', '**/*.*', '**/*.py', '**/*.scala', '**/*.sh',
        \ '**/*.vim', '**/*.html', '**/*.js', '**/*.css'
        \ ]
endif
