"=============================================================================
" core.vim --- core layer
" Section: layers
"=============================================================================
scriptencoding utf-8


function! layers#core#plugins() abort
  let plugins = [
        \ ['Shougo/unite.vim'    , {'merged': 0}],
        \ ]
  if g:is_win
    call add(plugins, ['Shougo/vimproc.vim', {'build' : '.\mingw32-make.exe', 'do': '.\mingw32-make.exe'}])
  else
    call add(plugins, ['Shougo/vimproc.vim', {'build' : [(executable('gmake') ? 'gmake' : 'make')],
          \ 'do': (executable('gmake') ? 'gmake' : 'make')}])
  endif
  " if executable('ctags')
    " call add(plugins, ['liuchengxu/vista.vim', {'on_cmd': 'Vista!!', 'on': 'Vista!!'}])
  " endif
  if !g:is_spacevim
    let plugins += [
          \ ['wsdjeg/FlyGrep.vim'      ,     {'merged' : 0}],
          \ ['rhysd/clever-f.vim'      ,     {'merged' : 0}],
          \ ['andymass/vim-matchup'    ,     {'merged' : 0}],
          \ ['scrooloose/nerdcommenter',     {'merged' : 0}],
          \ ['liuchengxu/vim-which-key',     {'merged' : 0}],
          \ ['tyru/open-browser.vim'   ,     {'on_map': '<Plug>(openbrowser-',
          \ 'on_cmd': ['OpenBrowserSmartSearch', 'OpenBrowser', 'OpenBrowserSearch'],
          \ 'on'    : ['OpenBrowserSmartSearch', 'OpenBrowser', 'OpenBrowserSearch']}],
          \ ]
    if g:filemanager ==# 'nerdtree'
      call add(plugins, ['scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle', 'on': 'NERDTreeToggle'}])
      call add(plugins, ['Xuyuanp/nerdtree-git-plugin', {'merged' : 0}])
    elseif g:filemanager ==# 'vimfiler'
      call add(plugins, ['Shougo/vimfiler.vim', {'on_cmd': ['VimFiler', 'VimFilerBufferDir']}])
    elseif g:filemanager ==# 'defx'
      call add(plugins, ['Shougo/defx.nvim'   , {'merged': 0}])
      " call add(plugins, ['kristijanhusak/defx-icons', {'merged': 0}])
    endif
    if !has('nvim') && g:is_vim8
      " NOTE: in Vim8, many plugins need the follwing two dependencis
      " ncm2, deoplete, denite, defx etc..
      call add(plugins, ['SpaceVim/nvim-yarp'         , {'merged': 0}])
      call add(plugins, ['SpaceVim/vim-hug-neovim-rpc', {'merged': 0}])
    endif
  endif
  return plugins
endfunction


function! layers#core#config() abort
  call s:comment()
  call s:filetree()
  call s:flygrep()
  call s:unimpaired()
  call s:open_browser()

  if g:is_spacevim
    exec 'so '. g:vim_plugindir .'unite.vim'
    unlet g:_spacevim_mappings_space.b.R | nunmap [SPC]bR
    call SpaceVim#mapping#space#def('nmap'    , ['b', 'r'], '<Plug>(Safe-Revert-Buffer)', 'safe revert buffer', 0)
    call SpaceVim#mapping#space#def('nnoremap', ['p', 's'], ':Grepper', 'safe revert buffer', 1)

    let g:_spacevim_mappings.a   = get(g:_spacevim_mappings, 'a', {'name' : '+@ Session/Setting/Select'})
    let g:_spacevim_mappings.a.c = {'name': '+Open config file'}
    let g:_spacevim_mappings.a.a = ['normal! ggVG'              , 'select whole buffer']
    let g:_spacevim_mappings.a.e = ['normal! VG'                , 'select to the end'  ]
    call SpaceVim#mapping#def('nmap', '<leader>az', 
          \ '<Plug>(Toggle-ZZMode)', 'toggle zzmode', '', 'toggle zzmode')
    call SpaceVim#mapping#def('nnoremap', '<leader>ap', 
          \ "i\<C-r>=expand('%:p')\<CR>\<Esc>",
          \ 'paste file absolute path', '', 'paste file absolute path')

  else
    let g:matchup_matchparen_status_offscreen = 0

    nmap     <leader>y    <Plug>(EasyCopy-inPairs)
    nmap     <leader>az   <plug>(Toggle-ZZMode)   

    nmap     <Space>be    <plug>(Safe-Erase-Buffer) 
    nmap     <Space>br    <plug>(Safe-Revert-Buffer)
    nnoremap <Space>bm    :call <sid>open_message_buffer()<CR>
    nnoremap <Space>b.    :call <sid>buffer_transient_state()<CR>

    nnoremap <Space>n=    :call <sid>number_transient_state('+')<CR>
    nnoremap <Space>n-    :call <sid>number_transient_state('-')<CR>

    nnoremap <Space>jn    i<CR><Esc>
    nnoremap <Space>jo    i<CR><Esc>k$
    nnoremap <Space>js    :call <sid>split_string(0)<CR>i
    nnoremap <Space>jS    :call <sid>split_string(1)<CR>

    nnoremap <Space>ju    :call <sid>jump_to_url()<CR>

    nnoremap <Space>ps    :Grepper<CR>
  endif
