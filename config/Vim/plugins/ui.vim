"================================================================================
" ui.vim -- layer ui settings
"================================================================================
scriptencoding utf-8



if g:is_spacevim && SpaceVim#layers#isLoaded('core#statusline')
  finish
elseif !g:is_spacevim
"--------------------------------------------------------------------------------
" Yggdroot/indentLine
"----------------------------------------------------------------------------- {{{
let g:indentLine_char                   = '┊'
" let g:indentLine_showFirstIndentLevel = 1
" let g:indentLine_first_char           = '│'
" let g:indentLine_leadingSpaceEnabled  = 1
" let g:indentLine_leadingSpaceChar     = ''
let g:indentLine_concealcursor   = 'niv'
let g:indentLine_conceallevel    = 2
if &background ==# 'dark'
  let g:indentLine_color_term    = 239
  let g:indentLine_color_gui     = '#504945'
else
  let g:indentLine_color_gui     = '#d5c4a1'
endif
let g:vim_json_syntax_conceal    = 0
let g:indentLine_fileTypeExclude = ['help', 'man', 'startify', 'vimfiler', 'defx']
let g:indentLine_bufNameExclude  = ['help', 'man', 'startify', 'vimfiler', 'defx']
"}}}

"--------------------------------------------------------------------------------
" rainbow_parentheses.vim
"----------------------------------------------------------------------------- {{{
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'],['{','}']]
" List of colors that you do not want. ANSI code or #RRGGBB
let g:rainbow#blacklist = [233, 234]

let g:better_whitespace_filetypes_blacklist = [
      \ 'diff', 'gitcommit', 'unite', 'qf', 'help',
      \ 'markdown', 'leaderGuide', 'startify'
      \ ]
"}}}

endif

" resource {{{
let s:SYS = SpaceVim#api#import('system')
let s:buffer_idx_format = {
      \ '1': '① ',
      \ '2': '② ',
      \ '3': '③ ',
      \ '4': '④ ',
      \ '5': '⑤ ',
      \ '6': '⑥ ',
      \ '7': '⑦ ',
      \ '8': '⑧ ',
      \ '9': '⑨ '
      \ }
" NOTE: Powerline Symbols
let s:separators = {
      \ 'arrow' : {
      \     'sep' : { 'left': "\ue0b0", 'right': "\ue0b2" },
      \     'sub' : { 'left': ''     , 'right': ''      },
      \ },
      \ 'curve' : {
      \     'sep' : { 'left': "\ue0b4", 'right': "\ue0b6" },
      \     'sub' : { 'left': ''      , 'right': ''       },
      \ },
      \ 'slant' : {
      \     'sep' : { 'left': "\ue0b8", 'right': "\ue0ba" },
      \     'sub' : { 'left': ''     , 'right': ''      },
      \ },
      \ 'brace' : {
      \     'sep' : { 'left': "\ue0d2", 'right': "\ue0d4" },
      \     'sub' : { 'left': ''     , 'right': ''      },
      \ },
      \ 'fire'  : {
      \     'sep' : { 'left': "\ue0c0", 'right': "\ue0c2 "},
      \     'sub' : { 'left': ''     , 'right': ''      },
      \ },
      \ 'nil'   : {
      \     'sep' : { 'left': ''      , 'right': ''       },
      \     'sub' : { 'left': ''      , 'right': ''       },
      \ }
      \ }
let s:sep_style = get(g:, 'statusline_separator', 'arrow') " }}}


