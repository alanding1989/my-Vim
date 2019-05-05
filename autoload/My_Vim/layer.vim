" ================================================================================
" layer.vim
" Sector: My_Vim
" ================================================================================
scriptencoding utf-8


let s:default_layers = [
      \ 'autocomplete'  ,
      \ 'colorscheme'   ,
      \ 'checkers'      ,
      \ 'core'          ,
      \ 'edit'          ,
      \ 'format'        ,
      \ 'leaderf'       ,
      \ 'VersionControl',
      \ 'ui'            ,
      \ ]
let g:enabled_plugins_name = []
let g:uninstalled_plugins  = []


function! My_Vim#layer#plug_begin() abort
  let g:enabled_plugins = s:enabled_plugins_get()
  if g:plugmanager     ==# 'vim-plug'
    let g:My_Vim_plug_dir = g:is_win ? 'D:/.cache/My_Vim/vim-plug/'  :
      \ '/home/alanding/.cache/My_Vim'.(g:is_root ? '-root' : '-alan').'/vim-plug/'
    call s:vim_plug_begin()
  elseif g:plugmanager ==# 'dein'
    let g:My_Vim_plug_dir = g:is_win ? 'D:/.cache/My_Vim/dein-plug/' :
      \ '/home/alanding/.cache/My_Vim'.(g:is_root ? '-root' : '-alan').'/dein-plug/'
    call s:dein_begin()
  else
    echoerr 'invalid name for plugmanager'
    let g:plugmanager = 'vim-plug'
    let g:My_Vim_plug_dir = g:is_win ? 'D:/.cache/My_Vim/vim-plug/'  :
      \ '/home/alanding/.cache/My_Vim'.(g:is_root ? '-root' : '-alan').'/vim-plug/'
    call s:vim_plug_begin()
  endif
  if g:enable_checkinstall
    call s:check_install()
  endif
endfunction


function! s:vim_plug_begin() abort " {{{
  " install vim-plug {{{
  if glob('~/.vim.d/autoload/plug.vim') ==# ''
    exec '!curl -fLo "'.expand('~/.vim.d/autoload/plug.vim')
          \.'" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    auto VimEnter * PlugInstall --sync | source $MYVIMRC
    let s:firstinstall = 1
  else
    let s:firstinstall = 0
  endif
  " init vim-plug }}}
  call s:Unite_Plugmenu_begin(g:My_Vim_plug_dir)
  for elem in g:enabled_plugins
    let repo = elem[0]
    let plug_name = split(repo, '/')[-1]
    if index(get(g:, 'disabled_plugins', []), repo) == -1
      Plug repo, get(elem, 1, {})
      call add(g:enabled_plugins_name, plug_name)
      if finddir(expand(g:My_Vim_plug_dir).plug_name) ==# ''
        call add(g:uninstalled_plugins, plug_name)
      endif
    else
      call remove(g:enabled_plugins, 'v:val != elem')
    endif
  endfor
  call plug#end()
endfunction
"}}}


function! s:dein_begin() abort " {{{
  " install dein {{{
  if glob(g:My_Vim_plug_dir.'repos/github.com/Shougo/dein.vim') ==# ''
    call mkdir(expand(g:My_Vim_plug_dir.'repos/github.com/Shougo/dein.vim'), 'p', '0700')
    exec '!git clone git@github.com:Shougo/dein.vim.git "'
          \.expand(g:My_Vim_plug_dir.'repos/github.com/Shougo/dein.vim').'"'
    let s:firstinstall = 1
  else
    let s:firstinstall = 0
  endif
  " init dein }}}
  if &compatible | set nocompatible | endif
  exec 'set runtimepath+='.expand(g:My_Vim_plug_dir.'repos/github.com/Shougo/dein.vim')
  if s:check_plugchange() || dein#load_state(g:My_Vim_plug_dir)
    call s:Unite_Plugmenu_begin(g:My_Vim_plug_dir)
    call dein#add(g:My_Vim_plug_dir.'repos/github.com/Shougo/dein.vim')
    call dein#add('wsdjeg/dein-ui.vim')
    for elem in g:enabled_plugins
      let repo = elem[0]
      let plug_name = split(repo, '/')[-1]
      if index(get(g:, 'disabled_plugins', []), repo) == -1
        call dein#add(repo, get(elem, 1, {}))
        if s:firstinstall | call add(g:enabled_plugins_name, plug_name) | endif
        if finddir(expand(g:My_Vim_plug_dir.'repos/github.com/'.repo)) ==# ''
          call add(g:uninstalled_plugins, plug_name)
        endif
      else
        call remove(g:enabled_plugins, 'v:val != elem')
      endif
    endfor
    call dein#end()
    call dein#save_state()
    call writefile(g:enabled_plugins_name, s:filepath)
  endif
endfunction

