"=============================================================================
" defx.vim --- defx configuration
"=============================================================================
scriptencoding utf-8


let s:SYS = SpaceVim#api#import('system')
let s:JOB = SpaceVim#api#import('job')

if g:filetree_direction ==# 'right'
  let s:direction = 'rightbelow'
else
  let s:direction = 'leftabove'
endif

call defx#custom#option('_', {
      \ 'winwidth'          : g:sidebar_width,
      \ 'split'             : 'vertical',
      \ 'direction'         : s:direction,
      \ 'show_ignored_files': 0,
      \ 'buffer_name'       : '',
      \ 'toggle'            : 1,
      \ 'resume'            : 1,
      \ 'root_marker'       : ': ',
      \ 'columns'           : 'git:mark:indent:icon:filename',
      \ })

call defx#custom#column('mark', {
      \ 'readonly_icon': '',
      \ 'selected_icon': '',
      \ })

call defx#custom#column('icon', {
      \ 'directory_icon': '',
      \ 'opened_icon'   : '',
      \ 'root_icon'     : 'R',
      \ })


augroup vfinit
  au!
  autocmd FileType defx call s:defx_init()
  " auto close last defx windows
  let g:_spacevim_autoclose_filetree = 0
  autocmd BufEnter * nested if
        \ (!has('vim_starting') && winnr('$') == 1  && g:_spacevim_autoclose_filetree
        \ && &filetype ==# 'defx') |
        \ call s:close_last_vimfiler_windows() | endif
augroup END

" in this function, we should check if shell terminal still exists,
" then close the terminal job before close vimfiler
function! s:close_last_vimfiler_windows() abort
  call SpaceVim#layers#shell#close_terminal()
  q
endfunction

function! s:defx_init()
  setl nonumber
  setl norelativenumber
  setl listchars=
  setl nofoldenable
  setl foldmethod=manual

  " disable this mappings
  nnoremap <silent><buffer> <3-LeftMouse> <Nop>
  nnoremap <silent><buffer> <4-LeftMouse> <Nop>
  nnoremap <silent><buffer> <LeftMouse> <LeftMouse><Home>

  silent! nunmap <buffer> <Space>
  silent! nunmap <buffer> <C-l>
  silent! nunmap <buffer> <C-j>
  silent! nunmap <buffer> E
  silent! nunmap <buffer> gr
  silent! nunmap <buffer> gf
  silent! nunmap <buffer> -
  silent! nunmap <buffer> s

  nnoremap <silent><buffer><expr> '
        \ defx#do_action('toggle_select') . 'j'
  " TODO: we need an action to clear all selections
  nnoremap <silent><buffer><expr> U
        \ defx#do_action('toggle_select_all')

  " Define mappings
  nnoremap <silent><buffer><expr> qq
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> c
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> P
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> j
        \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
        \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> h defx#do_action('call', 'DefxSmartH')
  nnoremap <silent><buffer><expr> <Left> defx#do_action('call', 'DefxSmartH')
  nnoremap <silent><buffer><expr> l defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> o defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> <Right> defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> <2-LeftMouse>
        \ defx#is_directory() ? 
        \     (
        \     defx#is_opened_tree() ?
        \     defx#do_action('close_tree') :
        \     defx#do_action('open_tree')
        \     )
        \ : defx#do_action('drop')
  nnoremap <silent><buffer><expr> sg
        \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> sv
        \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> ss
        \ defx#do_action('drop', 'split')
  nnoremap <silent><buffer><expr> st
        \ defx#do_action('drop', 'tabedit')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> N
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> K
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> M
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> d
        \ defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> D
        \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ~
        \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> <C-r>
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
        \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd defx#do_action('call', 'DefxChangeDir')
  nnoremap <silent><buffer><expr> t
        \ defx#do_action('toggle_columns',
        \                'git:mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> gx
        \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> g0
        \ defx#do_action('execute_command')
  nnoremap <silent><buffer> <Home> :call cursor(2, 1)<cr>
  nnoremap <silent><buffer> <End>  :call cursor(line('$'), 1)<cr>
  nnoremap <silent><buffer><expr>  <C-Home>
        \ defx#do_action('cd', SpaceVim#plugins#projectmanager#current_root())

  nnoremap <silent><buffer><expr> <Cr>  defx#do_action('call', 'DefxSmartCR')
  nnoremap <silent><buffer><expr> gs    defx#do_action('call', 'DefxExeShell')
  nnoremap <silent><buffer><Space>0     :call defx#call_action('change_vim_cwd')<CR>
        \:call SpaceVim#layers#shell#open_default_shell(1)<CR>
  nnoremap <silent><buffer><expr> Y     defx#do_action('call', 'YankName')
  nnoremap <silent><buffer><expr> yy    defx#do_action('call', 'DefxYarkPath')
  nnoremap <silent><buffer><expr> ys    defx#do_action('call', 'DefxYarkSrcLayout')
endf


function! DefxSmartL(_) "{{{
" in this function we should check vim-choosewin if possible
  if defx#is_directory()
    call defx#call_action('open_tree')
    normal! j
  else
    let filepath = defx#get_candidate()['action__path']
    if tabpagewinnr(tabpagenr(), '$') >= 3    " if there are more than 2 normal windows
      if exists(':ChooseWin') == 2
        ChooseWin
      else
        let input = input('ChooseWin No./Cancel(n): ')
        if input ==# 'n' | return | endif
        if input == winnr()
          echohl WarningMsg
          echo 'should`t choose exsiting defx window'
          echohl None
        endif
        exec input . 'wincmd w'
      endif
      exec 'e' filepath
    else
      exec 'wincmd w'
      exec 'e' filepath
    endif
  endif
endfunction "}}}

function! DefxSmartH(_) "{{{
  " if cursor line is first line, or in empty dir
  if line('.') ==# 1 || line('$') ==# 1
    return defx#call_action('cd', ['..'])
  endif

  " candidate is opend tree?
  if defx#is_opened_tree()
    return defx#call_action('close_tree')
  endif

  " parent is root?
  let s:candidate = defx#get_candidate()
  let s:parent = fnamemodify(s:candidate['action__path'], s:candidate['is_directory'] ? ':p:h:h' : ':p:h')
  let sep = s:SYS.isWindows ? '\\' :  '/'
  if s:trim_right(s:parent, sep) == s:trim_right(b:defx.paths[0], sep)
    return defx#call_action('cd', ['..'])
  endif

  " move to parent.
  call defx#call_action('search', s:parent)

  " if you want close_tree immediately, enable below line.
  call defx#call_action('close_tree')
endfunction "}}}


function! DefxSmartCR(_) "{{{
" in this function we should check vim-choosewin if possible
  if defx#is_directory()
    call defx#call_action('open_directory')
    normal! j
  else
    let filepath = defx#get_candidate()['action__path']
    if tabpagewinnr(tabpagenr(), '$') >= 3    " if there are more than 2 normal windows
      if exists(':ChooseWin') == 2
        ChooseWin
      else
        let input = input('ChooseWin No./Cancel(n): ')
        if input ==# 'n' | return | endif
        if input == winnr()
          echohl WarningMsg
          echo 'should`t choose exsiting defx window'
          echohl None
        endif
        exec input . 'wincmd w'
      endif
      exec 'e' filepath
    else
      exec 'wincmd w'
      exec 'e' filepath
    endif
  endif
endfunction "}}}

function! DefxYarkSrcLayout(_) abort "{{{
  if defx#is_directory()
    let dirpath = defx#get_candidate()['action__path']
  else
    let dirpath = fnamemodify(defx#get_candidate()['action__path'], ':h')
  endif
  let srcname = {'1': 'cpp', '2': 'scala'}[
        \ inputlist(['Select SourceDir :',
        \ '1. cpp'   ,
        \ '2. scala' ,
        \ ])]
  " inputlist() by default return 0 if no input or press <ESC>
  if srcname =~# 0 | return | endif
  let dst_name = input('Input DestinationDirname/Cancel(n) : ')
  if dst_name ==# 'n' | return | endif

  let srcp = expand(g:home.'etc/template/'.srcname)
  let tarp = expand(dirpath.'/'.dst_name)
  call util#simple_job('cp -rf '.srcp.' '.tarp)
  call util#echohl(' yarked: '.srcp.' => '.tarp )
endfunction
"}}}

function! DefxExeShell(_) abort "{{{
  if defx#is_directory()
    call util#echohl(' Candidate is not a shell script!')
  else
    let filepath = defx#get_candidate()['action__path']
    let ext = fnamemodify(filepath, ':e')
    let success_msg = 'Successfully run stript'

    if ext ==# 'sh' && g:is_unix
      call util#simple_job('bash '.filepath, success_msg)
    elseif (ext ==# 'bat' || ext ==# 'ps1') && g:is_win
      call util#simple_job('powershell '.filepath, success_msg)
    else
      call util#echohl(' Candidate is not a shell script!')
    endif
  end
endfunction
"}}}

function! DefxChangeDir(_) abort "{{{
  call defx#call_action('change_vim_cwd')
  echo 'Current dir is: ' . getcwd()
endfunction
"}}}

function! YankName(context) abort " {{{
  let yank = join(map(a:context.targets, "fnamemodify(v:val, ':t')"), "\n")
  call setreg('"', yank)
endfunction  " }}}


function! DefxYarkPath(_) abort
  let candidate = defx#get_candidate()
  let @+ = candidate['action__path']
  echo 'yarked: ' . @+
endfunction

function! s:trim_right(str, trim)
  return substitute(a:str, printf('%s$', a:trim), '', 'g')
endfunction