endfunction


" plugin funcs {{{
function! s:filetree() abort " {{{
  if g:is_spacevim
    " a:num = 0 open root dir
    " a:num = 1 open last opened dir
    " a:num = 2 open buffer dir/root dir(VimEnter)
    " a:num = 3 open my src layout dir
    " a:num = 4 open current dir in fullscreen with more infor
    " a:num = 5 open my plugins bundle dir
    " a:num = 6 open my dotfile dir
    " a:num = 7 open a new defx buffer in current working dir
    " a:num = 8 open my dev dir
    nnoremap <silent><F3>         :call <SID>open_filetree(0)<CR>
    call SpaceVim#mapping#space#def('nnoremap', ['f','o'], 'call call('
          \ . string(function('s:open_filetree'))
          \ . ', [1])', '@ open last opened dir', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['<Tab>'], 'call call('
          \ . string(function('s:open_filetree'))
          \ . ', [2])', '@ show file tree at buffer dir', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['f','a'], 'call call('
          \ . string(function('s:open_filetree'))
          \ . ', [3])', '@ open my vimrc dir', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['f','i'], 'call call('
          \ . string(function('s:open_filetree'))
          \ . ', [4])', '@ Investigate current working dir', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['f','p'], 'call call('
          \ . string(function('s:open_filetree'))
          \ . ', [5])', '@ open my plugins bundle dir', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['f','.'], 'call call('
          \ . string(function('s:open_filetree'))
          \ . ', [6])', '@ open my dotfile dir', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['f','n'], 'call call('
          \ . string(function('s:open_filetree'))
          \ . ', [7])', '@ open new file window in current working dir', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['f','d'], 'call call('
          \ . string(function('s:open_filetree'))
          \ . ', [8])', '@ open my dev dir', 1)
  else
    nnoremap <silent><F3>         :call <SID>open_filetree(0)<CR>
    nnoremap <silent><Space>fo    :call <SID>open_filetree(1)<CR>
    nnoremap <silent><Space><tab> :call <SID>open_filetree(2)<CR>
    nnoremap <silent><Space>fa    :call <SID>open_filetree(3)<CR>
    nnoremap <silent><Space>fi    :call <SID>open_filetree(4)<CR>
    nnoremap <silent><Space>fp    :call <SID>open_filetree(5)<CR>
    nnoremap <silent><Space>f.    :call <SID>open_filetree(6)<CR>
    nnoremap <silent><Space>fn    :call <SID>open_filetree(7)<CR>
    nnoremap <silent><Space>fn    :call <SID>open_filetree(8)<CR>
  endif
endfunction

