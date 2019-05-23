" ================================================================================
" SpaceVimrc
" Section config/SpaceVim
" ================================================================================
scriptencoding utf-8



" choose minimal setting
let g:pure_viml = 0


" Themes list " {{{
let g:spacevim_colorscheme = split([
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
      \ ][1])[1]
let g:spacevim_colorscheme_default = 'neodark'
let g:spacevim_colorscheme_bg      = 1 ? 'dark' : 'light'
"}}}

" ================================================================================
" Preferences
" ================================================================================
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

" Ui {{{
let g:enable_fat_statusline                  = 1
let g:statusline_separator                   = get(['fire', 'arrow', 'curve', 'slant'], 1)
let g:spacevim_statusline_left_sections      =  ['winnr', 'filename', 'syntax checking', 'minor mode lighters']
let g:spacevim_statusline_right_sections     += ['time', 'date']
let g:spacevim_enable_cursorcolumn           = 0
let g:spacevim_buffer_index_type             = 1
let g:spacevim_enable_tabline_filetype_icon  = 1
let g:spacevim_enable_statusline_mode        = 1
let g:spacevim_enable_statusline_bfpath      = 1
let g:spacevim_enable_os_fileformat_icon     = 1
let g:spacevim_error_symbol                  = g:linter_error_symbol
let g:spacevim_warning_symbol                = g:linter_warning_symbol
let g:spacevim_info_symbol                   = g:linter_info_symbol

let g:spacevim_sidebar_width                 = g:sidebar_width
let g:spacevim_filetree_direction            = g:filetree_direction
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
let g:spacevim_github_username               = g:github_username
let g:spacevim_guifont                       = g:guifont
let g:spacevim_layer_lang_scala_formatter    = g:layer_lang_scala_formatter
let g:spacevim_music_path                    = g:is_win ? 'E:\娱乐影音\音乐' : '/mnt/fun+downloads/娱乐影音/音乐'
let g:spacevim_project_rooter_patterns       = uniq(sort(g:spacevim_project_rooter_patterns
      \ + deepcopy(g:project_root_marker)))
"}}}


" ================================================================================
" Variable Setting
" ============================================================================= {{{
let g:_checkers_var = {
      \ 'show_cursor_error' : 1,
      \ }
let g:_colorscheme_var = {
      \ 'bright_statusline' : 1,
      \ }
let g:_lang#c_var = {
      \ 'enable_clang_syntax_highlight': 1,
      \ 'clang_executable': g:is_win ? 'D:\devtools\cpp\LLVM\bin\clang'
      \                              : '/opt/lang-tools/cpp/clang/bin/clang',
      \ 'libclang_path'   : g:is_win ? 'D:\devtools\cpp\LLVM\bin\libclang.dll'
      \                              : '/opt/lang-tools/cpp/clang/lib/libclang.so',
      \ 'clang_std'       : {
      \     'c'  : 'c11',
      \     'cpp': 'c++1z'},
      \ }
let g:_lang#markdown_var = {
      \ 'enableWcwidth'  : 1,
      \ 'listItemIndent' : 1,
    \ }
let g:_lang#python_var = {
      \ 'format_on_save' : 1,
      \ }
let g:_lang#ipynb_var  = {
      \ 'format_on_save' : 1,
      \ }
let g:_shell_var = {
      \ 'default_height'   : 35,
      \ 'default_position' : 'right',
      \ }
let g:_VersionControl_var = {
      \ 'enable_gtm_status' : 0,
      \ }
let g:_lsp_var = {'filetypes' : [
      \ 'c',
      \ 'cpp',
      \ 'python',
      \ 'vim',
      \ ]}
      " \ 'javascript',
if g:is_unix
  call add(g:_lsp_var['filetypes'], 'sh')
endif

