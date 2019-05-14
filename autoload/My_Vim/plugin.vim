" ================================================================================
" plugin.vim -- load plugins
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
      \ 'denite'        ,
      \ 'git'           ,
      \ 'ui'            ,
      \ ]

" check manager installation
" load layers, plugins
" check uninstalled plugins and auto install
function! My_Vim#plugin#begin() abort
  let s:enabled_plugins_name = []
  let s:uninstalled_plugins  = []
  call s:check_manager_install()
  call s:load_plugin()

  if g:enable_checkinstall
    call s:check_plugin_install()
  endif
endfunction


function! s:load_plugin() abort "{{{
  for layer in s:enabled_layers_get()
    let plugins = layers#{layer}#plugins()
    if util#list#valid(plugins)
      for plugin in plugins
        call s:plugin_add(layer, plugin)
      endfor
    endif
  endfor
  if g:plugmanager ==# 'vim-plug'
    call plug#end()
  elseif g:plugmanager ==# 'dein'
    call dein#end()
  endif
endfunction "}}}


function! s:plugin_add(layer, plugin) abort " {{{
  let repo   = a:plugin[0]
  let config = get(a:plugin, 1, {})
  let plug_name = split(repo, '/')[-1]
  if index(get(g:, 'disabled_plugins', []), repo) == -1
    if g:plugmanager ==# 'vim-plug'
      Plug repo, config
      if finddir(expand(g:My_Vim_plug_dir).plug_name) ==# ''
        call add(s:uninstalled_plugins, plug_name)
      endif
    elseif g:plugmanager ==# 'dein'
      call dein#add(repo, config)
      if finddir(expand(g:My_Vim_plug_dir.'repos/github.com/'.repo)) ==# ''
        call add(s:uninstalled_plugins, plug_name)
      endif
    endif
    call add(s:enabled_plugins_name, plug_name)
    let str = '[' . a:layer . ']'
    let str = str . repeat(' ', 30 - len(str))
    call add(g:unite_source_menu_menus.AddedPlugins.command_candidates,
          \ [ str . '[' . repo . ']'
          \ . (len(config) > 0 ? repeat(' ', 45 - len(repo)) . '[lazy loaded]  [' . string(config) . ']'
          \ : '')
          \ , 'OpenBrowser https://github.com/' . repo
          \ ])
  else
    call remove(s:enabled_plugins_name, 'v:val != plug_name')
  endif
endfunction
"}}}


function! s:check_plugin_install() abort " {{{
  if len(s:uninstalled_plugins) > 0
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
    for elem in s:uninstalled_plugins
      call filter(s:enabled_plugins_name, 'v:val != elem')
    endfor
  endif
endfunction
"}}}


function! My_Vim#plugin#end() abort " {{{
  filetype plugin indent on
  syntax on
  if s:firstinstall | return | endif

  " load leyer config
  call map(deepcopy(g:enabled_layers), {key, val -> layers#{val}#config()})

  " load enabled_plugins global config variable
  let enabled_pluglist = map(deepcopy(s:enabled_plugins_name),
        \ {key, val -> g:vim_plugindir . fnamemodify(val, ':r').'.vim'})
  let filelist = util#globpath(g:vim_plugindir, '*.vim')
  for fpath in filelist
    if index(enabled_pluglist, fpath) > 0
      exec 'so ' fpath
    endif
  endfor

  " load default_layers global variable
  let defaultload = ['autocomp_plugins', 'snippet', 'langtools', 'ui' ]
  call map(deepcopy(defaultload), {key, val -> util#so_file('plugins/'.val.'.vim', 'Vim')})

  " Hotkey menu
  " call util#so_file('keymap.vim', 'Vim')
endfunction
"}}}


" util functions {{{
function! s:check_manager_install() abort "{{{
  if g:plugmanager ==# 'vim-plug' "{{{
    if glob('~/.vim.d/autoload/plug.vim') ==# ''
      exec '!curl -fLo "'.expand('~/.SpaceVim.d/autoload/plug.vim')
            \.'" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
      auto VimEnter * PlugInstall --sync | source $MYVIMRC
      let s:firstinstall = 1
    else
      let s:firstinstall = 0
    endif
    call plug#begin(g:My_Vim_plug_dir) "}}}

  elseif g:plugmanager ==# 'dein' "{{{
    if glob(g:My_Vim_plug_dir.'repos/github.com/Shougo/dein.vim') ==# ''
      exec '!git clone git@github.com:Shougo/dein.vim.git "'
            \.expand(g:My_Vim_plug_dir.'repos/github.com/Shougo/dein.vim').'"'
      let s:firstinstall = 1
    else
      let s:firstinstall = 0
    endif
    exec 'set runtimepath+='.expand(g:My_Vim_plug_dir.'repos/github.com/Shougo/dein.vim/')

    call dein#begin(g:My_Vim_plug_dir)
    call dein#add('Shougo/dein.vim')
  endif "}}}
  let g:unite_source_menu_menus = get(g:, 'unite_source_menu_menus', {})
  let g:unite_source_menu_menus.AddedPlugins =
        \ {'description':
        \ 'All the Added plugins'
        \ . '                    <space>qp'}
  let g:unite_source_menu_menus.AddedPlugins.command_candidates = []
endfunction "}}}

function! s:enabled_layers_get() abort
  if !My_Vim#Main#isfallback()
    for [layer, value] in items(g:My_Vim_layers)
      let var = get(g:, '_'. layer .'_var', {})
      if value == 1 && util#dict#valid(var)
        call add(s:default_layers, layer)
        call layers#{layer}#set_option(var)
      elseif value == 1
        call add(s:default_layers, layer)
      else
        call filter(s:default_layers, 'v:val !=# layer')
      endif
    endfor
  endif
  let g:enabled_layers = uniq(sort(s:default_layers))
  return g:enabled_layers
endfunction
