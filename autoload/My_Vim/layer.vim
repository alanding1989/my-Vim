" ================================================================================
" layer.vim
" Sector: My_Vim
" ================================================================================
scriptencoding utf-8


let s:default_layers = [
      \ 'autocomplete'  ,
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
    call s:vim_plug_begin()
  elseif g:plugmanager ==# 'dein'
    call s:dein_begin()
  else
    echoerr 'invalid name for plugmanager'
    let g:plugmanager = 'vim-plug'
    call s:vim_plug_begin()
  endif
  if g:enable_checkinstall
    call s:check_install()
  endif
endfunction

" vim-plug {{{
function! s:vim_plug_begin() abort
  " install vim-plug {{{
  if glob('~/.SpaceVim.d/autoload/plug.vim') ==# ''
    !curl -fLo ~/.SpaceVim.d/autoload/plug.vim --create-dirs
          \https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    auto VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  " init vim-plug }}}
  call s:Unite_Plugmenu_begin('~/.cache/Vim/vim-plug')
  for elem in g:enabled_plugins
    let repo = elem[0]
    let plug_name = split(repo, '/')[-1]
    if index(get(g:, 'disabled_plugins', []), repo) == -1
      Plug repo, get(elem, 1, {})
      call add(g:enabled_plugins_name, plug_name)
      if finddir('~/.cache/Vim/vim-plug/'.plug_name) ==# ''
        call add(g:uninstalled_plugins, plug_name)
      endif
    else
      call remove(g:enabled_plugins, 'v:val != elem')
    endif
  endfor
  call plug#end()
endfunction
"}}}

" dein {{{
function! s:dein_begin() abort
  " install dein {{{
  if glob('~/.cache/Vim/dein-plug/repos/github.com/Shougo/dein.vim') ==# ''
    call mkdir(expand('~/.cache/Vim/dein-plug/repos/github.com/Shougo/dein.vim'), 'p', '0700')
    exec '!git clone git@github.com:Shougo/dein.vim "'
          \ .expand('~/.cache/Vim/dein-plug/repos/github.com/Shougo/dein.vim').'"'
  endif
  " init dein }}}
  if &compatible | set nocompatible | endif
  set runtimepath+=~/.cache/Vim/dein-plug/repos/github.com/Shougo/dein.vim
  if s:check_plugchange() || dein#load_state('~/.cache/Vim/dein-plug')
    let firstinstall = len(g:enabled_plugins_name) == 0 ? 1 : 0
    call s:Unite_Plugmenu_begin('~/.cache/Vim/dein-plug')
    call dein#add('~/.cache/Vim/dein-plug/repos/github.com/Shougo/dein.vim')
    call dein#add('wsdjeg/dein-ui.vim')
    for elem in g:enabled_plugins
      let repo = elem[0]
      let plug_name = split(repo, '/')[-1]
      if index(get(g:, 'disabled_plugins', []), repo) == -1
        call dein#add(repo, get(elem, 1, {}))
        if firstinstall | call add(g:enabled_plugins_name, plug_name) | endif
        if finddir(expand('~/.cache/Vim/dein-plug/repos/github.com/'.repo)) ==# ''
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
  let s:filepath = expand('~/.cache/Vim/dein_check_plugchange.vim')
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

function! s:check_install() abort
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

function! My_Vim#layer#plug_end() abort
  " load leyer config (almost keymap setting)
  call map(deepcopy(g:enabled_layers), {key, val -> layers#{val}#config()})

  " " load enabled_plugins global config var
  " let g:plugnamelist = map(deepcopy(get(g:, 'enabled_plugins_name', [])),
  "       \ {key, val -> split(val, '\.')[0].'.vim'})
  " for file in systemlist('ls '.g:vim_plugindir)
  "   if index(g:plugnamelist, file) > -1
  "     exec 'so '.g:vim_plugindir . file
  "   endif
  " endfor
  " " load default_layers global var
  " let defaultload = ['autocomp_plugins', 'snippet', 'langtools', 'ui' ]
  " call map(deepcopy(defaultload), {key, val -> util#so_file('plugins/'.val.'.vim', 'Vim')})

  filetype plugin indent on
  syntax on
endfunction

" util func {{{
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
  if g:My_Vim_layers != {}
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
"}}}

function! My_Vim#layer#isLoaded(name) abort
  return index(g:enabled_layers, a:name) != -1
endfunction