" [ guifg, guibg, ctermfg, ctermbg, italic, bold] {{{
" -1 if None or negative
let g:_defhighlight_var = { 'hlcolor' : {
      \ 'python' : {
      \    'Statement'            : ['#c678dd', -1, -1, -1, 0, 1],
      \    'function'             : ['#a3e234', -1, 73, -1, 0, 0],
      \    'Type'                 : ['#d19a66', '3e4452', -1, -1, 0, 1],
      \
      \    'pythonStatement'      : ['#c678dd', -1, -1, -1, 1, 0],
      \    'Define'               : ['#c678dd', -1, -1, -1, 1, 0],
      \
      \    'pythonKeyword'        : ['#f92672', -1, -1, -1, 0, 0],
      \    'pythonImport'         : ['#f92672', -1, -1, -1, 0, 0],
      \    'pythonInclude'        : ['#f92672', -1, -1, -1, 0, 0],
      \    'pythonConditional'    : ['#f92672', -1, -1, -1, 0, 0],
      \    'pythonRepeat'         : ['#f92672', -1, -1, -1, 0, 0],
      \    'pythonOperator'       : ['#f92672', -1, -1, -1, 0, 0],
      \
      \    'pythonClass'          : ['#1aa3a1', -1, -1, -1, 0, 0],
      \    'semshiImported'       : ['#1aa3a1', -1, -1, -1, 0, 1],
      \    'pythonBuiltin'        : ['#1aa3a1', -1, -1, -1, 1, 0],
      \    'semshiBuiltin'        : ['#1aa3a1', -1, -1, -1, 1, 0],
      \    'pythonBuiltinType'    : ['#1aa3a1', -1, -1, -1, 0, 0],
      \
      \    'semshiSelf'           : ['#b467aa', -1, -1, -1, 0, 0],
      \    'pythonSelf'           : ['#b467aa', -1, -1, -1, 0, 0],
      \    'pythonClassVar'       : ['#b467aa', -1, -1, -1, 0, 0],
      \    'pythonAttribute'      : ['#c6c071', -1, -1, -1, 1, 0],
      \    'semshiAttribute'      : ['#c6c071', -1, -1, -1, 1, 0],
      \
      \    'semshiParameter'      : ['#e06c75', -1, -1, -1, 1, 0],
      \    'pythonParam'          : ['#e06c75', -1, -1, -1, 0, 0],
      \
      \    'pythonFunction'       : ['#a3e234', -1, -1, -1, 0, 0],
      \    'pythonDecoratorName'  : ['#a3e234', -1, -1, -1, 1, 0],
      \
      \    'String'               : ['#98c379', -1, -1, -1, 0, 0],
      \    'pythonString'         : ['#98c379', -1, -1, -1, 0, 0],
      \    'pythonRawString'      : ['#98c379', -1, -1, -1, 0, 0],
      \    'pythonStringDelimiter': ['#98c379', -1, -1, -1, 0, 0],
      \
      \    'Number'               : ['#d19a66', -1, -1, -1, 0, 0],
      \    'StorageClass'         : ['#aab6e1', -1, -1, -1, 1, 0],
      \ },
      \ }}
      " \    'pythonClass'          : ['#56b6c2', -1, -1, -1, 0, 0],
      " \    'semshiImported'       : ['#56b6c2', -1, -1, -1, 0, 1],
      " blue
      " \    'semshiParameter'      : ['#61af1f', -1, -1, -1, 1, 0],
      " \    'pythonParam'          : ['#61af1f', -1, -1, -1, 1, 0],
      " brown
      " \    'semshiParameter'      : ['#e06c75', -1, -1, -1, 1, 0],
      " \    'pythonParam'          : ['#e06c75', -1, -1, -1, 0, 0],
"}}}
" }}}


" ================================================================================
" Layers en/disable
"   efault layers:
"   autocomplete, checkers, core, edit, format, ui,
"   代码补全，检错、修改比较，编辑辅助，文件搜索
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
      \ 'lang#c'            : 1,
      \ 'lang#ipynb'        : 1,
      \ 'lang#java'         : 0,
      \ 'lang#javascript'   : 0,
      \ 'lang#latex'        : 0,
      \ 'lang#lua'          : 0,
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

if g:spacevim_fuzzyfinder ==# 'leaderf' " {{{
      \ && g:My_SpaceVim_layers['leaderf']
  let g:My_SpaceVim_layers['leaderf'] = 1
  let g:My_SpaceVim_layers['denite']  = 1
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

" powershell {{{
if g:is_win
  let g:My_SpaceVim_layers['lang#ps1'] = 1
endif
"}}}

if g:spacevim_autocomplete_method ==# 'coc' "{{{
  let g:spacevim_snippet_engine = 'coc'
endif
"}}}

if g:pure_viml || !g:has_py " {{{
  let g:spacevim_autocomplete_method = 'asyncomplete'
  let g:spacevim_snippet_engine      = 'neosnippet'
  let g:spacevim_filemanager         = 'vimfiler'
  let g:enable_smart_clock           = 0
  let g:My_SpaceVim_layers = {
        \ 'core#statusline' : 0,
        \ 'checkers'        : 1,
        \ 'chinese'         : 1,
        \ 'colorscheme'     : 1,
        \ 'debug'           : 1,
        \ 'git'             : 1,
        \ 'github'          : 1,
        \ 'lsp'             : 1,
        \ 'lang#java'       : 0,
        \ 'lang#javascript' : 0,
        \ 'lang#latex'      : 0,
        \ 'lang#markdown'   : 1,
        \ 'lang#scala'      : 1,
        \ 'lang#vim'        : 1,
        \ 'lang#sh'         : 1,
        \ 'incsearch'       : 1,
        \ 'shell'           : 1,
        \ 'tmux'            : 1,
        \ 'tools'           : 1,
        \ 'VersionControl'  : 0,
        \
        \ 'denite'          : 0,
        \ 'fzf'             : 0,
        \ 'leaderf'         : 0,
        \ 'unite'           : 1,
        \ }
endif
"}}}
"}}}


" ================================================================================
" En/Disabled plugins
" ============================================================================= {{{
      " \ 'vim-grepper'          ,
let g:spacevim_disabled_plugins = [
      \ 'molokai'              ,
      \ 'jellybeans.vim'       ,
      \ 'vim-hybrid'           ,
      \ 'vim-material'         ,
      \ 'srcery-vim'           ,
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
  let g:spacevim_disabled_plugins += [
        \ 'deoplete-zsh'   ,
        \ 'deoplete-ternjs',
        \ ]
endif
if g:spacevim_snippet_engine !=# 'neosnippet'
  let g:spacevim_disabled_plugins += [
        \ 'neopairs.vim',
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