" open filemanager {{{
" a:num = 0 open root dir
" a:num = 1 open last opened dir
" a:num = 2 open current buffer dir/root dir(when VimEnter)
" a:num = 3 open my vimrc favourite dir
" a:num = 4 inverstigate current working dir (fullscreen)
" a:num = 5 open my plugins bundle dir
" a:num = 6 open my dotfile dir
" a:num = 7 open a new defx buffer in current working dir
let s:my_vimrc_dir   = g:home
let s:my_dotfile_dir = g:is_win ? 'E:\my-Dotfile' : '/mnt/fun+downloads/my-Dotfile'
let s:my_dev_dir     = g:iw_win?  'C:\' : '/home/alanding/0_Dev/'
if get(g:, 'spacevim_filemanager', get(g:, 'filemanager', 'vimfiler')) ==# 'vimfiler'

  function! s:open_filetree(num) abort "{{{
    if a:num == 0
      exec 'VimFiler '.getcwd()
    elseif a:num == 1
      VimFiler
    elseif a:num == 2
      VimFilerBufferDir
    elseif a:num == 3
      exec 'VimFiler '.expand(s:my_vimrc_dir)
    elseif a:num == 4
      let g:_spacevim_autoclose_filetree = 0
      VimFilerCurrentDir -no-split -columns=type:size:time
      let g:_spacevim_autoclose_filetree = 1
    elseif a:num == 5
      call <sid>open_plugins_dir('VimFiler ')
    elseif a:num == 6
      exec 'VimFiler '.expand(s:my_dotfile_dir)
    elseif a:num == 7
      exec 'VimFiler '.expand(s:my_dotfile_dir)
    elseif a:num == 8
      exec 'VimFiler '.expand(s:my_dev_dir)
    endif
    doautocmd WinEnter
  endfunction "}}}
elseif get(g:, 'spacevim_filemanager', get(g:, 'filemanager', 'vimfiler')) ==# 'defx'

  function! s:open_filetree(num) abort "{{{
    if a:num == 0
      Defx `getcwd()`
    elseif a:num == 1
      Defx
    elseif a:num == 2
      Defx `expand('%:p:h')`
    elseif a:num == 3
      Defx `expand(s:my_vimrc_dir)`
    elseif a:num == 4
      let g:_spacevim_autoclose_filetree = 0
      Defx -split=no -columns=git:mark:indent:filename:type:size:time `getcwd()`
      let g:_spacevim_autoclose_filetree = 1
    elseif a:num == 5
      call <sid>open_plugins_dir('Defx ')
    elseif a:num == 6
      Defx `expand(s:my_dotfile_dir)`
    elseif a:num == 7
      Defx -new `getcwd()`
    elseif a:num == 8
      Defx `expand(s:my_dev_dir)`
    endif
    if &ft ==# 'defx' | setl conceallevel=2 | endif
    doautocmd WinEnter
  endfunction "}}}
elseif get(g:, 'spacevim_filemanager', get(g:, 'filemanager', 'vimfiler')) ==# 'nerdtree'

  function! s:open_filetree(num) abort "{{{
    if a:num == 0
      exec 'e '.getcwd()
    elseif a:num == 1
      NERDTreeToggle
    elseif a:num == 2
      NERDTree %
    elseif a:num == 3
      exec 'NERDTree '.expand(s:my_vimrc_dir)
    elseif a:num == 4
      exec 'e '.getcwd()
    elseif a:num == 5
      call <sid>open_plugins_dir('NERDTree ')
    elseif a:num == 6
      exec 'NERDTree '.expand(s:my_dotfile_dir)
    elseif a:num == 7
      exec 'NERDTree '.expand(s:my_dotfile_dir)
    elseif a:num == 8
      exec 'NERDTree '.expand(s:my_dotfile_dir)
    endif
    doautocmd WinEnter
  endfunction "}}}
