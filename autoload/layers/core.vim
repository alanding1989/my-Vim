"=============================================================================
" core.vim --- core layer
" Section: layers
"=============================================================================
scriptencoding utf-8


function! layers#core#plugins() abort
  let plugins = [
        \ ['Shougo/unite.vim', {'merged': 0}],
        \ ]
  if g:is_win
    call add(plugins, ['Shougo/vimproc.vim', {'build' : '.\mingw32-make.exe', 'do': '.\mingw32-make.exe'}])
  else
    call add(plugins, ['Shougo/vimproc.vim', {'build' : [(executable('gmake') ? 'gmake' : 'make')],
          \ 'do': (executable('gmake') ? 'gmake' : 'make')}])
  endif
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

  if !g:is_spacevim
    let g:matchup_matchparen_status_offscreen = 0
    nnoremap <space>be  :call <sid>safe_erase_buffer()<CR>
    nnoremap <space>br  :call <sid>safe_revert_buffer()<CR>
    nnoremap <space>bm  :call <sid>open_message_buffer()<CR>
    nnoremap <space>b.  :call <sid>buffer_transient_state()<CR>

    nnoremap <space>n=  :call <sid>number_transient_state('+')<CR>
    nnoremap <space>n-  :call <sid>number_transient_state('-')<CR>

    nnoremap <space>jn  i<cr><esc>
    nnoremap <space>jo  i<cr><esc>k$
    nnoremap <space>js  :call <sid>split_string(0)<CR>i
    nnoremap <space>jS  :call <sid>split_string(1)<CR>

    nnoremap <space>ju  :call <sid>jump_to_url()<CR>

    nnoremap <space>ps  :Grepper<CR>
  else
    exec 'so '.g:vim_plugindir.'unite.vim'
    unlet g:_spacevim_mappings_space.b.R
    call SpaceVim#mapping#space#def('nnoremap', ['b', 'r'], 'call call('
          \ . string(s:_function('s:safe_revert_buffer')) . ', [])',
          \ 'safe-revert-buffer', 1)
  endif
endfunction


" plugin funcs {{{
function! s:filetree() abort
  if g:is_spacevim
    " a:num = 0 open root dir
    " a:num = 1 open last opened dir
    " a:num = 2 open buffer dir/root dir(VimEnter)
    " a:num = 3 open my src layout dir
    " a:num = 4 open current dir in fullscreen with more infor
    " a:num = 5 open my plugins bundle dir
    " a:num = 6 open my dotfile dir
    " a:num = 7 open a new defx buffer in current working dir
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
  else
    nnoremap <silent><F3>         :call <SID>open_filetree(0)<CR>
    nnoremap <silent><space>fo    :call <SID>open_filetree(1)<CR>
    nnoremap <silent><space><tab> :call <SID>open_filetree(2)<CR>
    nnoremap <silent><space>fa    :call <SID>open_filetree(3)<CR>
    nnoremap <silent><space>fi    :call <SID>open_filetree(4)<CR>
    nnoremap <silent><space>fp    :call <SID>open_filetree(5)<CR>
    nnoremap <silent><space>f.    :call <SID>open_filetree(6)<CR>
    nnoremap <silent><space>fn    :call <SID>open_filetree(7)<CR>
  endif
endfunction


function! s:comment() abort
  if g:is_spacevim
    call SpaceVim#mapping#space#def('nmap', ['c' , 'c'], '<Plug>NERDCommenterInvert' , '@ toggle comment lines', 0 )
    call SpaceVim#mapping#space#def('nmap', ['c' , 'C'], '<Plug>NERDCommenterComment', '@ comment lines'       , 0 )

  else
    " NOTE: below 3 shoudn`t be noremap
    map <space>cl <plug>NERDCommenterInvert
    map <space>cL <plug>NERDCommenterComment
    map <space>cc <plug>NERDCommenterInvert
    map <space>cC <plug>NERDCommenterComment

    map      <space>ct <plug>CommentToLineInvert
    map      <space>cp <plug>CommentParagraphsInvert
    map      <space>;  <plug>CommentOperator
    nnoremap <silent>  <Plug>CommentToLineInvert     : call <SID>comment_to_line(1)<Cr>
    nnoremap <silent>  <Plug>CommentParagraphsInvert : call <SID>comment_paragraphs(1)<Cr>
    nnoremap <silent>  <Plug>CommentOperator         : set opfunc=<SID>commentOperator<Cr>g@
  endif
