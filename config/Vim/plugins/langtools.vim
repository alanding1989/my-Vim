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
let s:codilog = g:is_win ? 'D:/.cache/Vim/codi_log' :
      \ '/home/alanding/.cache/Vim/'.(g:is_root ? '-root' : '-alan').'codi_log'
if glob(s:codilog) ==# ''
  let g:codi#log = expand(s:codilog)
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
if g:is_nvim
  if executable('rg')
    let g:far#source = 'rgnvim'
  elseif executable('ag')
    let g:far#source = 'agnvim'
  endif
else
  if executable('rg')
    let g:far#source = 'rg'
  elseif executable('ag')
    let g:far#source = 'ag'
  endif
endif

let g:far#default_file_mask = '%'
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
