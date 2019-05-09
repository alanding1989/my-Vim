" ================================================================================
" My_SpaceVim.vim
" Personal configuration of SpaceVim
" ================================================================================
scriptencoding utf-8


" MyVim layers
let s:define_my_layers  = ['tags', 'langtools', 'tools#clock' ]

" SpaceVim embedded layers
let s:add_plugin_layers = [
      \ 'autocomplete', 'colorscheme'  , 'checkers'  , 'edit'       ,
      \ 'git'         , 'langtools'    , 'lang#latex', 'lang#python',
      \ 'lang#vim'    , 'lang#markdown', 'lang#ps1'  , 'ui'         ,
      \ 'core'
      \ ]
let s:modified_conf_layers = [
      \ 'autocomplete', 'chinese', 'colorscheme', 'core'    , 'checkers'      ,
      \ 'denite'      , 'edit'   , 'git'        , 'lang#vim', 'lang#ps1'      ,
      \ 'leaderf'     , 'tools'  , 'unite'      , 'ui'      , 'VersionControl',
      \ ]

let s:spacevim_default_cs = [
      \ 'gruvbox' , 'molokai' , 'onedark'      , 'jellybeans' , 'one'   ,
      \ 'nord'    , 'hybrid'  , 'NeoSolarized' , 'material'   , 'srcery',
      \ ]

function! My_SpaceVim#Main#init() abort
  " NOTE: the order shouldn`t be changed
  call s:SpaceVim_config_load()
  call s:SpaceVim_load_layers()
  try
    call s:Mainbegin()
  catch
    let g:is_fallback = 1
    call s:Mainfallback()
  endtry
endfunction


" Main {{{
function! s:Mainbegin() abort
  call s:SpaceVim_add_plugins()
  call s:Mylayers_config_load()

  " My addon config
  call s:VimEnter_layers_GlobalVar_load()
  auto VimEnter * call s:VimEnter_config()
endfunction

function! s:Mainfallback() abort
  let g:spacevim_colorscheme = g:spacevim_colorscheme_default

  " My addon config
  call s:VimEnter_layers_GlobalVar_load()
  auto VimEnter * call s:VimEnter_config()
endfunction
"}}}


" ===================== Load SpaceVim layers and plugins ========================= {{{
function! s:SpaceVim_config_load() abort
  call util#so_file('config.vim', 'SPC')
endfunction

" load layers
function! s:SpaceVim_load_layers() abort
  " disable core#statusline when cs is not a SpaceVim embedded colorscheme
  if index(s:spacevim_default_cs, g:spacevim_colorscheme) == -1
    call SpaceVim#layers#disable('core#statusline')
    let g:spacevim_statusline_separator = 'nil'
  else
    let g:my_layers['VersionControl'] = 1
    let g:spacevim_statusline_separator = g:statusline_separator
  endif
  for [key, value] in items(g:my_layers)
    let var = get(g:, '_'.key.'_var')
    if value == 1 && type(var) == type({})
      call SpaceVim#layers#load(key, var)
    elseif value == 1
      call SpaceVim#layers#load(key)
    endif
  endfor
  let g:enabled_layers = sort(extend(deepcopy(SpaceVim#layers#get()), s:define_my_layers), 'i')
endfunction

" add custom plugins
function! s:SpaceVim_add_plugins() abort
  for layer in s:define_my_layers
    if !empty(layer)
      let g:spacevim_custom_plugins += layers#{layer}#plugins()
    endif
  endfor
  for layer in s:add_plugin_layers
    if SpaceVim#layers#isLoaded(layer)
      let g:spacevim_custom_plugins += layers#{layer}#plugins()
    endif
  endfor
endfunction
"}}}


" ============================== My addon config ================================= {{{
" NOTE: Personal layer which hasn`t been defined by SpaceVim, no need to load VimEnter
function! s:Mylayers_config_load() abort
  for elem in s:define_my_layers
    if !empty(elem)
      call layers#{elem}#config()
    endif
  endfor
endfunction

" NOTE:
" 1. Personal config which need to amend SpaceVim`s, some of them can be defined after VimEnter
"    to override. But some variable only take effect before loading plugins, i.e. before VimEnter
"    or lazyload time, (SpaceVim defined these var after sourcing custom config, before VimEnter),
"    these can`t-changed var`s source code has been amended and copied in '/.SpaceVim.d/backup'.
" 2. Plugins which has global var must be defined before VimEnter to take effect. Due to reason 1,
"    for layers which need to amend SpaceVim`s, if there has global var that SpaceVim hasn`t defined,
"    i.e these global var must be set by myself, put these files in '/.SpaceVim.d/config/plugins_before'.
function! s:VimEnter_layers_GlobalVar_load() abort
  for elem in g:enabled_layers
    let elem = substitute(elem, '#', '_', 'g')
    let p = expand(g:home.'config/SpaceVim/plugins_before/'.elem.'.vim')
    if filereadable(p)
      exec 'so ' p
    endif
  endfor
endfunction

function! s:VimEnter_config() abort
  if get(g:, 'is_fallback', 0) != 1
    for elem in s:modified_conf_layers
      if SpaceVim#layers#isLoaded(elem)
        call layers#{elem}#config()
      endif
    endfor
  else
    call layers#core#config()
  endif
  " misc mapping
  call util#so_file('keymap.vim', 'SPC')
endfunction
"}}}