endfunction


function! s:unimpaired() abort
  " Unimpaired bindings
  " ]e or [e move current line ,count can be useed
  nnoremap <silent> [a  :<c-u>execute 'move -1-'. v:count1<cr>
  nnoremap <silent> ]a  :<c-u>execute 'move +'. v:count1<cr>

  " [f or ]f go to next or previous file in dir
  nnoremap <silent> [f  :<c-u>call <SID>previous_file()<cr>
  nnoremap <silent> ]f  :<c-u>call <SID>next_file()<cr>

  " [l or ]l go to next and previous error(location list)
  nnoremap <silent> [l  :lprevious<cr>
  nnoremap <silent> ]l  :lnext<cr>

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
endfunction


function! s:flygrep() abort
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
    nnoremap<space>ss  :call SpaceVim#plugins#flygrep#open({'input': input("grep pattern:"), 'files': bufname("%")})<CR>
    nnoremap<space>sS  :call SpaceVim#plugins#flygrep#open({'input': expand("<cword>")     , 'files': bufname("%")})<CR>
    " Searching in all loaded buffers
    nnoremap<space>sb  :call SpaceVim#plugins#flygrep#open({'input': input("grep pattern:"), 'files': '@buffers'})<CR>
    nnoremap<space>sB  :call SpaceVim#plugins#flygrep#open({'input': expand("<cword>")     , 'files': '@buffers'})<CR>
    " Searching in buffer directory
    nnoremap<space>sd  :call SpaceVim#plugins#flygrep#open({'input': input("grep pattern:"), 'dir'  : fnamemodify(expand('%'), ':p:h')})<CR>
    nnoremap<space>sD  :call SpaceVim#plugins#flygrep#open({'input': expand("<cword>")     , 'dir'  : fnamemodify(expand('%'), ':p:h')})<CR>
    " Searching in files in an arbitrary directory
    nnoremap<space>sf  :call SpaceVim#plugins#flygrep#open({'input': input("grep pattern:"), 'dir'  : input("arbitrary dir:", '', 'dir')})<CR>
    nnoremap<space>sF  :call SpaceVim#plugins#flygrep#open({'input': expand("<cword>")     , 'dir'  : input("arbitrary dir:", '', 'dir')})<CR>
    " Searching in project
    nnoremap<space>sp  :call SpaceVim#plugins#flygrep#open({'input': input("grep pattern:"), 'dir'  : get(b:, "rootDir", getcwd())})<CR>
    nnoremap<space>sP  :call SpaceVim#plugins#flygrep#open({'input': expand("<cword>")     , 'dir'  : get(b:, "rootDir", getcwd())})<CR>
    " Searching background
    nnoremap<space>sj  :call SpaceVim#plugins#searcher#find(""                             , SpaceVim#mapping#search#default_tool()[0])<CR>
    nnoremap<space>sJ  :call SpaceVim#plugins#searcher#find(expand("<cword>")              , SpaceVim#mapping#search#default_tool()[0])<CR>
    nnoremap<space>sl  :call SpaceVim#plugins#searcher#list()<CR>
    " <space>s/
    nnoremap<space>so  :call SpaceVim#plugins#flygrep#open({})<CR>
  endif
endfunction


function! s:open_browser() abort
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
      auto FileType python, ipynb let g:_spacevim_mappings.o.p
            \ = ['call feedkeys(":OpenBrowserSmartSearch -python ")' , 'docs search /python']
      auto FileType scala let g:_spacevim_mappings.o.s
            \ = ["call feedkeys(':OpenlinkOrSearch scala ')"         , 'docs search /scala' ]
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

function! s:safe_erase_buffer() abort
  if s:MESSAGE.confirm('Erase content of buffer ' . expand('%:t'))
    normal! ggdG
  endif
  redraw!
endfunction

function! s:open_message_buffer() abort
  vertical topleft edit __Message_Buffer__
  setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nowrap cursorline nospell nonumber norelativenumber
  setf message
  normal! ggdG
  silent put =s:CMP.execute(':message')
  normal! G
  setlocal nomodifiable
  nnoremap <silent> <buffer> q :silent bd<CR>
