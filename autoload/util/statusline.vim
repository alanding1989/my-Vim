"=========================================================================
" File Name    : autoload/util/statusline.vim
" Author       : AlanDing
" mail         :
" Created Time : Tue 26 Mar 2019 11:34:06 PM CST
"=========================================================================
scriptencoding utf-8

" TODO: realtime clock show


" airline
function! util#statusline#airline() abort
  " let g:airline#extensions#default#layout  = [ {{{
  " \ [ 'a', 'b', 'c' ],
  " \ [ 'x', 'y', 'z', 'error', 'warning' ]
  " \ ]
  "let g:airline_section_a       (mode, crypt, paste, spell, iminsert)
  "let g:airline_section_b       (hunks, branch)[*]
  "let g:airline_section_c       (bufferline or filename)
  "let g:airline_section_gutter  (readonly, csv)
  "let g:airline_section_x       (tagbar, filetype, virtualenv)
  "let g:airline_section_y       (fileencoding, fileformat)
  "let g:airline_section_z       (percentage, line number, column number) }}}

  " more feature {{{
  if g:enable_fat_statusline
    let g:airline_section_b      = "%{util#statusline#Filenamela().'   '.airline#extensions#branch#head().' '.airline#extensions#hunks#get_hunks()}"
    let g:airline_section_c      = "%{' '.util#statusline#Filenamera().'  '.util#statusline#Fileicon().' '.util#statusline#Readonly()}"
    let g:airline_section_y      = "%{' '.SpaceVim#api#import('system').fileformat().'  '.&fenc}"
    let g:airline_section_gutter = "%=%{util#statusline#Readonly().'  '}"
  else "}}}

  " slim {{{
  " let g:airline#extensions#default#layout = [
        " \ [ 'a', 'b', 'c'],
        " \ [ 'x', 'y', 'z', 'error'],
        " \ ]
  " let g:airline_section_error = "%{' '.util#statusline#CocDiagnostic()}%= "

    let g:airline_section_b = "%{' '.airline#extensions#branch#head().' '.airline#extensions#hunks#get_hunks()}"
    let g:airline_section_c = "%{' '.util#statusline#Filenamera().' '}%m"
    let g:airline_section_x = "%Y. %{util#statusline#Fileicon().' '}"
    let g:airline_section_y = "%{' ['.&fenc.'] '}%p%%"
    let g:airline_section_z = ' %c:%l - %L% '
  endif "}}}
  let g:airline#extensions#tabline#tabs_label    = util#statusline#curtime().' - TABS'
  let g:airline#extensions#tabline#buffers_label = util#statusline#curtime().' - BUFFERS'
endfunction


" resource {{{
function! CurrentTime(...) abort
  call jobstart("date '+%H:%M %m-%d' | tr -d '\n'", {
        \ 'stdout_buffered': 1,
        \ 'on_stdout': function('s:OnStdout')
        \})
endfunction
function! s:OnStdout(id, data, event) dict abort
  let s:time = get(a:data, 0, '')
endfunction

" set statusline
function! util#statusline#pureline() abort
  try
    AirlineToggle
  catch
  endtry
  set statusline=" %<%F[%1*%M%*%n%R%H]%= %y %0(%{&ff}/%{&encoding} [%c:%l] %p%% - %L%) "
endfunc

function! util#statusline#Filenamela() abort
  let fname = winwidth(0) < 80 && strwidth(expand('%:t')) <= 15 ?
        \ ' ' : ' '.util#statusline#Modified().' '.expand('%:t')
  return  &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'denite' ? denite#get_status('path') :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ fname
endfunction

function! util#statusline#Filenamera() abort
  let fname = winwidth(0) > 100 ?
        \ (strwidth(expand('%:.')) < 50 ? expand('%:.') : expand('%:t')) :
        \ (strwidth(expand('%:t')) > 15 ? '' :
        \ expand('%:t').' '.util#statusline#Modified())
  return  &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'denite' ? denite#get_status('path') :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ fname
endfunction

function! util#statusline#Fileicon() abort
let g:spacevim_filetype_icons = {}
  let icon = SpaceVim#api#import('file').fticon(bufname(bufnr('%')))
  return icon
endfunction

function! util#statusline#Modified() abort
  return &filetype =~? 'help\|vimfiler\|defx\|Startify' ? '' :
        \ &modified ? '[*]' : &modifiable ? '-' : 'x'
endfunction

function! util#statusline#Readonly() abort
  return &readonly ? '' : ''
endfunction

function! util#statusline#curtime() abort
  if g:is_nvim
    return strftime('%a %d/%b %Y')
    " return strftime('%H:%M %a %d/%b')
  else
    return strftime('%b%d日 星期%a')
  endif
endfunction
"}}}


" Plugins integration {{{
function! util#statusline#Gitbranch() abort
  if exists('g:loaded_fugitive')
    try
      let l:head = fugitive#head()
      if empty(l:head)
        call fugitive#detect(getcwd())
        let l:head = fugitive#head()
      endif
      return empty(l:head) ? '' : ' '.l:head
    catch
    endtry
  endif
  return ''
endfunction

" +0 ~0 -0
function! util#statusline#Hunks() abort
  let hunks = [0,0,0]
  try
    let hunks = sy#repo#get_stats()
  catch
  endtry
  let rst = ''
  if hunks[0] > 0
    let rst .=  '+ ' . hunks[0]
  endif
  if hunks[1] > 0
    let rst .=  '~ ' . hunks[1]
  endif
  if hunks[2] > 0
    let rst .=  '- ' . hunks[2]
  endif
  return empty(rst) ? '' : '' . rst
endfunction

function! util#statusline#CocDiagnostic() abort
  let E = '❌'
  let W = '⚠️ '
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, E . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, W . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction
"}}}
