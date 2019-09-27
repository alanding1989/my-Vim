"=============================================================================
" colorscheme.vim --- colorscheme layer
" Parent Section: layers
"=============================================================================
scriptencoding utf-8



function! layers#colorscheme#plugins() abort
  let plugins = [
        \ [ 'KeitaNakamura/neodark.vim'       , {'merged': 0 }],
        \ [ 'mhartington/oceanic-next'        , {'merged': 0 }],
        \ [ 'NLKNguyen/papercolor-theme'      , {'merged': 0 }],
        \ [ 'chuling/vim_equinusocio_material', {'merged': 0 }],
        \ ]
  if !g:is_spacevim
    let plugins += [
        \ [ 'rakr/vim-one'                 , {'merged': 0 }],
        \ [ 'drewtempelmeyer/palenight.vim', {'merged': 0 }],
        \ [ 'morhetz/gruvbox'              , {'merged': 0 }],
        \ [ 'iCyMind/NeoSolarized'         , {'merged': 0 }],
        \ [ 'arcticicestudio/nord-vim'     , {'merged': 0 }],
        \ [ 'joshdick/onedark.vim'         , {'merged': 0 }],
        \ ]
  endif
  return plugins
endfunction


function! layers#colorscheme#config() abort
  if g:is_spacevim
    let g:_spacevim_mappings_space_custom += [
          \ [ 'nmap', ['t', 'o'], 'call call('
          \ .string(s:_function('s:toggle_transparent')).', [])',
          \ '@ toggle theme', 1 ],
          \ ]
  else
    " MyVim
    set termguicolors
    set cursorline
    call layers#colorscheme#my_cs()
    try
      exec 'set background='.get(g:, 'my_bg', 'dark')
      exec 'colorscheme '.g:my_cs
    catch
      " set notermguicolors
      " set nocursorline
      " auto VimEnter * AirlineToggle
      colorscheme NeoSolarized
      set background=dark
    endtry

    noremap <silent><space>tb :call <sid>toggleBG()<CR>
    noremap <silent><space>tn :call <sid>cycleThemes()<CR>
    noremap <silent><space>tt :call <sid>toggleTheme()<CR>
  endif
endfunction


function! layers#colorscheme#my_cs() abort "{{{
  let cs = get(g:, 'spacevim_colorscheme'   , get(g:, 'my_cs'))
  let bg = get(g:, 'spacevim_colorscheme_bg', get(g:, 'my_bg'))

  if cs ==# 'PaperColor'
    let bg = 'light'
  endif

  if bg ==# 'light' && cs !=# 'PaperColor'
    let cs = 'gruvbox'
  endif
  if cs ==# 'gruvbox'
    let g:gruvbox_contrast_light       = 'soft'
    let g:gruvbox_contrast_dark        = 'soft'
    " let g:gruvbox_bold                 = 0
    let g:gruvbox_italic               = 1
    let g:gruvbox_italicize_strings    = 1
    let g:gruvbox_improved_warnings    = 1
    " let g:gruvbox_improved_strings     = 1
    " let g:gruvbox_invert_signs         = 1
    " let g:gruvbox_invert_indent_guides = 1
    " let g:gruvbox_invert_tabline       = 1
  endif

  if cs ==# 'NeoSolarized'
    let g:neosolarized_contrast = 'soft'
    let bg = 'dark'
  endif

  if cs ==# 'neodark'
    let g:neodark#terminal_transparent = 1
    let bg = 'dark'
  endif

  if cs ==# 'onedark'
    let bg = 'dark'
  endif

  if cs ==# 'one'
    let g:one_allow_italics = 1
    let bg = 'dark'
  endif

  if cs ==# 'OceanicNext'
    let g:oceanic_next_terminal_bold   = 1
    let bg = 'dark'
  endif

  if cs ==# 'palenight'
    let bg = 'dark'
  endif

  if cs ==# 'dracula' || cs ==# 'paradox' || cs ==# 'nord'
    let bg = 'dark'
  endif

  if g:is_win && !g:is_gui
    let g:gruvbox_italicize_strings    = 0
  endif

  if exists('g:spacevim_colorscheme')
    let g:spacevim_colorscheme    = cs
    let g:spacevim_colorscheme_bg = bg
  else
    let g:my_cs = cs
    let g:my_bg = bg
  endif
endfunction "}}}

function! s:toggle_transparent() abort "{{{
  if get(g:, 'colors_name') !=# 'default'
    let s:pre_cs = g:colors_name
    let s:pre_bg = &background
    " try
      " AirlineToggle
    " catch
    " endtry
    if g:is_spacevim
      set showtabline=1
      set laststatus=0
      augroup alan_cs
        auto!
        auto InsertLeave,InsertEnter,WinEnter,WinLeave
              \ * set nocursorline showtabline=1
      augroup END
    endif
    set nocursorline
    set notermguicolors
    colorscheme default
    set background=dark
  elseif get(g:, 'colors_name', 'default') ==# 'default'
    " try
      " AirlineToggle
    " catch
    " endtry
    if g:is_spacevim
      set showtabline=2
      set laststatus=2
      augroup alan_cs
        auto!
      augroup END
    endif
    set cursorline
    set termguicolors
    call layers#colorscheme#my_cs()
    exec 'set background='.get(s:, 'pre_bg', 'dark')
    exec 'colorscheme '   .get(s:, 'pre_cs', 'neodark')
    redraw!
  endif
endfunction

" deprecated
let t:is_transparent = 0
function! s:toggle_transparent_1() abort
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_tranparent = 0
    endif
endfunction

function! s:toggleBG() abort
  let cs = get(g:, 'colors_name')
  if &background ==# 'dark'
    set background=light
  else
    set background=dark
  endif
  set termguicolors
  exec 'colorscheme '.cs
  redraw!
endfunction

function! s:cycleThemes() abort
  let cur_cs = get(g:, 'colors_name', 'neodark')
  let cs = deepcopy(g:_cs)
  call map(cs, {key, val -> split(val, ' ')[1]})
  let cur_cs_index = index(cs, cur_cs)
  if cur_cs_index != len(cs) - 1
    let cur_cs_index += 1
  else
    let cur_cs_index = 0
  endif
  set termguicolors
  if exists('g:spacevim_colorscheme')
    let g:spacevim_colorscheme = cs[cur_cs_index]
    call layers#colorscheme#my_cs()
    exec 'colorscheme '.g:spacevim_colorscheme
    exec 'set background='.g:spacevim_colorscheme_bg
    redraw!
  else
    let g:my_cs = cs[cur_cs_index]
    call layers#colorscheme#my_cs()
    exec 'colorscheme '.g:my_cs
    exec 'set background='.g:my_bg
    redraw!
  endif
endfunction "}}}

" function() wrapper "{{{
if v:version > 703 || v:version == 703 && has('patch1170')
  function! s:_function(fstr) abort
    return function(a:fstr)
  endfunction
else
  function! s:_SID() abort
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze__SID$')
  endfunction
  let s:_s = '<SNR>' . s:_SID() . '_'
  function! s:_function(fstr) abort
    return function(substitute(a:fstr, 's:', s:_s, 'g'))
  endfunction
endif "}}} "}}}
