"=============================================================================
" checkers.vim --- checkers layer
" Section: layers
"=============================================================================
scriptencoding utf-8


" spacevim uses neomake
" vim      uses ale

let s:SIG = SpaceVim#api#import('vim#signatures')
let s:STRING = SpaceVim#api#import('data#string')

function! layers#checkers#plugins() abort
  let plugins = []
  " call add(plugins, ['rhysd/vim-grammarous', {'on_cmd': 'GrammarousCheck', 'on': 'GrammarousCheck'}])
  " call add(plugins, ['vim-scripts/errormarker.vim', {'merged': 0}])
  if !g:is_spacevim
    if get(g:, 'checker')     ==# 'neomake'
      call add(plugins, ['neomake/neomake', {'merged': 0}])
    elseif get(g:, 'checker') ==# 'ale'
      call add(plugins, ['w0rp/ale'       , {'merged': 0}])
    endif
  endif
  return plugins
endfunction


function! layers#checkers#config() abort
  let errormarker_disablemappings = 1
  nmap <silent> ge :ErrorAtCursor<CR>
  if g:is_spacevim
    call SpaceVim#mapping#space#def('nnoremap', ['e', 'n'], 'call call('
          \ . string(s:_function('s:jump_to_next_error')) . ', [])',
          \ 'next-error', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['e', 'p'], 'call call('
          \ . string(s:_function('s:jump_to_previous_error')) . ', [])',
          \ 'previous-error', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['e', 'N'], 'call call('
          \ . string(s:_function('s:jump_to_previous_error')) . ', [])',
          \ 'previous-error', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['e', 'v'], 'call call('
          \ . string(s:_function('s:verify_syntax_setup')) . ', [])',
          \ 'verify syntax setup', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['t', 's'], 'call call('
          \ . string(s:_function('s:toggle_syntax_checker')) . ', [])',
          \ 'toggle syntax checker', 1)
  else
    " only work in neomake
    if g:checker ==# 'neomake'
      nnoremap <silent><space>ee  :call <sid>explain_the_error()<CR>
    endif

    nnoremap <silent><space>ec  :call <sid>clear_errors()<CR>
    nnoremap <silent><space>ev  :call <sid>verify_syntax_setup()<CR>
    nnoremap <silent><space>e.  :call <sid>error_transient_state()<CR>
    nnoremap <silent><space>ts  :call <sid>toggle_syntax_checker()<CR>

    nnoremap <silent><space>en  :call <sid>jump_to_next_error()<CR>
    nnoremap <silent><space>ep  :call <sid>jump_to_previous_error()<CR>
    nnoremap <silent><space>eN  :call <sid>jump_to_previous_error()<CR>
    " 1 change cursor focus when open locationlist
    nnoremap <silent><space>el  :call <sid>toggle_show_error(1)<CR>
    nnoremap <silent><space>eL  :call <sid>toggle_show_error(0)<CR>
  endif
endfunction


function! s:toggle_show_error(...) abort
  try
    botright lopen
  catch
    try
      if len(getqflist()) == 0
        echohl WarningMsg
        echon 'There is no errors!'
        echohl None
      else
        botright copen
      endif
    catch
    endtry
  endtry
  if a:1 == 1
    wincmd w
  endif
endfunction

function! s:jump_to_next_error() abort
  if exists(':Neomake')
    try
      lnext
    catch
      try
        cnext
      catch
        echohl WarningMsg
        echon 'There is no errors!'
        echohl None
      endtry
    endtry
  elseif exists(':ALEInfo')
    ALENextWrap
  endif
endfunction

function! s:jump_to_previous_error() abort
  if exists(':Neomake')
    try
      lprevious
    catch
      try
        cprevious
      catch
        echohl WarningMsg
        echon 'There is no errors!'
        echohl None
      endtry
    endtry
  elseif exists(':ALEInfo')
    ALEPreviousWrap
  endif
endfunction

function! s:verify_syntax_setup() abort
  if exists(':Neomake')
    NeomakeInfo
  elseif exists(':ALEInfo')
    ALEInfo
  endif
endfunction

let s:ale_flag = 1
function! s:toggle_syntax_checker() abort
  if g:is_spacevim
    call SpaceVim#layers#core#statusline#toggle_section('syntax checking')
    call SpaceVim#layers#core#statusline#toggle_mode('syntax-checking')
  endif
  if exists(':Neomake')
    verbose NeomakeToggle
  elseif exists(':ALEInfo')
    if s:ale_flag == 1
      ALEToggle
      echo ' Ale is disabled globally.'
      let s:ale_flag = 0
    else
      ALEToggle
      echo ' Ale is enabled.'
      let s:ale_flag = 1
    endif
  endif
endfunction

function! s:explain_the_error() abort
  if exists(':Neomake')
    try
      let message = neomake#GetCurrentErrorMsg()
    catch /^Vim\%((\a\+)\)\=:E117/
      let message = ''
    endtry
  elseif exists(':ALEInfo')
    try
      let message = neomake#GetCurrentErrorMsg()
    catch /^Vim\%((\a\+)\)\=:E117/
      let message = ''
    endtry
  endif
  if !empty(message)
    echo message
  else
    echo 'no error message at this point!'
  endif
endfunction

function! s:error_transient_state() abort
  if g:checker ==# 'neomake'
    let num_errors = neomake#statusline#LoclistCounts()
  elseif g:checker ==# 'ale'
    let counts = ale#statusline#Count(buffer_name('%'))
    let num_errors = counts.error + counts.warning + counts.style_error
          \ + counts.style_warning
  else
    let num_errors = 0
  endif
  if empty(num_errors)
    echo 'no buffers contain error message locations'
    return
  endif
  let state = SpaceVim#api#import('transient_state')
  call state.set_title('Error Transient State')
  call state.defind_keys(
        \ {
        \ 'layout' : 'vertical split',
        \ 'left' : [
        \ {
        \ 'key' : 'n',
        \ 'desc' : 'next error',
        \ 'func' : '',
        \ 'cmd' : 'try | lnext | catch | endtry',
        \ 'exit' : 0,
        \ },
        \ ],
        \ 'right' : [
        \ {
        \ 'key' : ['p', 'N'],
        \ 'desc' : 'previous error',
        \ 'func' : '',
        \ 'cmd' : 'try | lprevious | catch | endtry',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : 'q',
        \ 'desc' : 'quit',
        \ 'func' : '',
        \ 'cmd' : '',
        \ 'exit' : 1,
        \ },
        \ ],
        \ }
        \ )
  call state.open()
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

" TODO clear errors
function! s:clear_errors() abort
  sign unplace *
endfunction


function! layers#checkers#showlinter() abort
  if exists(':ALEInfo')
    echo '  Now the syntax checker is Ale!'
  elseif exists(':Neomake')
    echo '  Now the syntax checker is Neomake!'
  endif
endfunc