endif
function! s:open_plugins_dir(cmd) abort "{{{
  let temp = @a | let @a=''
  normal! mz"ayi'
  normal! `z
  let selfp = g:is_vim8  ? g:My_Vim_plug_dir : g:spacevim_plugin_bundle_dir
  let altp = !g:is_vim8 ? g:My_Vim_plug_dir : g:spacevim_plugin_bundle_dir
  if exists('#dein')
    if glob(selfp .'repos/github.com/'.@a) !=# ''
      exec a:cmd .selfp .'repos/github.com/' . @a
    elseif glob(altp .'repos/github.com/' . @a) !=# ''
      exec a:cmd .altp .'repos/github.com/' . @a
    endif
  else
    let plugn = split(@a, '/')[1]
    if glob(selfp .(g:is_vim8 ? '' : 'repos/github.com/') .plugn) !=# ''
      exec a:cmd .selfp .plugn
    elseif glob(altp .(g:is_vim8 ? '' : 'repos/github.com/') .plugn) !=# ''
      exec a:cmd .altp .plugn 
    endif
  endif
  let @a = temp
endfunction "}}} }}} }}}

function! s:comment() abort " {{{
  if g:is_spacevim
    call SpaceVim#mapping#space#def('nmap', ['c' , 'c'], '<Plug>NERDCommenterInvert' , '@ toggle comment lines', 0 )
    call SpaceVim#mapping#space#def('nmap', ['c' , 'C'], '<Plug>NERDCommenterComment', '@ comment lines'       , 0 )

  else
    " NOTE: below 3 shoudn`t be noremap
    map <Space>cl <plug>NERDCommenterInvert
    map <Space>cL <plug>NERDCommenterComment
    map <Space>cc <plug>NERDCommenterInvert
    map <Space>cC <plug>NERDCommenterComment

    map      <Space>ct <plug>CommentToLineInvert
    map      <Space>cp <plug>CommentParagraphsInvert
    map      <Space>;  <plug>CommentOperator
    nnoremap <silent>  <Plug>CommentToLineInvert     : call <SID>comment_to_line(1)<CR>
    nnoremap <silent>  <Plug>CommentParagraphsInvert : call <SID>comment_paragraphs(1)<CR>
    nnoremap <silent>  <Plug>CommentOperator         : set opfunc=<SID>commentOperator<CR>g@
  endif
endfunction " }}}

function! s:unimpaired() abort " {{{
  " Unimpaired bindings
  " ]e or [e move current line ,count can be useed
  nnoremap <silent> [a  :<c-u>execute 'move -1-'. v:count1<CR>
  nnoremap <silent> ]a  :<c-u>execute 'move +'. v:count1<CR>

  " [b or ]b go to previous or next buffer
  nnoremap <silent> [b :<c-u>bN \| stopinsert<cr>
  nnoremap <silent> ]b :<c-u>bn \| stopinsert<cr>

  " [f or ]f go to next or previous file in dir
  nnoremap <silent> [f  :<c-u>call <SID>previous_file()<CR>
  nnoremap <silent> ]f  :<c-u>call <SID>next_file()<CR>

  " [l or ]l go to next and previous error(location list)
  nnoremap <silent> [l  :lprevious<CR>
  nnoremap <silent> ]l  :lnext<CR>

  " [p or ]p for p and P
  nnoremap <silent> [p  P
  nnoremap <silent> ]p  p

  "]<End> or ]<Home> move current line to the end or the begin of current buffer
  nnoremap <silent> [1  ddggP``
  vnoremap <silent> [1  dggP``
  nnoremap <silent> ]1  ddGp``
  vnoremap <silent> ]1  dGp``

  " ale
  nmap     <silent> [e  <Plug>(ale_previous_wrap)
  nmap     <silent> ]e  <Plug>(ale_next_wrap)

  " coc

  " [g or ]g go to next or previous vcs hunk
endfunction " }}}

