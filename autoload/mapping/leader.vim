"================================================================================
" File Name    : autoload\mapping\leader.vim
" Author       : AlanDing
" Created Time : 2019/4/18 4:25:42
"================================================================================
scriptencoding utf-8


function! mapping#leader#init() abort
  let g:which_key_map = {}
  call which_key#register('<Space>', 'g:which_key_map')
  nnoremap <silent><leader>       :WhichKey get(g:, 'mapleader', ';')<CR>
  vnoremap <silent><leader>       :WhichKeyVisual get(g:, 'mapleader', ';')<CR>
  nnoremap <silent><localleader>  :WhichKey get(g:, 'localleader', '<Space>')<CR>
  vnoremap <silent><localleader>  :WhichKeyVisual get(g:, 'localleader', '<Space>')<CR>

  augroup MyVim_which_key
    autocmd! FileType which_key
    autocmd  FileType which_key set laststatus=2 noshowmode noruler
          \| autocmd BufLeave <buffer> set laststatus=2 ruler
  augroup END
endfunction
