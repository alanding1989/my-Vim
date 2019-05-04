"=============================================================================
" clock.vim -- tools#clock layer
" Section: tools
" Parent Section: layers
"=============================================================================
scriptencoding utf-8


function! layers#tools#clock#plugins() abort
  let plugins = []
  if g:is_nvim
    call add(plugins, ['iamcco/sran.nvim' , {'build': 'yarn', 'do': 'yarn'}])
    call add(plugins, ['iamcco/clock.nvim', {'merged' : 0}])
  endif
  return plugins
endfunction


function! layers#tools#clock#config() abort
  if !g:is_nvim | return | endif
  let g:clockn_to_top = 2
  let g:clockn_to_right = 1
  highlight link ClockNormal Normal
  " highlight link ClockNormal Title

  let s:smart_clock = get(g:, 'enable_smart_clock_startup', 1)
  augroup layer_tools#clock
    autocmd!
    if s:smart_clock
      autocmd User SranNvimRpcReady auto BufWinEnter,WinEnter * call s:smart_clock()
    endif
    if g:is_spacevim
      autocmd VimEnter * call SpaceVim#mapping#space#def
            \ ('nnoremap', ['a','t'], 'call call('
            \ . string(s:_function('s:toggle_clock')).', [])',
            \ '@ toggle_clock', 1)
    else
      autocmd VimEnter * nnoremap <space>at :call <sid>toggle_clock<CR>
    endif
  augroup END
endfunction


" automatic
let s:auto_flag = 0
function! s:smart_clock() abort
  if &ft ==# 'startify'
    return
  endif
  let winnr = tabpagewinnr(tabpagenr(), '$')
  if s:auto_flag && winwidth(0) < 80
    call clockn#disable()
    let s:auto_flag = 0
  elseif !s:auto_flag && winwidth(0) > 80
        \ && winnr == 1
    call clockn#enable()
    let s:auto_flag = 1
  endif
  return s:auto_flag
endfunction

" manual
let s:flag = 1
function! s:toggle_clock() abort
  if s:flag == 0
    ClockEnable
    let s:flag = 1
  else
    ClockDisable
    let s:flag = 0
  endif
endfunction

" function() wrapper {{{
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
endif
" }}}
