"================================================================================
" File Name    : cheat/toolswebsite.vim
" Author       : AlanDing
" Created Time : Mon 03 Jun 2019 01:21:16 PM CST
" Description  : 
"================================================================================
scriptencoding utf-8



" Customiezd Websites:
let s:url = {
      \ 'java' : 'https://docs.oracle.com/javase/8/docs/api/index.html?overview-summary.html',
      \ 'scala': 'https://www.scala-lang.org/api/current/index.html?search=',
      \ 'npm'  : 'https://www.npmjs.com/search?q=',
      \ 'sh'   : 'https://www.explainshell.com/',
      \ 'arec' : 'https://asciinema.org/~alanding',
      \ 'spc'  : 'https://spacevim.org/cn/layers',
      \ 'myspc': 'https://github.com/alanding1989/SpaceVim',
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
      auto FileType vim,startify
            \ call SpaceVim#mapping#def('nnoremap', '<leader>om', ':OpenlinkOrSearch myspc<CR>',
            \ 'open MySpaceVim github repo', '',  'open MySpaceVim github repo')
      auto FileType python,ipynb            
            \ call SpaceVim#mapping#def('nnoremap', '<leader>op', ':call feedkeys(":OpenBrowserSmartSearch -python ")<CR>',
            \ 'docs search @Python', '',  'docs search @Python')
      auto FileType java
            \ call SpaceVim#mapping#def('nnoremap', '<leader>oj', ':call feedkeys(":OpenlinkOrSearch java ")<CR>',
            \ 'docs search @Java', '',  'docs search @Java')
      auto FileType scala
            \ call SpaceVim#mapping#def('nnoremap', '<leader>os', ':call feedkeys(":OpenlinkOrSearch scala ")<CR>',
            \ 'docs search @Scala', '',  'docs search @Scala')
      auto FileType sh
            \ call SpaceVim#mapping#def('nnoremap', '<leader>os', ':call feedkeys(":OpenlinkOrSearch sh ")<CR>',
            \ 'explainshell.com', '',  'explainshell.com')
      auto FileType javascript,typescript
            \ call SpaceVim#mapping#def('nnoremap', '<leader>on', ':call feedkeys(":OpenlinkOrSearch npm ")<CR>',
            \ 'Node pkgs search', '',  'Node pkgs search')
    augroup END
     " }}}

  else " {{{
    nnoremap <leader>oc        :OpenlinkOrSearch arec<CR>
    nnoremap <leader>o<Space>  :OpenlinkOrSearch spc<CR>

    " language docs
    augroup layer_core_openbrowser
      autocmd!
      auto FileType vim,startify            :OpenlinkOrSearch myspc<CR>
      auto FileType python,ipynb 
            \ nnoremap <buffer><leader>op   :call feedkeys(':OpenBrowserSmartSearch -python ')<CR>
      auto FileType java
            \ nnoremap <buffer><leader>oj   :call feedkeys(':OpenlinkOrSearch java ')<CR>
      auto FileType scala
            \ nnoremap <buffer><leader>os   :call feedkeys(':OpenlinkOrSearch scala ')<CR>
      auto FileType sh
            \ nnoremap <buffer><leader>os   :call feedkeys(':OpenlinkOrSearch sh ')<CR>
      auto FileType javascript,typescript
            \ nnoremap <buffer><leader>on   :call feedkeys(":OpenlinkOrSearch npm ")<CR>
    augroup END
  endif  " }}}
endfunction

call <sid>defineKeyMapping()

