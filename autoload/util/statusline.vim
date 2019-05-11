"=========================================================================
" File Name    : autoload/util/statusline.vim
" Author       : AlanDing
" mail         :
" Created Time : Tue 26 Mar 2019 11:34:06 PM CST
"=========================================================================
scriptencoding utf-8


" airline
function! util#statusline#airline_init() abort
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
  if g:enable_fat_statusline && 1
    let g:airline_section_b    = "%{Statusline('filesize').Statusline('filenamela'). g:_bs .airline#extensions#branch#head().' '.Statusline('hunks')}"
    " let g:airline_section_b    = "%{Statusline('filesize'). g:_bs .airline#extensions#branch#head().' '.Statusline('hunks')}"
    let g:airline_section_y    = "%{Statusline('fileformat')}"
    let g:airline_section_z    = '%p%% %{g:_ln}%l:%c%{g:_mln} - %L% '
  else "}}}

  " slim {{{
    let g:airline_section_b      = "%{' '.airline#extensions#branch#head().' '.Statusline('hunks')}"
    let g:airline_section_y      = "%{Statusline('fileformat')}%p%%"
    let g:airline_section_z      = ' %l:%c - %L% '
    " let g:airline_section_b      = "%{' '.Statusline('gitbranch').' '.Statusline('hunks')}"
  endif "}}}

  " common {{{
  let g:airline_section_c      = "%{' '.Statusline('filenamera').' '.Statusline('readonly')}%m"
  let g:airline_section_x      = "%Y. %{Statusline('fileicon')}"
  " let g:airline_section_gutter = "%=%{Statusline('readonly').' '}"
  " let g:airline_section_error  = "%{' '.Statusline('diagnostic')}%= "
  let g:airline#extensions#tabline#tabs_label    = ' - TABS'
  let g:airline#extensions#tabline#buffers_label = Statusline('curtime'). ' - BUFFERS'
  "}}}
endfunction


" resource {{{
let g:_dir = g:enable_fat_statusline ? '⚡'  : ''
let g:_bs  = g:enable_fat_statusline ? '  ' : ''
let g:_ro  = g:enable_fat_statusline ? ''   : ''
let g:_mln = g:enable_fat_statusline ? ''   : ''
let g:_ln  = g:enable_fat_statusline ? ' ☰  ' : ''

function! util#statusline#pers() abort
  return '%p%% '
endfunction

function! util#statusline#curpos() abort
  return ' %l:%c '
endfunction

function! util#statusline#filenamela() abort
  let fname = winwidth(0) < 80 && strwidth(expand('%:t')) <= 15 ?
        \ ' ' : expand('%:t')
  return  &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'denite' ? denite#get_status('path') :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ fname. ' '
endfunction

function! util#statusline#filenamera() abort
  let fname = winwidth(0) > 100 ?
        \ (strwidth(expand('%:.')) < 50 ? expand('%:.') : expand('%:t')) :
        \ (strwidth(expand('%:t')) > 15 ? '' :
        \ expand('%:t').' '.util#statusline#modified())
  return  &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'denite' ? denite#get_status('path') :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ fname. ' '
endfunction

function! util#statusline#filesize() abort
  let l:size = getfsize(bufname('%'))
  if l:size == 0 || l:size == -1 || l:size == -2
    return ''
  endif
  if l:size < 1024
    return l:size.' bytes '
  elseif l:size < 1024*1024
    return '- ' . printf('%.1f', l:size/1024.0) . 'k  '
  elseif l:size < 1024*1024*1024
    return '- ' . printf('%.1f', l:size/1024.0/1024.0) . 'm  '
  else
    return '- ' . printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g  '
  endif
endfunction

function! util#statusline#system() abort
  return SpaceVim#api#import('system').fileformat(). ' '
endfunction

function! util#statusline#fileicon() abort
  let g:spacevim_filetype_icons = {}
  let icon = SpaceVim#api#import('file').fticon(bufname(bufnr('%')))
  return icon. ' '
endfunction

function! util#statusline#modified() abort
  return &filetype =~? 'help\|vimfiler\|defx\|Startify' ? '' :
        \ &modified ? '*' : &modifiable ? '-' : 'x'
endfunction

function! util#statusline#readonly() abort
  return &readonly ? g:_ro.' ' : ''
endfunction

function! util#statusline#fileformat() abort
  if g:enable_fat_statusline
    let ff = SpaceVim#api#import('system').fileformat(). ' '
    " return ' '. ff .' | '. &fenc
    return ' '. ff .' '. &fenc
  else
    return ' ['. (&fenc!=#''?&fenc:&enc) .'] '
  endif
endfunction
" function! CurrentTime(...) abort
  " let TIME = SpaceVim#api#import('time')
  " return ' ' . TIME.current_time() . ' '
" endfunction
" function! CurrentTime(...) abort
  " call jobstart("date '+%H:%M %m-%d' | tr -d '\n'", {
        " \ 'stdout_buffered': 1,
        " \ 'on_stdout': function('s:OnStdout')
        " \})
" endfunction
" function! s:OnStdout(id, data, event) dict abort
  " let s:time = get(a:data, 0, '')
" endfunction

function! util#statusline#curtime() abort
  let TIME = SpaceVim#api#import('time')
  if g:is_nvim
    return TIME.current_time() . strftime('%a %d/%b %Y')
  else
    return strftime('%b%d日 星期%a') .' '. TIME.current_time()
  endif
endfunction

" set statusline
function! util#statusline#pureline() abort
  try
    AirlineToggle
  catch
  endtry
  set statusline=" %<%F[%1*%M%*%n%R%H]%= %y %0(%{&ff}/%{&encoding} [%c:%l] %p%% - %L%) "
endfunc
"}}}


" Plugins integration

" vcs {{{
function! util#statusline#gitbranch() abort
  if exists('g:loaded_fugitive')
    try
      let l:head = fugitive#head()
      if empty(l:head)
        call fugitive#detect(getcwd())
        let l:head = fugitive#head()
      endif
      return empty(l:head) ? '' : g:_bs . l:head
    catch
    endtry
  endif
  return ''
endfunction

" +0 ~0 -0
function! util#statusline#hunks() abort
  let hunks = [0, 0, 0]
  if exists('b:coc_git_status')
    return b:coc_git_status
  elseif exists(':GitGutterFold')
    let hunks = GitGutterGetHunkSummary()
  elseif exists(':SignifyFold')
    let hunks = sy#repo#get_stats()
  endif
  let rst = ''
  if hunks[0] > 0
    let rst .=  '+' . hunks[0]
  endif
  if hunks[1] > 0
    let rst .=  ' ~' . hunks[1]
  endif
  if hunks[2] > 0
    let rst .=  ' -' . hunks[2]
  endif
  return empty(rst) ? '' : rst. ' '
endfunction
" }}}

" diagnostic {{{
function! util#statusline#diagnostic() abort
  if exists(':CocConfig')
    return <sid>coc()
  elseif exists(':AleInfo')
    return
  elseif exists('Neomake')
    return
  endif
endfunction

function! s:coc() abort
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
