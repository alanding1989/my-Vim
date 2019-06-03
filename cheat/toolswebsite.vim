"================================================================================
" File Name    : cheat/toolswebsite.vim
" Author       : AlanDing
" Created Time : Mon 03 Jun 2019 01:21:16 PM CST
" Description  : 
"================================================================================
scriptencoding utf-8



" Customiezd Websites:
let s:url = {
      \ 'scala': 'https://www.scala-lang.org/api/current/index.html?search=',
      \ 'arec' : 'https://asciinema.org/~alanding',
      \ 'spc'  : 'https://spacevim.org/cn/layers',
      \ 'sh'   : 'https://www.explainshell.com/',
      \ }


function! OpenlinkOrSearch(key, ...) abort
  if a:0
    exec 'OpenBrowser '.s:url[a:key].a:1
  else
    exec 'OpenBrowser '.s:url[a:key]
  endif
endfunction


function! s:defineKeyMapping() abort
  if g:is_spacevim " {{{
    let g:_spacevim_mappings.o          = get(g:_spacevim_mappings, 'o', {'name': '+@ OpenBrowser'})
    let g:_spacevim_mappings.o.c        = ['OpenlinkOrSearch arec', 'open my asciinema cast']
    let g:_spacevim_mappings.o['[SPC]'] = ['OpenlinkOrSearch spc' , 'open SpaceVim CN website']

    " language docs
    augroup layer_core_openbrowser
      autocmd!
      auto FileType python,ipynb call SpaceVim#mapping#def('nnoremap', '<leader>op',
            \ 'call feedkeys(":OpenBrowserSmartSearch -python ")',
            \ 'docs search /python', 1)
      auto FileType scala        call SpaceVim#mapping#def('nnoremap', '<leader>os',
            \ 'call feedkeys(":OpenlinkOrSearch scala ")',
            \ 'docs search /scala', 1)
      auto FileType sh           call SpaceVim#mapping#def('nnoremap', '<leader>os',
            \ 'call feedkeys(":OpenlinkOrSearch sh ")',
            \ 'explainshell.com', 1)
    augroup END
     " }}}

  else " {{{
    nnoremap <leader>oc        :OpenlinkOrSearch arec<CR>
    nnoremap <leader>o<Space>  :OpenlinkOrSearch spc<CR>

    " language docs
    augroup layer_core_openbrowser
      autocmd!
      auto FileType python,ipynb nnoremap <buffer><leader>op
            \ :call feedkeys(':OpenBrowserSmartSearch -python ')<CR>
      auto FileType scala        nnoremap <buffer><leader>os
            \ :call feedkeys(':OpenlinkOrSearch scala ')<CR>
      auto FileType sh           nnoremap <buffer><leader>os
            \ :call feedkeys(':OpenlinkOrSearch sh ')<CR>
    augroup END
  endif  " }}}
endfunction

call <sid>defineKeyMapping()