function! s:flygrep() abort " {{{
  if g:is_spacevim
    try
      unlet g:_spacevim_mappings_space.s.a
      unlet g:_spacevim_mappings_space.s.g
      unlet g:_spacevim_mappings_space.s.i
      unlet g:_spacevim_mappings_space.s.k
      unlet g:_spacevim_mappings_space.s.r
      unlet g:_spacevim_mappings_space.s.t
      unlet g:_spacevim_mappings_space.s.c
      unlet g:_spacevim_mappings_space.s['/']
    catch
    endtry
    call SpaceVim#mapping#space#def('nnoremap', ['s', 'o'], 'call SpaceVim#plugins#flygrep#open({})',
          \ 'grep on the fly', 1)
  else
    let g:spacevim_debug_level = 1
    " Searching in current buffer
    nnoremap<Space>ss  :call SpaceVim#plugins#flygrep#open({'input': input("grep pattern:"), 'files': bufname("%")})<CR>
    nnoremap<Space>sS  :call SpaceVim#plugins#flygrep#open({'input': expand("<cword>")     , 'files': bufname("%")})<CR>
    " Searching in all loaded buffers
    nnoremap<Space>sb  :call SpaceVim#plugins#flygrep#open({'input': input("grep pattern:"), 'files': '@buffers'})<CR>
    nnoremap<Space>sB  :call SpaceVim#plugins#flygrep#open({'input': expand("<cword>")     , 'files': '@buffers'})<CR>
    " Searching in buffer directory
    nnoremap<Space>sd  :call SpaceVim#plugins#flygrep#open({'input': input("grep pattern:"), 'dir'  : fnamemodify(expand('%'), ':p:h')})<CR>
    nnoremap<Space>sD  :call SpaceVim#plugins#flygrep#open({'input': expand("<cword>")     , 'dir'  : fnamemodify(expand('%'), ':p:h')})<CR>
    " Searching in files in an arbitrary directory
    nnoremap<Space>sf  :call SpaceVim#plugins#flygrep#open({'input': input("grep pattern:"), 'dir'  : input("arbitrary dir:", '', 'dir')})<CR>
    nnoremap<Space>sF  :call SpaceVim#plugins#flygrep#open({'input': expand("<cword>")     , 'dir'  : input("arbitrary dir:", '', 'dir')})<CR>
    " Searching in project
    nnoremap<Space>sp  :call SpaceVim#plugins#flygrep#open({'input': input("grep pattern:"), 'dir'  : get(b:, "rootDir", getcwd())})<CR>
    nnoremap<Space>sP  :call SpaceVim#plugins#flygrep#open({'input': expand("<cword>")     , 'dir'  : get(b:, "rootDir", getcwd())})<CR>
    " Searching background
    nnoremap<Space>sj  :call SpaceVim#plugins#searcher#find(""                             , SpaceVim#mapping#search#default_tool()[0])<CR>
    nnoremap<Space>sJ  :call SpaceVim#plugins#searcher#find(expand("<cword>")              , SpaceVim#mapping#search#default_tool()[0])<CR>
    nnoremap<Space>sl  :call SpaceVim#plugins#searcher#list()<CR>
    " <Space>s/
    nnoremap<Space>so  :call SpaceVim#plugins#flygrep#open({})<CR>
  endif
endfunction " }}}

