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
      \ '1 one'         ,
      \ '2 onedark'     ,
      \ '3 palenight'   ,
      \ '4 neodark'     ,
      \ '5 OceanicNext' ,
      \ '6 NeoSolarized',
      \ '7 PaperColor'  ,
      \ '8 nord'        ,
      \ '9 default'     ,
      \ ][4])[1]
let g:my_bg = 1 ? 'dark' : 'light'
"}}}

" ================================================================================
" Preferences
" ================================================================================
let g:autocomplete_method           = get(['coc'       , 'deoplete' , 'ncm2'], 1)
let g:snippet_engine                = get(['neosnippet', 'ultisnips', 'coc' ], 0)
let g:fuzzyfinder                   = get(['leaderf'   , 'denite'   , 'fzf' ], 0)
let g:filemanager                   = get(['vimfiler'  , 'nerdtree' , 'defx'], 2)
let g:checker                       = 1 ? 'ale'     : 'neomake'
let g:statusline                    = 1 ? 'airline' : 'lightline'
let g:lint_on_the_fly               = 1
let g:format_on_save                = 1
let g:enable_deotabline             = 0
let g:enable_googlesuggest          = 0

" Ui {{{
let g:enable_fat_statusline         = 1
let g:statusline_separator          = get(['fire', 'arrow', 'curve', 'slant'], 1)
" }}}

" System {{{
let g:enable_checkinstall          = 1
"}}}

" Var {{{
let g:_lsp_var = { 'ft' : [
      \ 'sh',
      \ 'python',
      \ 'ipynb',
      \ 'javascript',
      \ 'vim',
      \ ]}
"}}}


" ================================================================================
" Layers en/disable
"   Default layers:
"   autocomplete,  checkers,  core,  edit,  format,  leaderf
"   代码补全，检错、修改比较，编辑辅助，文件搜索
" ============================================================================= {{{

" finished ~
let g:My_Vim_layers = {
      \ 'chinese'           : 1,
      \ 'colorscheme'       : 1,
      \ 'tags'              : 1,
      \ 'tools'             : 1,
      \ 'langtools'         : 1,
      \ 'lsp'               : 1,
      \ 'lang#markdown'     : 1,
      \ 'lang#ipynb'        : 0,
      \ 'lang#python'       : 1,
      \ 'lang#latex'        : 0,
      \ 'lang#scala'        : 0,
      \ 'lang#vim'          : 1,
      \ 'tools#clock'       : 1,
      \ 'ui'                : 1,
      \ 'git'               : 1,
      \ 'VersionControl'    : 0,
      \
      \ 'denite'            : 0,
      \ 'fzf'               : 0,
      \ 'leaderf'           : 1,
      \ 'unite'             : 0,
      \ }

if g:fuzzyfinder ==# 'leaderf' " {{{
      \ && g:My_Vim_layers['leaderf']
  let g:My_Vim_layers['leaderf'] = 1
  let g:My_Vim_layers['denite']  = 1
elseif g:fuzzyfinder ==# 'denite'
  let g:My_Vim_layers['denite']  = 1
  let g:My_Vim_layers['leaderf'] = 0
elseif g:fuzzyfinder ==# 'fzf'
  let g:My_Vim_layers['fzf']     = 1
  let g:My_Vim_layers['denite']  = 0
  let g:My_Vim_layers['leaderf'] = 0
endif "}}}

" powershell {{{
if g:is_win
  let g:My_Vim_layers['lang#ps1'] = 1
endif
"}}}

if g:autocomplete_method ==# 'coc' " {{{
  let g:snippet_engine =
        \ g:snippet_engine !=# 'neosnippet'
        \ ? 'coc' : g:snippet_engine
endif
"}}}

if g:pure_viml || !g:has_py " {{{
  let g:autocomplete_method = 'asyncomplete'
  let g:snippet_engine      = 'neosnippet'
  let g:filemanager         = 'vimfiler'
  let g:enable_smart_clock  = 0
  let g:My_Vim_layers = {
        \ 'chinese'         : 1,
        \ 'colorscheme'     : 1,
        \ 'tags'            : 1,
        \ 'tools'           : 1,
        \ 'lsp'             : 1,
        \ 'lang#latex'      : 0,
        \ 'lang#scala'      : 0,
        \ 'lang#vim'        : 1,
        \ 'tools#clock'     : 1,
        \ 'ui'              : 1,
        \ 'VersionControl'  : 1,
        \
        \ 'denite'          : 0,
        \ 'fzf'             : 0,
        \ 'leaderf'         : 0,
        \ 'unite'           : 1,
        \ }
endif "}}}
"}}}


" ================================================================================
" Disabled plugins
" ============================================================================= {{{
" let g:disabled_plugins = [
      " \ '',
      " \ ]
"}}}
