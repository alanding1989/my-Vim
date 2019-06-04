" ================================================================================
" My_SpaceVim.vim
" Personal configuration of SpaceVim
" ================================================================================
scriptencoding utf-8


" My Own layers
let s:define_my_layers  = ['tags', 'langtools', 'tools#clock', 'defhighlight']

" SpaceVim embedded layers
let s:add_plugin_layers = [
      \ 'autocomplete' , 'colorscheme', 'checkers'  , 'core'       , 'edit'    ,
      \ 'git'          , 'langtools'  , 'lang#latex', 'lang#python', 'lang#vim',
      \ 'lang#markdown', 'lang#ps1'   , 'lang#ipynb', 'ui'         ,
      \ ]
let s:modified_conf_layers = [
      \ 'autocomplete', 'chinese' , 'colorscheme'   , 'core'       , 'checkers',
      \ 'denite'      , 'edit'    , 'git'           , 'leaderf'    , 'tools'   ,
      \ 'unite'       , 'ui'      , 'VersionControl', 'lang#go'    , 
      \ 'lang#ipynb'  , 'lang#vim', 'lang#ps1'      , 'lang#scala' ,
      \ ]

let s:spacevim_default_cs = [
      \ 'gruvbox' , 'molokai' , 'onedark'      , 'jellybeans' , 'one'   ,
      \ 'nord'    , 'hybrid'  , 'NeoSolarized' , 'material'   , 'srcery', 'palenight'
      \ ]
let s:is_fallback = 0


" Main Function: {{{
function! My_SpaceVim#Main#init() abort
  " NOTE: the order shouldn`t be changed
  call   s:SpaceVim_config_load()
  " try
    call s:Mainbegin()
  " catch
    " call s:Mainfallback()
  " endtry
endfunction


function! s:Mainbegin() abort
  call s:SpaceVim_load_layers()
  " add custom plugins list
  call s:SpaceVim_add_plugins()

  " My addon config
  " load befoere SpaceVim source plugins
  call s:Mylayers_config_load()
  call s:VimEnter_layers_GlobalVar_load()

  " VimEnter config to override SpaceVim`s
  auto VimEnter * call s:VimEnter_config()
endfunction

function! s:Mainfallback() abort
  " only load core layer modified config
  let s:is_fallback = 1
  let g:spacevim_colorscheme = g:spacevim_colorscheme_default
  let g:My_SpaceVim_layers = {
        \ 'checkers'          : 1,
        \ 'colorscheme'       : 1,
        \ 'git'               : 1,
        \ 'github'            : 1,
        \ 'lang#vim'          : 1,
        \ 'shell'             : 1,
        \ 'denite'            : 1,
        \ 'leaderf'           : 1,
        \ }
  call s:Mainbegin()
endfunction

function! My_SpaceVim#Main#isfallback() abort
  return get(s:, 'is_fallback', 0)
endfunction
"}}}


"--------------------------------------------------------------------------------
" Load SpaceVim layers and plugins 
"----------------------------------------------------------------------------- {{{
function! s:SpaceVim_config_load() abort
  call util#so_file('config.vim', 'SPC')
endfunction

" load layers
function! s:SpaceVim_load_layers() abort
  " disable core#statusline when cs is not a SpaceVim embedded colorscheme
  if index(s:spacevim_default_cs, g:spacevim_colorscheme) == -1
    call SpaceVim#layers#disable('core#statusline')
    let g:spacevim_statusline_separator = 'nil'
    call s:loadlayers()
  else
    let g:spacevim_statusline_separator = g:statusline_separator
    call s:loadlayers()
  endif
endfunction

" add custom plugins
function! s:SpaceVim_add_plugins() abort
  if !s:is_fallback
    for layer in s:define_my_layers
      let plugins = layers#{layer}#plugins()
      if !empty(layer) && util#list#valid(plugins)
        let g:spacevim_custom_plugins += plugins
      endif
    endfor
  endif
  for layer in s:add_plugin_layers
    if SpaceVim#layers#isLoaded(layer)
      let g:spacevim_custom_plugins += layers#{layer}#plugins()
    endif
  endfor
endfunction

" load layer
function! s:loadlayers() abort
  for [layer, value] in items(g:My_SpaceVim_layers)
    let var = My_SpaceVim_layers_variable(layer)
    if value == 1 && util#dict#valid(var)
      call SpaceVim#layers#load(layer, var)
    elseif value == 1
      call SpaceVim#layers#load(layer)
    endif
  endfor
  if s:is_fallback
    let g:enabled_layers = sort(deepcopy(SpaceVim#layers#get()), 'i')
  else
    let g:enabled_layers = sort(deepcopy(SpaceVim#layers#get()) + s:define_my_layers, 'i')
  endif
endfunction
"}}}


"--------------------------------------------------------------------------------
" My addon config
"----------------------------------------------------------------------------- {{{

" NOTE: Personal layer which hasn`t been defined by SpaceVim, no need to load VimEnter
function! s:Mylayers_config_load() abort
  if s:is_fallback
    return
  endif
  for layer in s:define_my_layers
    if !empty(layer)
      let var = My_SpaceVim_layers_variable(layer)
      if util#dict#valid(var)
        call layers#{layer}#set_variable(var)
      endif
      call layers#{layer}#config()
    endif
  endfor
endfunction

" NOTE:
" 1. Plugin config which need to amend SpaceVim`s, lazyload ones can be defined after VimEnter
"    to override. Non-lazyload ones only take effect before sourcing plugins( before VimEnter),
"    ( SpaceVim defines these var after sourcing custom config, before VimEnter),
"    these can`t-changed var`s source code has been amended and copied in '/.SpaceVim.d/backup'.
" 2. Plugins which has global var must be defined before VimEnter to take effect. Due to reason 1,
"    for layers which need to amend SpaceVim`s, if there has global var that SpaceVim hasn`t defined,
"    i.e these global var must be set by myself, put these files in '/.SpaceVim.d/config/plugins_before'.
function! s:VimEnter_layers_GlobalVar_load() abort
  for layer in g:enabled_layers
    let layer = substitute(layer, '#', '_', 'g')
    let p = expand(g:home.'config/SpaceVim/plugins_before/'.layer.'.vim')
    if filereadable(p)
      exec 'so ' p
    endif
  endfor
endfunction

function! s:VimEnter_config() abort
  for layer in s:modified_conf_layers
    if SpaceVim#layers#isLoaded(layer)
      call layers#{layer}#config()
    endif
  endfor
  " misc mapping
  call util#so_file('keymap.vim', 'SPC')
endfunction
"}}}