function! s:open_browser() abort " {{{
  let g:openbrowser_default_search = 'baidu'
  if g:is_spacevim
    let g:_spacevim_mappings.o          = {'name': '+@ OpenBrowser'}
    let g:_spacevim_mappings.o.a        = ['call feedkeys(":OpenBrowser ")'                    , 'OpenBrowser prefix' ]
    let g:_spacevim_mappings.o.o        = ['call feedkeys("\<Plug>(openbrowser-smart-search)")', 'cursor word search /default engine']
    let g:_spacevim_mappings.o.b        = ['call feedkeys(":OpenBrowserSmartSearch -baidu ")'  , 'keyword search /baidu' ]
    let g:_spacevim_mappings.o.g        = ['call feedkeys(":OpenBrowserSmartSearch -google ")' , 'keyword search /google']
    let g:_spacevim_mappings.o.h        = ['call feedkeys(":OpenBrowserSmartSearch -github ")' , 'keyword search /github']
    let g:_spacevim_mappings.o.c        = ['OpenlinkOrSearch arec'                             , 'open my asciinema cast']
    let g:_spacevim_mappings.o.r        = ['call util#Open_curPlugin_repo()'                   , 'open github mainpage/cursor plugin`s repo']
    let g:_spacevim_mappings.o['.']     = ['call util#vg_starred_repos()'                      , 'view github starred repos']
    let g:_spacevim_mappings.o['[SPC]'] = ['OpenlinkOrSearch spc'                              , 'open SpaceVim CN website']
    " language docs
    augroup layer_core_openbrowser
      autocmd!
      auto FileType python,ipynb call SpaceVim#mapping#def('nnoremap', '<leader>op',
            \ 'call feedkeys(":OpenBrowserSmartSearch -python ")', 'docs search /python', 1)
      auto FileType scala call SpaceVim#mapping#def('nnoremap', '<leader>os',
            \ 'call feedkeys(":OpenlinkOrSearch scala ")', 'docs search /scala', 1)
    augroup END
  else
    nnoremap <leader>oa        :call feedkeys(':OpenBrowser ')<CR>
    nnoremap <leader>oo        <Plug>(openbrowser-smart-search)
    nnoremap <leader>ob        :call feedkeys(':OpenBrowserSmartSearch -baidu ')<CR>
    nnoremap <leader>og        :call feedkeys(':OpenBrowserSmartSearch -google ')<CR>
    nnoremap <leader>oh        :call feedkeys(':OpenBrowserSmartSearch -github ')<CR>
    nnoremap <leader>oc        :OpenlinkOrSearch arec<CR>
    nnoremap <leader>or        :call util#Open_curPlugin_repo()<CR>
    nnoremap <leader>o<Space>  :OpenlinkOrSearch spc<CR>
    " language docs
    augroup layer_core_openbrowser
      autocmd!
      auto FileType python, ipynb nnoremap <leader>op  :call feedkeys(':OpenBrowserSmartSearch -python ')<CR>
      auto FileType scala nnoremap <leader>os  :call feedkeys(':OpenlinkOrSearch scala ')<CR>
    augroup END
  endif
endfunction
" open or search websites {{{
function! layers#core#OpenlinkOrSearch(key, ...) abort
  let url = {
        \ 'scala': 'https://www.scala-lang.org/api/current/index.html?search=',
        \ 'arec' : 'https://asciinema.org/~alanding',
        \ 'spc'  : 'https://spacevim.org/cn/layers',
        \ }
  if a:0 > 0
    exec 'OpenBrowser '.url[a:key].a:1
  else
    exec 'OpenBrowser '.url[a:key]
  endif
endfunction "}}} }}}
"}}}


" local funcs {{{
function! s:number_transient_state(n) abort
  if a:n ==# '+'
    exe "normal! \<c-a>"
  else
    exe "normal! \<c-x>"
  endif
  let state = SpaceVim#api#import('transient_state')
  call state.set_title('Number Transient State')
  call state.defind_keys(
        \ {
        \ 'layout' : 'vertical split',
        \ 'left' : [
        \ {
        \ 'key' : ['+','='],
        \ 'desc' : 'increase number',
        \ 'func' : '',
        \ 'cmd' : "normal! \<c-a>",
        \ 'exit' : 0,
        \ },
        \ ],
        \ 'right' : [
        \ {
        \ 'key' : '-',
        \ 'desc' : 'decrease number',
        \ 'func' : '',
        \ 'cmd' : "normal! \<c-x>",
        \ 'exit' : 0,
        \ },
        \ ],
        \ }
        \ )
  call state.open()
endfunction

let s:file = SpaceVim#api#import('file')
let s:MESSAGE = SpaceVim#api#import('vim#message')
let s:CMP = SpaceVim#api#import('vim#compatible')
function! s:next_file() abort
  let dir = expand('%:p:h')
  let f = expand('%:t')
  let file = s:file.ls(dir, 1)
  if index(file, f) == -1
    call add(file,f)
  endif
  call sort(file)
  if len(file) != 1
    if index(file, f) == len(file) - 1
      exe 'e ' . dir . s:file.separator . file[0]
    else
      exe 'e ' . dir . s:file.separator . file[index(file, f) + 1]
    endif
  endif
endfunction

