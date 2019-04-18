" ================================================================================
" SpaceVimrc
" Section config/SpaceVim
" ================================================================================
scriptencoding utf-8



" Themes list " {{{
let g:spacevim_colorscheme = split([
      \ '0 gruvbox'     ,
      \ '1 onedark'     ,
      \ '2 palenight'   ,
      \ '3 neodark'     ,
      \ '4 NeoSolarized',
      \ '5 OceanicNext' ,
      \ '6 PaperColor'  ,
      \ '7 nord'        ,
      \ ][2])[1]
let g:spacevim_colorscheme_default = 'nord'
let g:spacevim_colorscheme_bg      = 1 ? 'dark' : 'light'
"}}}

" ================================================================================
" Preferences
let g:spacevim_autocomplete_method           = get(['coc'       , 'deoplete' , 'ncm2'], 0)
let g:spacevim_snippet_engine                = get(['neosnippet', 'ultisnips', 'coc' ], 2)
let g:spacevim_fuzzyfinder                   = get(['leaderf'   , 'denite'   , 'fzf' ], 0)
let g:spacevim_filemanager                   = get(['vimfiler'  , 'nerdtree' , 'defx'], 2)
let g:spacevim_statusline                    = get(['airline'   , 'lightline', ''    ], 0)
let g:spacevim_enable_ale                    = 1
let g:spacevim_lint_on_the_fly               = 1
let g:enable_deotabline                      = 1
let g:enable_googlesuggest                   = 0
let g:enable_smart_clock                     = 0

" Ui {{{
let g:statusline_separator                   = get(['fire', 'arrow', 'curve', 'slant'], 0)
let g:enable_fat_statusline                  = 0
let g:spacevim_enable_cursorword             = 1
let g:spacevim_enable_cursorcolumn           = 0
let g:spacevim_buffer_index_type             = 1
let g:spacevim_enable_tabline_filetype_icon  = 1
let g:spacevim_enable_statusline_mode        = 1
let g:spacevim_enable_statusline_bfpath      = 1
let g:spacevim_enable_os_fileformat_icon     = 1
let g:spacevim_error_symbol                  = '❌'
let g:spacevim_warning_symbol                = '⚠️ '
" let g:spacevim_error_symbol                  = '✖'
" let g:spacevim_warning_symbol                = 'ⓦ'
let g:spacevim_info_symbol                   = '➤'

" let g:spacevim_filetree_direction            = 'left'
let g:spacevim_sidebar_width                 = 25
let g:spacevim_enable_vimfiler_welcome       = 0
let g:spacevim_enable_vimfiler_gitstatus     = 1
let g:spacevim_enable_vimfiler_filetypeicon  = 0
"}}}

" System {{{
let g:spacevim_checkinstall                  = 1
let g:spacevim_enable_debug                  = 0
let g:spacevim_auto_disable_touchpad         = 1
let g:spacevim_windows_smartclose            = ''
let g:spacevim_windows_leader                = ''
let g:spacevim_github_username               = 'alanding1989'
let g:spacevim_guifont                       = 'SauceCodePro Nerd Font Mono:h11'
let g:spacevim_layer_lang_scala_formatter    = '/opt/vim/scalariform.jar'
let g:spacevim_project_rooter_patterns       =
      \ uniq(sort(g:spacevim_project_rooter_patterns
      \ + deepcopy(g:project_root_marker))) "}}}


" ================================================================================
" Variable Setting
" ============================================================================== {{{
let g:_checkers_var = {
      \ 'show_cursor_error' : 1,
      \ }
let g:_lang#markdown_var = {
      \ 'enableWcwidth'  : 1,
      \ 'listItemIndent' : 1,
      \ }
let g:_shell_var = {
      \ 'default_position' : 'right',
      \ 'default_height'   : 30     ,
      \ }
let g:_VersionControl_var = {
      \ 'enable_gtm_status' : 0,
      \ }
let g:_lsp_var = {'filetypes' : [
      \ 'python',
      \ ]}
      " \ 'javascript',
if g:is_unix
  call add(g:_lsp_var['filetypes'], 'sh')
endif
" }}}


" ================================================================================
" Layers en/disable
"   efault layers:
"   autocomplete, checkers, core, edit, format, ui,
"   代码补全，检错、修改比较，编辑辅助，文件搜索
" ============================================================================== {{{
let g:my_layers = {
      \ 'core#statusline'   : 0,
      \ 'chat'              : 1,
      \ 'checkers'          : 1,
      \ 'chinese'           : 1,
      \ 'colorscheme'       : 1,
      \ 'debug'             : 1,
      \ 'git'               : 1,
      \ 'github'            : 1,
      \ 'lsp'               : 1,
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
      \ 'VersionControl'    : 1,
      \
      \ 'denite'            : 1,
      \ 'fzf'               : 0,
      \ 'leaderf'           : 1,
      \ 'unite'             : 0,
      \ }

if g:spacevim_fuzzyfinder ==# 'leaderf'
      \ && g:my_layers['leaderf']
  let g:my_layers['leaderf'] = 1
  let g:my_layers['denite']  = 1
  let g:my_layers['fzf']     = 0
  " let g:my_layers['unite']   = 1
elseif g:spacevim_fuzzyfinder ==# 'denite'
  let g:my_layers['denite']  = 1
  let g:my_layers['leaderf'] = 0
  let g:my_layers['fzf']     = 0
elseif g:spacevim_fuzzyfinder ==# 'fzf'
  let g:my_layers['fzf']     = 1
  let g:my_layers['denite']  = 0
  let g:my_layers['leaderf'] = 0
endif
"}}}


" ================================================================================
" Disabled plugins
" ============================================================================== {{{
let g:spacevim_disabled_plugins = [
      \ 'vim-hybrid'           ,
      \ 'jellybeans.vim'       ,
      \ 'neosnippet-snippets'  ,
      \ 'vim-snippets'         ,
      \ 'CompleteParameter.vim',
      \ 'unite-radio.vim'      ,
      \ 'unite-gtags'          ,
      \ 'denite-gtags'         ,
      \ 'tagbar'               ,
      \ 'tagbar-makefile.vim'  ,
      \ 'tagbar-proto.vim'     ,
      \ 'tagbar-markdown'      ,
      \ 'vim-vimlint'          ,
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
if get(g:my_layers, 'denite', 0)  == 0
  let g:spacevim_disabled_plugins += [
        \ 'neomru.vim'    ,
        \ 'unite-outline' ,
        \ ]
endif
"}}}