"--------------------------------------------------------------------------------
" vim-airline settings
"----------------------------------------------------------------------------- {{{
if get(g:, 'statusline', 'airline') ==# 'airline'
      \ && index(get(g:, 'uninstalled_plugins', []), 'vim-airline') == -1
  " ui
  if get(g:, 'spacevim_colorscheme', get(g:, 'my_cs', 'neodark')) ==# 'palenight'
    let g:airline_theme = split([
          \ '0 dracula'     ,
          \ '1 neodark'     ,
          \ '2 solarized'   ,
          \ '3 onedark'     ,
          \ '4 oceanicnext' ,
          \ '5 dracula'     ,
          \ '6 nord'        ,
          \ ][5])[1]
  endif

  " powerline symbols {{{
  let g:airline_powerline_fonts   = 1
  let g:airline_symbols           = {}
  let g:airline_symbols.notexists = ' '

  " more feature{{{
  if g:enable_fat_statusline
    let g:airline_symbols.branch    = ''
    let g:airline_symbols.readonly  = ''
    let g:airline_symbols.linenr    = '☰'
    let g:airline_symbols.maxlinenr = ''
    auto VimEnter * let g:airline_left_sep      = s:separators[s:sep_style].sep.left
    auto VimEnter * let g:airline_right_sep     = s:separators[s:sep_style].sep.right
    auto VimEnter * let g:airline_left_alt_sep  = s:separators[s:sep_style].sub.left
    auto VimEnter * let g:airline_right_alt_sep = s:separators[s:sep_style].sub.right
    auto VimEnter * let g:airline#extensions#tabline#left_sep     = s:separators[s:sep_style].sep.left
    auto VimEnter * let g:airline#extensions#tabline#left_alt_sep = s:separators[s:sep_style].sub.left
  else "}}}

  " slim {{{
    let g:airline_symbols.branch    = ' '
    let g:airline_symbols.readonly  = ''
    let g:airline_symbols.linenr    = ' '
    let g:airline_symbols.maxlinenr = ' '
    auto VimEnter * let g:airline_left_sep                        = ''
    auto VimEnter * let g:airline_right_sep                       = ''
    auto VimEnter * let g:airline_left_alt_sep                    = ''
    auto VimEnter * let g:airline_right_alt_sep                   = ''
    auto VimEnter * let g:airline#extensions#tabline#left_sep     = ''
    auto VimEnter * let g:airline#extensions#tabline#left_alt_sep = ''
  endif
  "}}}

  "@ tabline
  let g:airline_inactive_collapse                    = 1
  let g:airline#extensions#tabline#enabled           = 1
  let g:airline#extensions#tabline#show_buffers      = 1
  let g:airline#extensions#tabline#buffer_idx_mode   = 1
  let g:airline#extensions#tabline#buffer_idx_format = s:buffer_idx_format
  let g:airline#extensions#tabline#formatter         = 'unique_tail'
  let g:airline#extensions#tabline#fnamemod          = ':t'
  let g:airline#extensions#tabline#fnamecollapse     = 1
  let g:airline#extensions#tabline#fnametruncate     = 0
  " define how to show tab and splits number
  let g:airline#extensions#tabline#show_tab_nr   = 1
  let g:airline#extensions#tabline#tab_nr_type   = 1
  let g:airline#extensions#tabline#show_tab_type = 1
  let g:airline#extensions#tabline#keymap_ignored_filetypes =
        \ ['vimfiler', 'nerdtree', 'defx', 'denite']
  "}}}

  call util#statusline#airline()

  "@ extendtion integrations {{{
  let g:airline_highlighting_cache            = 1
  let g:airline_skip_empty_sections           = 1
  " let airline#extensions#fugitiveline#enabled = 0

  " LanguageClient-neovim
  let g:airline#extensions#languageclient#error_symbol   = '✖ :'
  let g:airline#extensions#languageclient#warning_symbol = 'ⓦ :'
  " ale
  let airline#extensions#ale#show_line_numbers = 1
  let g:airline#extensions#ale#error_symbol    = '✖ :'
  let g:airline#extensions#ale#warning_symbol  = 'ⓦ :'
  " neomake
  let g:airline#extensions#neomake#error_symbol   = '✖ :'
  let g:airline#extensions#neomake#warning_symbol = 'ⓦ :'
  " coc
  let g:airline#extensions#coc#error_symbol    = '✖ :'
  let g:airline#extensions#coc#warning_symbol  = 'ⓦ :'
  " let g:airline#extensions#coc#stl_format_err  = '%E{[%e(#%fe)]}'
  " let g:airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
  if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method')) ==# 'coc'
    if get(g:, 'spacevim_enable_ale', 0) == 1 || get(g:, 'checker', '') ==# 'ale'
      let g:airline_section_error   =
            \ '%{airline#util#wrap(airline#extensions#ale#get_error(), 0)
            \ .  airline#util#wrap(airline#extensions#coc#get_error(), 0)}'
      let g:airline_section_warning =
            \ '%{airline#util#wrap(airline#extensions#ale#get_warning(),  0)
            \ .  airline#util#wrap(airline#extensions#coc#get_warning(),  0)}'
      \.'%{airline#util#wrap(airline#extensions#whitespace#check(), 0)}'
    elseif get(g:, 'spacevim_enable_ale') == 0 || get(g:, 'checker', '') ==# 'neomake'
      let g:airline_section_error   =
            \ '%{airline#util#wrap(airline#extensions#neomake#get_errors(), 0)
            \ .  airline#util#wrap(airline#extensions#coc#get_error(), 0)}'
      let g:airline_section_warning =
            \ '%{airline#util#wrap(airline#extensions#neomake#get_warnings(),  0)
            \ .  airline#util#wrap(airline#extensions#coc#get_warning(),  0)}'
      \.'%{airline#util#wrap(airline#extensions#whitespace#check(), 0)}'
    endif
  endif

  " word counting
  let g:airline#extensions#wordcount#enabled = 0

  " whitespace check
  let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'mixed-indent-file' ]
  let g:airline#extensions#whitespace#max_lines = 200
  let g:airline#extensions#whitespace#skip_indent_check_ft = {'go': ['mixed-indent-file']}
  " }}}" }}}