function! s:previous_file() abort
  let dir = expand('%:p:h')
  let f = expand('%:t')
  let file = s:file.ls(dir, 1)
  if index(file, f) == -1
    call add(file,f)
  endif
  call sort(file)
  if len(file) != 1
    if index(file, f) == 0
      exe 'e ' . dir . s:file.separator . file[-1]
    else
      exe 'e ' . dir . s:file.separator . file[index(file, f) - 1]
    endif
  endif
endfunction

function! s:split_string(newline) abort
  let syn_name = synIDattr(synID(line('.'), col('.'), 1), 'name')
  if syn_name == &filetype . 'String'
    let c = col('.')
    let sep = ''
    while c > 0
      if s:is_string(line('.'), c)
        let c = c - 1
      else
        let sep = getline('.')[c]
        break
      endif
    endwhile
    if a:newline
      let save_register_m = @m
      let @m = sep . "\n" . sep
      normal! "mp
      let @m = save_register_m
    else
      let save_register_m = @m
      let @m = sep . sep
      normal! "mp
      let @m = save_register_m
    endif
  endif
endfunction

function! s:is_string(l,c) abort
  return synIDattr(synID(a:l, a:c, 1), 'name') == &filetype . 'String'
endfunction

function! s:jump_to_url() abort
  let g:EasyMotion_re_anywhere = 'http[s]*://'
  call feedkeys("\<Plug>(easymotion-jumptoanywhere)")
endfunction

function! s:open_message_buffer() abort
  vertical topleft edit __Message_Buffer__
  setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nowrap cursorline nospell nonumber norelativenumber
  setf message
  normal! ggdG
  silent put =s:CMP.execute(':message')
  normal! G
  setlocal nomodifiable
  nnoremap <silent> <buffer> qq :silent bd<CR>
endfunction

function! s:swap_buffer_with_nth_win(nr) abort
  if a:nr <= winnr('$') && a:nr != winnr()
    let cb = bufnr('%')
    let tb = winbufnr(a:nr)
    if cb != tb
      exe a:nr . 'wincmd w'
      exe 'b' . cb
      wincmd p
      exe 'b' . tb
    endif
  endif
endfunction

function! s:move_buffer_to_nth_win(nr) abort
  if a:nr <= winnr('$') && a:nr != winnr()
    let cb = bufnr('%')
    bp
    exe a:nr . 'wincmd w'
    exe 'b' . cb
    wincmd p
  endif
endfunction

