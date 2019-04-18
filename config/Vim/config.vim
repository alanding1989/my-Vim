" ================================================================================
" Vim config file
" Section config/Vim
" ================================================================================
scriptencoding utf-8



" choose minimal setting
let g:pure_viml = 0


" Themes list " {{{
let g:my_cs = split([
      \ '0 gruvbox'     ,
      \ '1 onedark'     ,
      \ '2 palenight'   ,
      \ '3 neodark'     ,
      \ '4 NeoSolarized',
      \ '5 OceanicNext' ,
      \ '6 PaperColor'  ,
      \ '7 nord'        ,
      \ ][3])[-1]
let g:my_bg = 1 ? 'dark' : 'light'
"}}}

" ================================================================================
" Preferences
let g:autocomplete_method           = get(['coc'       , 'deoplete' , 'ncm2'], 1)
let g:snippet_engine                = get(['neosnippet', 'ultisnips', 'coc' ], 0)
let g:fuzzyfinder                   = get(['leaderf'   , 'denite'   , 'fzf' ], 0)
let g:filemanager                   = get(['vimfiler'  , 'nerdtree' , 'defx'], 0)
let g:plugmanager                   = 1 ? 'dein'    : 'vim-plug'
let g:checker                       = 1 ? 'ale'     : 'neomake'
let g:statusline                    = 1 ? 'airline' : 'lightline'
let g:lint_on_the_fly               = 1
let g:enable_deotabline             = 1
let g:enable_googlesuggest          = 0
let g:enable_smart_clock            = 0

" Ui {{{
let g:enable_cursorword             = (g:is_nvim || g:is_gui) ? 1 : 0
let g:enable_fat_statusline         = 0
let g:statusline_separator          = get(['fire', 'arrow', 'curve', 'slant'], 2)
let g:sidebar_width                 = 25
let g:filetree_direction            = 'right'
let g:linter_error_symbol           = '❌'
let g:linter_warning_symbol         = '⚠️ '
" }}}

" System {{{
let g:enable_checkinstall         = 1
let g:github_username             = 'alanding1989'
let g:guifont                     = 'SauceCodePro Nerd Font Mono:h11'
let g:layer_lang_scala_formatter  = '/opt/vim/scalariform.jar'
let g:spacevim_debug_level        = 1
"}}}

" ================================================================================
" Layers en/disable
"   Default layers:
"   autocomplete,  checkers,  core,  edit,  format,  leaderf
"   代码补全，检错、修改比较，编辑辅助，文件搜索
" ============================================================================== {{{
" \ 'tools'              : 0, TODO: learn

" finished ~
" autocomplete, checkers, chinese, colorscheme, core, edit, format, leaderf/denite, ui, lang#vim
let g:My_Vim_layers = {
      \ 'chinese'           : 0,
      \ 'colorscheme'       : 1,
      \ 'tags'              : 1,
      \ 'tools'             : 1,
      \ 'langtools'         : 0,
      \ 'lsp'               : 0,
      \ 'lang#ipynb'        : 0,
      \ 'lang#python'       : 0,
      \ 'lang#latex'        : 0,
      \ 'lang#scala'        : 0,
      \ 'lang#vim'          : 1,
      \ 'tools#clock'       : 1,
      \ 'ui'                : 1,
      \ 'VersionControl'    : 1,
      \
      \ 'denite'            : 0,
      \ 'fzf'               : 0,
      \ 'leaderf'           : 1,
      \ 'unite'             : 0,
      \ }

if g:fuzzyfinder ==# 'leaderf'
      \ && g:My_Vim_layers['leaderf']
  let g:My_Vim_layers['leaderf'] = 1
  let g:My_Vim_layers['denite']  = 1
  " let g:My_Vim_layers['unite']   = 1
elseif g:fuzzyfinder ==# 'denite'
  let g:My_Vim_layers['denite']  = 1
  let g:My_Vim_layers['leaderf'] = 0
elseif g:fuzzyfinder ==# 'fzf'
  let g:My_Vim_layers['fzf']     = 1
  let g:My_Vim_layers['denite']  = 0
  let g:My_Vim_layers['leaderf'] = 0
endif

if g:pure_viml " {{{
  let g:autocomplete_method = 'asyncomplete'
  let g:snippet_engine      = 'neosnippet'
  let g:filemanager         = 'nerdtree'
  let g:enable_smart_clock  = 0
  let g:My_Vim_layers = {
        \ 'colorscheme'     : 1,
        \ 'tags'            : 1,
        \ 'tools'           : 1,
        \ 'lsp'             : 0,
        \ 'lang#latex'      : 0,
        \ 'lang#scala'      : 0,
        \ 'lang#vim'        : 1,
        \ 'tools#clock'     : 1,
        \ 'ui'              : 1,
        \ 'VersionControl'  : 1,
        \ 'unite'           : 1,
        \ }
endif
"}}}
"}}}


" ================================================================================
" Disabled plugins
" ============================================================================== {{{
"let g:disabled_plugins = [
"\ '',
"\ ]
"}}}
