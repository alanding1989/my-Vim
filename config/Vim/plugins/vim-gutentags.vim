"=========================================================================
" File Name    : config/Vim/plugins/vim-gutentags.vim
" Author       : AlanDing
" mail         :
" Created Time : Mon 01 Apr 2019 04:53:42 PM CST
"=========================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


"--------------------------------------------------------------------------------
" vim-gutentags
"--------------------------------------------------------------------------------
let g:gutentags_project_root = deepcopy(g:project_root_marker)
let g:gutentags_add_default_project_roots = 0
let g:gutentags_exclude_project_root = ['/home/alanding']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_cache_dir     = expand(g:is_win ? 'D:\.cache\tags' 
      \ : '/home/alanding/.cache/tags'.(g:is_root ? '-root' : '-alan'))

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
  let g:gutentags_modules += ['ctags']
endif
if executable('gtags') && executable('gtags-cscope')
  let g:gutentags_modules += ['gtags_cscope']
endif

" 配置 ctags 的参数
let g:gutentags_ctags_exclude    =  ["\.zshrc", "\.bashrc"]
let g:gutentags_ctags_extra_args =  ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 如果使用 universal ctags 需要增加下面一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0


" Debug:
let g:gutentags_define_advanced_commands = 1
auto VimEnter * GutentagsToggleTrace
" .notags


"--------------------------------------------------------------------------------
" gutentags_plus
"--------------------------------------------------------------------------------
" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1
let g:gutentags_plus_nomap  = 1