function! s:buffer_transient_state() abort " {{{
  let state = SpaceVim#api#import('transient_state')
  call state.set_title('Buffer Selection Transient State')
  call state.defind_keys(
        \ {
        \ 'layout' : 'vertical split',
        \ 'left' : [
        \ {
        \ 'key' : {
        \ 'name' : 'C-1..C-9',
        \ 'pos' : [[1,4], [6,9]],
        \ 'handles' : [
        \ ["\<C-1>" , ''],
        \ ["\<C-2>" , ''],
        \ ["\<C-3>" , ''],
        \ ["\<C-4>" , ''],
        \ ["\<C-5>" , ''],
        \ ["\<C-6>" , ''],
        \ ["\<C-7>" , ''],
        \ ["\<C-8>" , ''],
        \ ["\<C-9>" , ''],
        \ ],
        \ },
        \ 'desc' : 'goto nth window',
        \ 'func' : '',
        \ 'cmd' : '',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : {
        \ 'name' : '1..9',
        \ 'pos' : [[1,2], [4,5]],
        \ 'handles' : [
        \ ['1' , 'call call(' . string(s:_function('s:move_buffer_to_nth_win')) . ', [1])'],
        \ ['2' , 'call call(' . string(s:_function('s:move_buffer_to_nth_win')) . ', [2])'],
        \ ['3' , 'call call(' . string(s:_function('s:move_buffer_to_nth_win')) . ', [3])'],
        \ ['4' , 'call call(' . string(s:_function('s:move_buffer_to_nth_win')) . ', [4])'],
        \ ['5' , 'call call(' . string(s:_function('s:move_buffer_to_nth_win')) . ', [5])'],
        \ ['6' , 'call call(' . string(s:_function('s:move_buffer_to_nth_win')) . ', [6])'],
        \ ['7' , 'call call(' . string(s:_function('s:move_buffer_to_nth_win')) . ', [7])'],
        \ ['8' , 'call call(' . string(s:_function('s:move_buffer_to_nth_win')) . ', [8])'],
        \ ['9' , 'call call(' . string(s:_function('s:move_buffer_to_nth_win')) . ', [9])'],
        \ ],
        \ },
        \ 'desc' : 'move buffer to nth window',
        \ 'func' : '',
        \ 'cmd' : '',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : {
        \ 'name' : 'M-1..M-9',
        \ 'pos' : [[1,4], [6,9]],
        \ 'handles' : [
        \ ["\<M-1>" , 'call call(' . string(s:_function('s:swap_buffer_with_nth_win')) . ', [1])'],
        \ ["\<M-2>" , 'call call(' . string(s:_function('s:swap_buffer_with_nth_win')) . ', [2])'],
        \ ["\<M-3>" , 'call call(' . string(s:_function('s:swap_buffer_with_nth_win')) . ', [3])'],
        \ ["\<M-4>" , 'call call(' . string(s:_function('s:swap_buffer_with_nth_win')) . ', [4])'],
        \ ["\<M-5>" , 'call call(' . string(s:_function('s:swap_buffer_with_nth_win')) . ', [5])'],
        \ ["\<M-6>" , 'call call(' . string(s:_function('s:swap_buffer_with_nth_win')) . ', [6])'],
        \ ["\<M-7>" , 'call call(' . string(s:_function('s:swap_buffer_with_nth_win')) . ', [7])'],
        \ ["\<M-8>" , 'call call(' . string(s:_function('s:swap_buffer_with_nth_win')) . ', [8])'],
        \ ["\<M-9>" , 'call call(' . string(s:_function('s:swap_buffer_with_nth_win')) . ', [9])'],
        \ ],
        \ },
        \ 'desc' : 'swap buffer with nth window',
        \ 'func' : '',
        \ 'cmd' : '',
        \ 'exit' : 0,
        \ },
        \ ],
        \ 'right' : [
        \ {
        \ 'key' : 'n',
        \ 'desc' : 'next buffer',
        \ 'func' : '',
        \ 'cmd' : 'bnext',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : ['N', 'p'],
        \ 'desc' : 'previous buffer',
        \ 'func' : '',
        \ 'cmd' : 'bp',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : 'd',
        \ 'desc' : 'kill buffer',
        \ 'func' : '',
        \ 'cmd' : 'call SpaceVim#mapping#close_current_buffer()',
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
endfunction " }}}

function! s:commentOperator(type, ...) abort
  let sel_save = &selection
  let &selection = 'inclusive'
  let reg_save = @@

  if a:0  " Invoked from Visual mode, use gv command.
    silent exe 'normal! gv'
    call feedkeys("\<Plug>NERDCommenterComment")
  elseif a:type ==# 'line'
    call feedkeys('`[V`]')
    call feedkeys("\<Plug>NERDCommenterComment")
  else
    call feedkeys('`[v`]')
    call feedkeys("\<Plug>NERDCommenterComment")
  endif

  let &selection = sel_save
  let @@ = reg_save
  set opfunc=
endfunction

function! s:comment_to_line(invert) abort
  let input = input('line number: ')
  if empty(input)
    return
  endif
  let line = str2nr(input)
  let ex = line - line('.')
  if ex > 0
    exe 'normal! V'. ex .'j'
  elseif ex == 0
  else
    exe 'normal! V'. abs(ex) .'k'
  endif
  if a:invert
    call feedkeys("\<Plug>NERDCommenterInvert")
  else
    call feedkeys("\<Plug>NERDCommenterComment")
  endif
endfunction

function! s:comment_paragraphs(invert) abort
  if a:invert
    call feedkeys("vip\<Plug>NERDCommenterInvert")
  else
    call feedkeys("vip\<Plug>NERDCommenterComment")
  endif
endfunction

" this func only for neovim-qt in windows
function! s:restart_neovim_qt() abort
  call system('taskkill /f /t /im nvim.exe')
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
endif "}}}
"}}}