"--------------------------------------------------------------------------------
" lightline
"----------------------------------------------------------------------------- {{{
elseif get(g:, 'spacevim_statusline', get(g:, 'statusline', 'airline')) ==# 'lightline'
      \ && index(get(g:, 'uninstalled_plugins', []), 'lightline.vim') == -1

  augroup Lightline_settings
    autocmd!
    if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'coc'
      autocmd User CocDiagnosticChange * call lightline#update_once()
      autocmd BufWinEnter,BufWritePre,BufWritePost * call lightline#update()
    endif
  augroup END

  let g:lightline = extend(get(g:, 'lightline', {}), {
        \ 'colorscheme'  : get(g:, 'spacevim_colorscheme', get(g:, 'my_cs', 'wombat')),
        \ 'separator'    : s:separators[s:sep_style].sep,
        \ 'subseparator' : s:separators[s:sep_style].sub,
        \ 'active' : {
        \     'left'  : [ ['mode', 'paste'], ['filename1', 'gitbranch', 'hunks'],
        \                 ['filename2', 'readonly']],
        \     'right' : [ ['percent'] , ['linterstatus', 'fileformat', 'fileencoding', 'lineinfo'],
        \                 ['filetype'] ],
        \ },
        \ 'tab_component_function' : {
        \     'tabnum'      : 'Tabnum',
        \ },
        \ 'component_function' : {
        \     'mode'        : 'LightlineMode',
        \     'filename1'   : 'Filename_l'   ,
        \     'gitbranch'   : 'Gitbranch'    ,
        \     'hunks'       : 'Hunks'        ,
        \     'filename2'   : 'Filename_r'   ,
        \     'readonly'    : 'Readonly'     ,
        \     'modified'    : 'Modified'     ,
        \
        \     'fileencoding': 'Fileencoding',
        \     'filetype'    : 'Filetype_lo' ,
        \     'linterstatus': 'Linterstatus',
        \     'fileformat'  : 'Fileformat'  ,
        \ },
        \ 'component' : {
        \     'lineinfo' : '☰  %3l:%-2v',
        \ },
        \ 'component_visible_condition' : {
        \     'lineinfo' : 'winwidth(0) > 40',
        \     'percent'  : 'winwidth(0) > 40',
        \     'filename' : 'winwidth(0) > 40',
        \ },
        \ })
  " \ 'component_expand': {
  " \     ''   : ''        ,
  " \ },
  " \ 'component_type'  : {
  " \     ''   : ''        ,
  " \ }
  "
  function! Linterstatus() abort
    if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'coc'
      return coc#status()
    else
      return '[None]'
    endif
  endfunction

  function! Gitbranch() abort "{{{
    if exists('g:loaded_fugitive')
      try
        let l:head = fugitive#head()
        if empty(l:head)
          call fugitive#detect(getcwd())
          let l:head = fugitive#head()
        endif
        return empty(l:head) ? '' : '  '.l:head
      catch
      endtry
    endif
    return ''
  endfunction

  " +0 ~0 -0
  function! Hunks() abort
    let hunks = [0,0,0]
    try
      let hunks = sy#repo#get_stats()
    catch
    endtry
    let rst = ''
    if hunks[0] > 0
      let rst .= hunks[0] . '+ '
    endif
    if hunks[1] > 0
      let rst .= hunks[1] . '~ '
    endif
    if hunks[2] > 0
      let rst .= hunks[2] . '- '
    endif
    return empty(rst) ? '' : '' . rst
  endfunction "}}}

  function! Filename_l(...) "{{{
    let fname = expand('%:t')
    return  fname ==# '__Tagbar__' ? g:lightline.fname :
          \ &ft ==# 'vimfiler' ? vimfiler#get_status_string() :
          \ &ft ==# 'unite' ? unite#get_status_string() :
          \ &ft ==# 'denite' ? denite#get_status('path') :
          \ &ft ==# 'vimshell' ? vimshell#get_status_string() :
          \ ('' !=# Modified() ? '  '. Modified().' ' : '').
          \ ('' !=# fname ? fname : ' ')
  endfunction

  function! Filename_r(...)
    let fname = winwidth(0) > 70 ? expand('%:p:~') : expand('%:.')
    return  fname ==# '__Tagbar__' ? g:lightline.fname :
          \ &ft ==# 'vimfiler' ? vimfiler#get_status_string() :
          \ &ft ==# 'unite' ? unite#get_status_string() :
          \ &ft ==# 'denite' ? denite#get_status('path') :
          \ &ft ==# 'vimshell' ? vimshell#get_status_string() :
          \ ('' !=# Readonly() ? Readonly() . ' ' : '') .
          \ ('' !=# fname ? fname : ' ')
  endfunction "}}}

  function! Filetype_lo() "{{{
    if &ft !=# ''
      let list = split(&ft, '\zs')
      let h = toupper(list[0])
      let ft = '['.join(insert(list[1:], h), '').']'
    else
      let ft = '[no ft]'
    endif
    return winwidth(0) > 70 ? ft : ''
  endfunction

  function! Readonly()
    return &readonly ? '' : ''
  endfunction

  function! LightlineMode()
    let fname = expand('%:t')
    return  fname ==# '__Tagbar__' ? 'Tagbar' :
          \ fname ==# '__Gundo__' ? 'Gundo' :
          \ fname ==# '__Gundo_Preview__' ? 'Gundo Preview' :
          \ fname =~# 'NERD_tree' ? 'NERDTree' :
          \ &ft ==# 'unite' ? 'Unite' :
          \ &ft ==# 'denite' ? 'Denite' :
          \ &ft ==# 'defx' ? 'Defx' :
          \ &ft ==# 'vimfiler' ? 'VimFiler' :
          \ &ft ==# 'vimshell' ? 'VimShell' :
          \ winwidth(0) > 60 ? lightline#mode() : ''
  endfunction "}}}

  function! Fileformat() "{{{
    return winwidth(0) > 70 ? '  '.s:SYS.fileformat().'' : ''
  endfunction

  function! Fileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ?
          \ (s:separators['arrow'].sep.right).'  '.&fenc : &enc) : ''
  endfunction "}}}

  let g:tagbar_status_func = 'TagbarStatusFunc'
  function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
  endfunction

  function! Tabnum(n)
    return s:buffer_idx_format[a:n]
  endfunction

  let g:unite_force_overwrite_statusline = 0
  let g:vimfiler_force_overwrite_statusline = 0
  let g:vimshell_force_overwrite_statusline = 0
endif "}}}

" vim:set sw=2 ts=2 sts=2 et tw=78
