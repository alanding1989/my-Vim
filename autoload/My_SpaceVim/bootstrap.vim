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
let g:My_SpaceVim_layers = {
      \ 'chat'              : 1,
      \ 'checkers'          : 1,
      \ 'chinese'           : 1,
      \ 'colorscheme'       : 1,
      \ 'debug'             : 1,
      \ 'git'               : 1,
      \ 'github'            : 1,
      \ 'lsp'               : 1,
      \ 'lang#c'            : 0,
      \ 'lang#ipynb'        : 1,
      \ 'lang#java'         : 0,
      \ 'lang#javascript'   : 0,
      \ 'lang#latex'        : 0,
      \ 'lang#markdown'     : 1,
      \ 'lang#python'       : 1,
      \ 'lang#scala'        : 1,
      \ 'lang#vim'          : 1,
      \ 'lang#sh'           : 1,
      \ 'incsearch'         : 1,
      \ 'shell'             : 1,
      \ 'tmux'              : 1,
      \ 'tools'             : 1,
      \ 'VersionControl'    : 0,
      \
      \ 'denite'            : 1,
      \ 'fzf'               : 0,
      \ 'leaderf'           : 1,
      \ 'unite'             : 0,
      \ }
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
if g:My_SpaceVim_layers['git'] == 1 && g:My_SpaceVim_layers['VersionControl'] == 1
  let g:spacevim_disabled_plugins += [
        \ 'vim-gitgutter'
        \ ]
  let g:spacevim_custom_plugins += [
        \ ['mhinz/vim-signify', {'merged' : 0}]
        \ ]
endif
if !get(g:My_SpaceVim_layers, 'denite', 0) && !get(g:My_SpaceVim_layers, 'unite', 0)
  let g:spacevim_disabled_plugins += [
        \ 'neomru.vim'    ,
        \ 'unite-outline' ,
        \ ]
endif
"}}}
endfunction


function! My_SpaceVim#bootstrap#after() abort

endfunction
