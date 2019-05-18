"=============================================================================
" ui.vim --- ui layer
" Parent Section: layers
"=============================================================================
scriptencoding utf-8



function! layers#ui#plugins() abort
  let plugins = []
  if g:is_spacevim
    if !SpaceVim#layers#isLoaded('core#statusline')
      if g:spacevim_statusline ==# 'lightline'
        call add(plugins, ['itchyny/lightline.vim', {'merged': 0}])
        call add(g:spacevim_disabled_plugins, 'vim-airline')
        call add(g:spacevim_disabled_plugins, 'vim-airline-themes')
      elseif g:spacevim_statusline ==# ''
        call add(g:spacevim_disabled_plugins, 'vim-airline')
        call add(g:spacevim_disabled_plugins, 'vim-airline-themes')
      endif
    endif
  else
    let plugins += [
          \ ['Yggdroot/indentLine'             , {'merged': 0}],
          \ ['t9md/vim-choosewin'              , {'merged': 0}],
          \ ['mhinz/vim-startify'              , {'merged': 0}],
          \ ['junegunn/rainbow_parentheses.vim', {'merged': 0}],
          \ ]
    if g:statusline ==# 'airline'
      call add(plugins, ['vim-airline/vim-airline'       , {'merged': 0}])
      call add(plugins, ['vim-airline/vim-airline-themes', {'merged': 0}])
    elseif g:statusline ==# 'lightline'
      call add(plugins, ['itchyny/lightline.vim', {'merged': 0}])
    endif
  endif
  return plugins
endfunction


function! layers#ui#config() abort
  " general
  call s:startify()
  call s:indent_line()
  call s:better_whitespace()

  augroup rainbow_lisp
    autocmd!
    autocmd BufWinEnter * RainbowParentheses
    autocmd FileType vimcalc setlocal nonu nornu nofoldenable | inoremap <silent> <buffer> <c-d> <c-[>:q<CR>
          \ | nnoremap <silent> <buffer> qd :bdelete<CR>
  augroup END

endfunction


function! s:startify() abort
  if g:is_spacevim
    let g:_spacevim_mappings.a   = {'name': '+@ Session/Settings' }
    let g:_spacevim_mappings.a.c = {'name': '+Open config file'   }
    call SpaceVim#mapping#def('noremap', '<leader>al', ':SLoad! '  , 'load a session'  , '', 'load a session'  )
    call SpaceVim#mapping#def('noremap', '<leader>as', ':SSave! '  , 'save a session'  , '', 'save a session'  )
    call SpaceVim#mapping#def('noremap', '<leader>ad', ':SDelete! ', 'delete a session', '', 'delete a session')
  else
    nnoremap <silent><space>bh   :Startify<CR>
    nnoremap <leader>al          :call feedkeys(':SLoad! ')<CR>
    nnoremap <leader>as          :call feedkeys(':SSave! ')<CR>
    nnoremap <leader>ad          :call feedkeys(':SDelete! ')<CR>
  endif
endfunction

function! s:indent_line() abort
  if g:is_spacevim
    call SpaceVim#mapping#space#def('nnoremap', ['t', 'i'], 'call call('
          \ . string(s:_function('s:toggle_indent_length')).', [])',
          \ '@ toggle indent length', 1)
  else
    noremap <silent><space>ti  :IndentLinesToggle<CR>
    noremap <silent><space>tl  :call <sid>toggle_indent_length()<CR>
  endif
endfunction


function! s:better_whitespace() abort
  let g:better_whitespace_ctermcolor = '114'
  let g:better_whitespace_guicolor   = '#98c379'
  if !g:is_spacevim
    nnoremap <silent><space>tw  :call <sid>toggle_whitespace()<CR>
  endif
endfunction

" Toggle indent length
let s:indent_length = &tabstop
function! s:toggle_indent_length() abort
  if s:indent_length == 2
    setlocal tabstop=4 softtabstop=4 shiftwidth=4
    let s:indent_length = 4
    echo 'indent length now is 4!'
  else
    setlocal tabstop=2 softtabstop=2 shiftwidth=2
    let s:indent_length = 2
    echo 'indent length now is 2!'
  endif
endfunction

" Toggle highlight tail space
let s:whitespace_enable = 0
function! s:toggle_whitespace() abort
  if s:whitespace_enable
    DisableWhitespace
    let s:whitespace_enable = 0
  else
    EnableWhitespace
    let s:whitespace_enable = 1
  endif
endfunction


" function() wrapper
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
