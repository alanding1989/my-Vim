" ================================================================================
" deoplete config file for Vim
" ================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1



let g:neosnippet#enable_complete_done = 1
let g:tmuxcomplete#trigger = ''

let g:deoplete#enable_at_startup = 1
" auto InsertEnter * call deoplete#enlble()


" deoplete options
call deoplete#custom#option({
      \ 'auto_complete_delay' :  50,
      \ 'ignore_case'         :  get(g:, 'deoplete#enable_ignore_case', 1),
      \ 'smart_case'          :  get(g:, 'deoplete#enable_smart_case', 1),
      \ 'camel_case'          :  get(g:, 'deoplete#enable_camel_case', 1),
      \ 'refresh_always'      :  get(g:, 'deoplete#enable_refresh_always', 1)
      \ })


" let g:deoplete#max_abbr_width = get(g:, 'deoplete#max_abbr_width', 0)
" let g:deoplete#max_menu_width = get(g:, 'deoplete#max_menu_width', 0)
" init deoplet option dict
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources',{})
let g:deoplete#omni#input_patterns = get(g:, 'deoplete#omni#input_patterns',{})
let g:deoplete#omni_patterns = get(g:, 'deoplete#omni_patterns', {})
let g:deoplete#keyword_patterns = get(g:, 'deoplete#keyword_patterns', {})

" java && jsp
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'java': [
      \           '[^. \t0-9]\.\w*',
      \           '[^. \t0-9]\->\w*',
      \           '[^. \t0-9]\::\w*',
      \         ],
      \ 'jsp':  ['[^. \t0-9]\.\w*'],
      \})
if get(g:, 'enable_javacomplete2_py', 0)
  call deoplete#custom#option('ignore_sources', {'java': ['omni']})
  call deoplete#custom#source('javacomplete2', 'mark', 'ja')
else
  call deoplete#custom#option('ignore_sources', {'java': ['javacomplete2', 'around', 'member']})
  call deoplete#custom#source('omni', 'mark', '')
  call deoplete#custom#source('omni', 'rank', 9999)
endif

" sh
call deoplete#custom#option('ignore_sources', {'sh': ['around', 'member', 'tag', 'syntax']})

" go
call deoplete#custom#option('ignore_sources', {'go': ['omni']})
call deoplete#custom#source('go', 'mark', 'go')
call deoplete#custom#source('go', 'rank', 9999)

" markdown
call deoplete#custom#option('ignore_sources', {'markdown': ['tag']})

" perl
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'perl': [
      \           '[^. \t0-9]\.\w*',
      \           '[^. \t0-9]\->\w*',
      \           '[^. \t0-9]\::\w*',
      \         ],
      \})

" javascript
call deoplete#custom#option('ignore_sources', {'javascript': ['omni']})
call deoplete#custom#source('ternjs', 'mark', 'tern')
call deoplete#custom#source('ternjs', 'rank', 9999)

" typescript
call deoplete#custom#option('ignore_sources', {'typescript': ['tag', 'omni', 'syntax']})
call deoplete#custom#source('typescript', 'rank', 9999)


" php two types, 1. phpcd (default)  2. lsp
if layers#lsp#checkft('php')
  if has('nvim')
    call deoplete#custom#option('ignore_sources', {'php': ['omni', 'around', 'member']})
  else
    call deoplete#custom#option('ignore_sources', {'php': ['around', 'member']})
  endif
else
  call deoplete#custom#option('ignore_sources', {'php': ['omni', 'around', 'member']})
endif

" gitcommit
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'gitcommit': [
      \       '[ ]#[ 0-9a-zA-Z]*',
      \ ],
      \})

call deoplete#custom#option('ignore_sources', {'gitcommit': ['neosnippet']})

" lua
let g:deoplete#omni_patterns.lua = get(g:deoplete#omni_patterns, 'lua', '.')

" c c++
call deoplete#custom#source('clang2', 'mark', 'cpp')
call deoplete#custom#option('ignore_sources', {'c': ['omni']})
let g:deoplete#sources#clang#libclang_path = expand($CLANG_HOME).(g:is_win ? '\bin\libclang.dll' : '/lib/libclang.so')
let g:deoplete#sources#clang#clang_header  = expand($CLANG_HOME)

" rust
call deoplete#custom#option('ignore_sources', {'rust': ['omni']})
call deoplete#custom#source('racer', 'mark', 'rust')

" vim
call deoplete#custom#option('ignore_sources', {'vim': ['tag']})
call deoplete#custom#source('vim'  , 'rank', 9999)
call deoplete#custom#source('neco-vim'  , 'rank', 9999)

" clojure
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'

" ocaml
call deoplete#custom#option('ignore_sources', {'ocaml': ['buffer', 'around', 'omni']})

" erlang
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'erlang': [
      \   '[^. \t0-9]\.\w*',
      \ ],
      \})

" python
call deoplete#custom#source('python', 'mark', 'py')
let g:deoplete#sources#jedi#python_path = g:python3_host_prog
" let g:deoplete#sources#jedi#extra_path  = g:python_host_prog



" public settings
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#source('_', 'filters' , ['matcher_head'])
call deoplete#custom#source('_', 'converters', ['converter_auto_delimiter', 'remove_overlap'])
call deoplete#custom#source('_', 'max_menu_width', 60)
call deoplete#custom#source('_', 'max_abbr_width', 30)

call deoplete#custom#source('buffer', 'mark', '*')
call deoplete#custom#source('buffer', 'rank', 9999)

call deoplete#custom#source('file/include' , 'matchers', ['matcher_head'])

" snippet
call deoplete#custom#source('neosnippet', 'rank', 1000)
call deoplete#custom#source('ultisnips' , 'rank', 1000)
call deoplete#custom#source('neosnippet', 'matchers', ['matcher_head'])
call deoplete#custom#source('ultisnips' , 'matchers', ['matcher_head'])

" deoplete-tabline
call deoplete#custom#source('tabline', 'rank', 800)
call deoplete#custom#var('tabline', {
      \ 'rank'           : 800,
      \ 'line_limit'     : 500,
      \ 'max_num_results': 20,
      \ })


set isfname-==

" vim:set et sw=2:
