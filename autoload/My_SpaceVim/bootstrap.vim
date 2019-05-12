"================================================================================
" bootstrap.vim -- for init.toml entry
" Section: My_SpaceVim
"================================================================================
scriptencoding utf-8




function! My_SpaceVim#bootstrap#before() abort
  " load minimal setting
  let g:home = glob('~/.SpaceVim.d/')
  call default#load()
  auto VimEnter * call util#so_file('keymap.vim', 'SPC')


" ================================================================================
" En/Disabled plugins
" ============================================================================= {{{
let g:spacevim_disabled_plugins = [
      \ 'molokai'              ,
      \ 'jellybeans.vim'       ,
      \ 'vim-one'              ,
      \ 'vim-hybrid'           ,
      \ 'vim-material'         ,
      \ 'srcery-vim'           ,
      \ 'vim-grepper'          ,
      \ 'neosnippet-snippets'  ,
      \ 'vim-snippets'         ,
      \ 'CompleteParameter.vim',
      \ 'unite-gtags'          ,
      \ 'denite-gtags'         ,
      \ 'tagbar'               ,
      \ 'tagbar-makefile.vim'  ,
      \ 'tagbar-proto.vim'     ,
      \ 'tagbar-markdown'      ,
      \ 'vim-scriptease'       ,
      \ 'vim-multiple-cursors' ,
      \ 'vim-textobj-line'     ,
      \ 'vim-textobj-entire'   ,
      \ ]
if g:spacevim_autocomplete_method !=# 'deoplete'
  let g:spacevim_disabled_plugins += [
        \ 'deoplete-zsh'   ,
        \ 'deoplete-ternjs',
        \ ]
endif
if g:spacevim_snippet_engine !=# 'neosnippet'
  let g:spacevim_disabled_plugins += [
        \ 'neopairs.vim'   ,
        \ ]
endif
if g:my_layers['git'] == 1 && g:my_layers['VersionControl'] == 1
  let g:spacevim_disabled_plugins += [
        \ 'vim-gitgutter'
        \ ]
  let g:spacevim_custom_plugins += [
        \ ['mhinz/vim-signify', {'merged' : 0}]
        \ ]
endif
if !get(g:my_layers, 'denite', 0) && !get(g:my_layers, 'unite', 0)
  let g:spacevim_disabled_plugins += [
        \ 'neomru.vim'    ,
        \ 'unite-outline' ,
        \ ]
endif
"}}}
endfunction


function! My_SpaceVim#bootstrap#after() abort

endfunction
