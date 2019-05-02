"================================================================================
" File Name    : config/Vim/plugins/asyncomplete.vim
" Author       : AlanDing
" mail         :
" Created Time : Sat 20 Apr 2019 06:42:11 PM CST
"================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


let g:asyncomplete_auto_completeopt = 0

auto VimEnter * inoremap <expr><c-e>
      \ pumvisible() ? (g:pure_viml ?
      \ asyncomplete#cancel_popup() : "\<c-e>") : "\<end>"

" sources {{{
if !g:is_spacevim
  augroup asyncompelet_buffer
    autocmd!
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
          \ 'name': 'B',
          \ 'whitelist': ['*'],
          \ 'blacklist': ['go'],
          \ 'completor': function('asyncomplete#sources#buffer#completor'),
          \ }))
  augroup END
  augroup asyncomplete_clang
    autocmd!
    autocmd User asyncomplete_setup call asyncomplete#register_source(
          \ asyncomplete#sources#clang#get_source_options({
          \     'config': {
          \         'clang_path': get(g:, 'asyncomplete_clang_executable', 'clang'),
          \         'clang_args': {
          \             'default': ['-I/opt/llvm/include'],
          \         }
          \     }
          \ }))
  augroup END
  augroup asyncomplete_necovim
    autocmd!
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
          \ 'name': 'necovim',
          \ 'whitelist': ['vim'],
          \ 'completor': function('asyncomplete#sources#necovim#completor'),
          \ }))
  augroup END
  augroup asyncomplete_omni
    autocmd!
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
          \ 'name': 'omni',
          \ 'whitelist': ['*'],
          \ 'blacklist': ['html', 'c', 'cpp'],
          \ 'completor': function('asyncomplete#sources#omni#completor')
          \  }))
  augroup END
endif
"}}}