endfunction

function! s:safe_revert_buffer() abort
  if s:MESSAGE.confirm('Revert buffer form ' . expand('%:p'))
    edit!
  endif
  redraw!
endfunction

function! s:delete_current_buffer_file() abort
  if s:MESSAGE.confirm('Are you sure you want to delete this file')
    let f = expand('%')
    if delete(f) == 0
      call SpaceVim#mapping#close_current_buffer()
      echo "File '" . f . "' successfully deleted!"
    else
      call s:MESSAGE.warn('Failed to delete file:' . f)
    endif
  endif
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

function! s:buffer_transient_state() abort
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
endfunction

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


" a:num = 0 open root dir
" a:num = 1 open last opened dir
" a:num = 2 open current buffer dir/root dir(when VimEnter)
" a:num = 3 open my vimrc favourite dir
" a:num = 4 open current working dir in fullscreen with more infor
" a:num = 5 open my plugins bundle dir
" a:num = 6 open my dotfile dir
" a:num = 7 open a new defx buffer in current working dir
let g:_my_vimrc_dir   = g:home
let g:_my_dotfile_dir = g:is_win ? 'E:\my-Dotfile' : '/mnt/fun+downloads/my-Dotfile'
if get(g:, 'spacevim_filemanager', get(g:, 'filemanager', 'vimfiler')) ==# 'vimfiler'

  function! s:open_filetree(num) abort "{{{
    if a:num == 0
      exec 'VimFiler '.getcwd()
    elseif a:num == 1
      VimFiler
    elseif a:num == 2
      VimFilerBufferDir
    elseif a:num == 3
      exec 'VimFiler '.expand(g:_my_vimrc_dir)
    elseif a:num == 4
      let g:_spacevim_autoclose_filetree = 0
      VimFilerCurrentDir -no-split -columns=type:size:time
      let g:_spacevim_autoclose_filetree = 1
    elseif a:num == 5
      call <sid>open_plugins_dir('VimFiler ')
    elseif a:num == 6
      exec 'VimFiler '.expand(g:_my_dotfile_dir)
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
      Defx `expand(g:_my_vimrc_dir)`
    elseif a:num == 4
      let g:_spacevim_autoclose_filetree = 0
      Defx -split=no -columns=git:mark:indent:filename:type:size:time `getcwd()`
      let g:_spacevim_autoclose_filetree = 1
    elseif a:num == 5
      call <sid>open_plugins_dir('Defx ')
    elseif a:num == 6
      Defx `expand(g:_my_dotfile_dir)`
    elseif a:num == 7
      Defx -new `getcwd()`
    endif
    if &ft ==# 'defx' | setl conceallevel=3 | endif
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
      exec 'NERDTree '.expand(g:_my_vimrc_dir)
    elseif a:num == 4
      exec 'e '.getcwd()
    elseif a:num == 5
      call <sid>open_plugins_dir('NERDTree ')
    elseif a:num == 6
      exec 'NERDTree '.expand(g:_my_dotfile_dir)
    endif
    doautocmd WinEnter
  endfunction "}}}
endif
function! s:open_plugins_dir(cmd) abort "{{{
  let temp = @a | let @a=''
  norm! mz"ayi'
  norm! `z
  if exists('#dein')
    if g:is_spacevim
      let g:alan = 1
      if glob(g:spacevim_plugin_bundle_dir.'repos/github.com/'.@a) !=# ''
        exec a:cmd . g:spacevim_plugin_bundle_dir.'repos/github.com/'.@a
      endif
    else
      if glob(g:My_Vim_plug_dir.'repos/github.com/'.@a) !=# ''
        exec a:cmd . g:My_Vim_plug_dir.'repos/github.com/'.@a
      endif
    endif
  else
    if g:is_spacevim
      if glob(g:spacevim_plugin_bundle_dir.'repos/github.com/'.@a) !=# ''
        exec a:cmd . g:spacevim_plugin_bundle_dir . split(@a, '/')[1]
      endif
    else
      if glob(g:My_Vim_plug_dir.'repos/github.com/'.@a) !=# ''
        exec a:cmd . g:My_Vim_plug_dir . split(@a, '/')[1]
      endif
    endif
  endif
  let @a = temp
endfunction "}}}
