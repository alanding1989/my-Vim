"================================================================================
" Description: SpaceVimrc
" Section:     config/SpaceVim
"================================================================================
scriptencoding utf-8



" Themes List: " {{{
let g:spacevim_colorscheme = split([
      \ '0 gruvbox'     ,
      \ '1 one'         ,
      \ '2 onedark'     ,
      \ '3 palenight'   ,
      \ '4 neodark'     ,
      \ '5 OceanicNext' ,
      \ '6 PaperColor'  ,
      \ '7 nord'        ,
      \ '8 NeoSolarized',
      \ '9 default'     ,
      \ ][1])[1]
let g:spacevim_colorscheme_default = 'nord'
let g:spacevim_colorscheme_bg      = 1 ? 'dark' : 'light'
let g:spacevim_enable_guicolors    = 1
"}}}


"================================================================================
" Preferences: 
"================================================================================
let g:spacevim_autocomplete_method  = get(['coc'       , 'deoplete' , 'ncm2', 'ycm'], 0)
let g:spacevim_snippet_engine       = get(['neosnippet', 'ultisnips', 'coc' ], 0)
let g:spacevim_fuzzyfinder          = get(['leaderf'   , 'denite'   , 'fzf' ], 0)
let g:spacevim_filemanager          = get(['vimfiler'  , 'nerdtree' , 'defx'], 2)
let g:spacevim_statusline           = get(['airline'   , 'lightline', ''    ], 0)
let g:spacevim_enable_ale           = 1
let g:spacevim_enable_neomake       = !g:spacevim_enable_ale
let g:spacevim_lint_on_the_fly      = 1
let g:spacevim_autocomplete_parens  = 0
let g:enable_deotabline             = 0
let g:enable_googlesuggest          = 0
let s:enable_myhl                   = 1
" Choose minimal setting
let g:pure_viml = 0


" Ui: {{{
let g:enable_fat_statusline                  = 1
let g:statusline_separator                   = get(['fire', 'arrow', 'curve', 'slant'], 1)
let g:spacevim_statusline_left_sections      =  ['winnr', 'filename', 'syntax checking', 'minor mode lighters']
let g:spacevim_statusline_right_sections     += g:enable_smart_clock_startup ? ['date'] : ['time', 'date']
let g:spacevim_enable_statusline_mode        = 1
let g:spacevim_enable_statusline_bfpath      = 1
let g:spacevim_buffer_index_type             = 1
let g:spacevim_windows_index_type            = 0
let g:spacevim_enable_tabline_ft_icon        = 1
let g:spacevim_enable_os_fileformat_icon     = 1
let g:spacevim_sidebar_width                 = g:sidebar_width
let g:spacevim_filetree_direction            = g:filetree_direction
let g:spacevim_enable_vimfiler_welcome       = 0

let g:spacevim_error_symbol                  = g:linter_error_symbol
let g:spacevim_warning_symbol                = g:linter_warning_symbol
let g:spacevim_info_symbol                   = g:linter_info_symbol
"}}}

" System: {{{
let g:spacevim_checkinstall                  = 1
let g:spacevim_enable_debug                  = 0
let g:spacevim_auto_disable_touchpad         = 1
let g:spacevim_windows_smartclose            = ''
let g:spacevim_windows_leader                = ''
let g:spacevim_plugin_manager                = g:plugmanager
let g:spacevim_github_username               = g:github_username
let g:spacevim_guifont                       = g:guifont
let g:spacevim_music_path                    = g:is_win ? 'E:\娱乐影音\音乐' : '/mnt/fun+downloads/娱乐影音/音乐'
let g:spacevim_project_rooter_patterns       = uniq(sort(g:spacevim_project_rooter_patterns
      \ + deepcopy(g:project_root_marker)))
let g:currentbranch                          = split(filter(systemlist('git -C ~/.SpaceVim branch'),
      \ 'match(v:val, "*") > -1')[0], ' ')[1]
"}}}


"================================================================================
" Layers Variable Settings:
"============================================================================= {{{
function! My_SpaceVim_layers_variable(layer) abort
  return get({
        \ 'checkers' : {
        \     'show_cursor_error' : 1,
        \ },
        \ 'colorscheme' : {
        \     'bright_statusline' : 1,
        \     'random_theme'      : 0,
        \ },
        \ 'lang#c' : {
        \     'enable_clang_syntax_highlight': 1,
        \     'clang_executable': g:is_win ? 'D:\devtools\cpp\LLVM\bin\clang'
        \                                  : '/opt/lang-tools/cpp/clang/bin/clang',
        \     'libclang_path'   : g:is_win ? 'D:\devtools\cpp\LLVM\bin\libclang.dll'
        \                                  : '/opt/lang-tools/cpp/clang/lib/libclang.so',
        \     'clang_std'       : {
        \         'c'  : 'c11',
        \         'cpp': 'c++1z'},
        \ },
        \ 'lang#scala' : {
        \     'format_on_save'      : 0,
        \     'scala_formatter_path': g:is_win 
        \         ? 'D:\devtools\scala\scalariform.jar' 
        \         : '/opt/lang-tools/scala/scalariform.jar',
        \     'scala_formatter_scalafmt_config_path'   : g:home.'extools/conf/.scalafmt.conf', 
        \     'scala_formatter_scalariform_config_path': g:home.'extools/conf/scalariform.properties'
        \ },
        \ 'lang#lua' : {
        \     'repl_command': '/opt/lang-tools/lua/luarocks/bin/rep.lua'
        \ },
        \ 'lang#markdown' : {
        \     'enableWcwidth'  : 1,
        \     'listItemIndent' : 1,
        \ },
        \ 'lang#python' : {
        \     'format_on_save' : 1,
        \ },
        \ 'lang#ipynb'  : {
        \     'format_on_save' : 1,
        \ },
        \ 'shell' : {
        \     'default_height'   : 35,
        \     'default_position' : 'right',
        \ },
        \ 'VersionControl' : {
        \     'enable_gtm_status' : 0,
        \ },
        \ 'lsp' : {'filetypes' : extend([
        \     'c',
        \     'cpp',
        \     'go',
        \     'lua',
        \     'python',
        \     'ipynb',
        \     'vim', 
        \     ], g:is_unix ? ['sh'] : []
        \ )},
        \ 'defhighlight' : {
        \     'enable_vim_highlight' : 0,
        \     'hlcolor'  : s:enable_myhl ? g:_defhighlight_var.hlcolor : {}
        \ }
        \ }, a:layer, {})
  " \ 'javascript',
endfunction
" }}}


"================================================================================
" Layers Enable:
"     DefaultLayers:
"     autocomplete, checkers, core, edit, format, ui,
"============================================================================= {{{
let g:My_SpaceVim_layers = extend(get(g:, 'My_SpaceVim_layers', {
      \ 'lang#c'            : 0,
      \ 'lang#go'           : 0,
      \ 'lang#java'         : 0,
      \ 'lang#scala'        : 0,
      \ 'lang#python'       : 0,
      \ 'lang#ipynb'        : 0,
      \ 'lang#lua'          : 0,
      \ 'lang#lisp'         : 0,
      \ 'lang#javascript'   : 0,
      \ 'lang#markdown'     : 0,
      \ 'lang#latex'        : 0,
      \ 'VersionControl'    : 0,
      \ }), {
      \ 'checkers'          : 1,
      \ 'colorscheme'       : 1,
      \ 'debug'             : 1,
      \ 'git'               : 1,
      \ 'github'            : 1,
      \ 'lsp'               : 1,
      \ 'incsearch'         : 1,
      \ 'shell'             : 1,
      \ 'tools'             : 1,
      \ 'lang#vim'          : 1,
      \ 'lang#sh'           : g:is_unix,
      \ 'lang#ps1'          : g:is_win,
      \
      \ 'denite'            : 0,
      \ 'leaderf'           : 1,
      \
      \ 'chinese'           : 1,
      \ 'tmux'              : 0,
      \ 'chat'              : 0,
      \ })

if g:spacevim_fuzzyfinder ==# 'leaderf' " {{{
      \ && g:My_SpaceVim_layers['leaderf']
  let g:My_SpaceVim_layers['leaderf'] = 1
  " let g:My_SpaceVim_layers['denite']  = 1
  let g:My_SpaceVim_layers['fzf']     = 0
elseif g:spacevim_fuzzyfinder ==# 'denite'
  let g:My_SpaceVim_layers['denite']  = 1
  let g:My_SpaceVim_layers['leaderf'] = 0
  let g:My_SpaceVim_layers['fzf']     = 0
elseif g:spacevim_fuzzyfinder ==# 'fzf'
  let g:My_SpaceVim_layers['fzf']     = 1
  let g:My_SpaceVim_layers['denite']  = 0
  let g:My_SpaceVim_layers['leaderf'] = 0
endif "}}}

if g:spacevim_autocomplete_method ==# 'coc' "{{{
  let g:spacevim_snippet_engine   = 'coc'
  let g:spacevim_gitgutter_plugin = 'coc'
else
  let g:spacevim_gitgutter_plugin = 'vim-gitgutter'
endif
"}}}

if g:pure_viml || !g:has_py " {{{
  let g:spacevim_autocomplete_method = 'asyncomplete'
  let g:spacevim_snippet_engine      = 'neosnippet'
  let g:spacevim_filemanager         = 'vimfiler'
  let g:enable_smart_clock           = 0
  let g:My_SpaceVim_layers = {
        \ 'checkers'        : 1,
        \ 'colorscheme'     : 1,
        \ 'debug'           : 1,
        \ 'git'             : 1,
        \ 'github'          : 1,
        \ 'lsp'             : 1,
        \ 'lang#markdown'   : 1,
        \ 'lang#vim'        : 1,
        \ 'lang#sh'         : 1,
        \ 'incsearch'       : 1,
        \ 'shell'           : 1,
        \ 'tools'           : 1,
        \ 'unite'           : 1,
        \ }
endif
"}}}
"}}}


"================================================================================
" Disable Plugins:
"============================================================================= {{{
let g:spacevim_disabled_plugins = [
      \ 'molokai'              ,
      \ 'jellybeans.vim'       ,
      \ 'vim=hybrid'           ,
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
      \ 'vim-textobj-line'     ,
      \ 'vim-textobj-entire'   ,
      \ ]

if g:spacevim_autocomplete_method !=# 'deoplete'
  let g:spacevim_disabled_plugins += ['deoplete-zsh', 'deoplete-ternjs']
endif
if g:spacevim_snippet_engine !=# 'neosnippet'
  let g:spacevim_disabled_plugins += ['neopairs.vim']
endif
if g:My_SpaceVim_layers.git && g:spacevim_autocomplete_method ==# 'coc'
  let g:spacevim_disabled_plugins += ['vim-gitgutter']
endif
if g:spacevim_fuzzyfinder !=# 'denite' && g:My_SpaceVim_layers.denite
  let g:spacevim_disabled_plugins += ['neomru.vim', 'unite-outline']
endif
"}}}