" Note: only for dein use
function! s:check_plugchange() abort
  let s:filepath = expand(g:My_Vim_plug_dir.'dein_check_plugchange.vim')
  if findfile(s:filepath) ==# ''
    exec 'silent !touch '.s:filepath
    return 1
  else
    for elem in g:enabled_plugins
      let repo = elem[0]
      let plug_name = split(repo, '/')[-1]
      if index(get(g:, 'disabled_plugins', []), repo) == -1
        call add(g:enabled_plugins_name, plug_name)
      endif
    endfor
    let last_plugins_name = readfile(s:filepath)
    if g:enabled_plugins_name !=# last_plugins_name
      return 1
    else
      return
    endif
  endif
endfunction
"}}}


function! s:check_install() abort " {{{
  if len(get(g:, 'uninstalled_plugins', [])) > 0
    echohl WarningMsg
    if g:plugmanager ==# 'dein'
      echo "\n dein Start to install Plugins,
            \please Restart Vim after finishing!\n"
    elseif g:plugmanager ==# 'vim-plug'
      echo "\n vim-plug Start to install Plugins,
            \please Restart Vim after finishing!\n"
    endif
    echohl None

    auto VimEnter * PlugInstall

    " don`t source uninstalled plugin`s config (global var and configfunc)
    for elem in g:uninstalled_plugins
      call filter(g:enabled_plugins_name, 'v:val != elem')
    endfor
  endif
endfunction
"}}}


function! My_Vim#layer#plug_end() abort " {{{
  filetype plugin indent on
  syntax on
  if s:firstinstall | return | endif

  " load leyer config (almost keymap setting)
  call map(deepcopy(g:enabled_layers), {key, val -> layers#{val}#config()})

  " load enabled_plugins global config var
  let g:plugnamelist = map(deepcopy(get(g:, 'enabled_plugins_name', [])),
        \ {key, val -> fnamemodify(val, ':r').'.vim'})
  " TODO: fix Windows
  let filelist = !g:is_win ? systemlist('ls '.g:vim_plugindir) : [
        \ 'ag.vim'            , 'ale.vim'              , 'asyncomplete.vim' , 'autocomp_plugins.vim'     , 'coc.vim'        ,
        \ 'defx.vim'          , 'defx-git.vim'         , 'defx-icons.vim'   , 'denite.vim'               , 'deoplete.vim'   ,
        \ 'git-p.vim'         , 'goyo.vim'             , 'langtools.vim'    , 'LanguageClient-neovim.vim', 'LeaderF.vim'    ,
        \ 'ncm2.vim'          , 'neco-vim.vim'         , 'neomake.vim'      , 'nerdcommenter.vim'        , 'nerdtree.vim'   ,
        \ 'snippet.vim'       , 'tagbar.vim'           , 'ui.vim'           , 'unite.vim'                , 'java_getset.vim',
        \ 'vim-grammarous.vim', 'vim-expand-region.vim', 'vim-gutentags.vim', 'vim-javacomplete2.vim'    , 'vim-lsp.vim'    ,
        \ 'vim-ref.vim'       , 'vim-signify.vim'      , 'vim-startify.vim' , 'vim-visual-multi.vim'     , 'vimfiler.vim'   ,
        \ 'vimpyter.vim'      , 'vista.vim'            , 'YouCompleteMe.vim', 'markdown-preview.vim'     ,
        \ ]
  for file in filelist
    if index(g:plugnamelist, file) > -1
      exec 'so '.g:vim_plugindir . file
    endif
  endfor
  " load default_layers global var
  let defaultload = ['autocomp_plugins', 'snippet', 'langtools', 'ui' ]
  call map(deepcopy(defaultload), {key, val -> util#so_file('plugins/'.val.'.vim', 'Vim')})
  " HotKey menu
  call util#so_file('keymap.vim', 'Vim')
endfunction
"}}}


" util functions {{{
let g:unite_source_menu_menus = get(g:, 'unite_source_menu_menus', {})
function! s:Unite_Plugmenu_begin(path) abort
  let g:unite_source_menu_menus.AddedPlugins =
        \ {'description':
        \ 'All the Added plugins'
        \ . '                    <space>qp'}
  let g:unite_source_menu_menus.AddedPlugins.command_candidates = []
  if g:plugmanager ==# 'vim-plug'
    call plug#begin(a:path)
  elseif g:plugmanager ==# 'dein'
    call dein#begin(a:path)
  endif
endfunction

function! s:enabled_plugins_get() abort
  let g:enabled_layers = s:enabled_layers_get()
  let enabled_plugins = []
  for layer in g:enabled_layers
    let enabled_plugins += layers#{layer}#plugins()
  endfor
  return enabled_plugins
endfunction

function! s:enabled_layers_get() abort
  if !get(g:, 'is_fallback', 0)
    for [layer, en_or_dis] in items(g:My_Vim_layers)
      if en_or_dis
        call add(s:default_layers, layer)
      else
        call filter(s:default_layers, 'v:val !=# layer')
      endif
    endfor
  endif
  return uniq(sort(s:default_layers))
endfunction

function! My_Vim#layer#isLoaded(name) abort
  return index(g:enabled_layers, a:name) != -1
endfunction
"}}}
