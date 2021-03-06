"=============================================================================
" mapping/basic.vim --- default keymap
" Section mappings
"=============================================================================
scriptencoding utf-8


function! mapping#basic#load() abort
  let g:mapleader      = ';'
  let g:maplocalleader = "\<Space>"
  set timeout
  set timeoutlen=400
  call <sid>DefinePlug()
  call mapping#delimitor#init()
  auto VimEnter * call s:unmap_SPC()

  " mode mapping {{{
  noremap  <C-a>            ^
  noremap  <C-e>            $
  noremap  <C-q>            :

  nnoremap  -               q
  nnoremap  --              @a
  nnoremap  s               <nop>
  nnoremap  q               <nop>
  nnoremap  ,               <Space>l
  nnoremap <silent>\        :nohl<CR>:redraw<CR>
  " NOTE: below 4 used in edgemotion, tmux-navigate
  nnoremap <C-k>            <C-w>k
  nnoremap <C-j>            <C-w>j
  nnoremap <C-h>            <C-w>h
  nnoremap <C-l>            <C-w>l

  " insert mode
  inoremap <nowait>\        \
  inoremap <expr><C-j>      pumvisible() ? "\<C-n>" : "\<down>"
  inoremap <expr><C-k>      pumvisible() ? "\<C-p>" : "\<up>"
  inoremap <expr><C-e>      pumvisible() ? (!g:has_py ? asyncomplete#cancel_popup() : "\<C-e>") : "\<End>"
  inoremap <C-a>            <Esc>^i
  inoremap <C-b>            <left>
  inoremap <C-f>            <right>
  inoremap <C-l>            <right>
  inoremap <C-p>            <C-left>
  inoremap <C-n>            <C-right>
  inoremap <expr><C-h>      pumvisible() ? "\<C-e><BS>" : DelEmptyPair()
  inoremap <C-d>            <Del>
  inoremap <C-q>            <Esc>lC
  inoremap <C-u>            <C-g>u<C-u>
  inoremap <C-z>            <Esc>ua
  inoremap <C-v>            <Esc><C-r>a
  inoremap <C-_>            <C-k>
  inoremap <M-j>            <CR>
  inoremap <expr><M-k>      col('.') <= col('$') ? "\<Esc>lc$"  : "\<Esc>lce"
  inoremap <M-d>            <Esc>lce
  inoremap <M-b>            <C-left>
  inoremap <M-f>            <C-right>

  map  <expr> <BS>          exists('loaded_matchup') ? "\<Plug>(matchup-%)"  : "\<BS>"
  xmap <expr>i<BS>          exists('loaded_matchup') ? "\<Plug>(matchup-i%)" : "\<BS>"
  omap <expr>i<BS>          exists('loaded_matchup') ? "\<Plug>(matchup-i%)" : "\<BS>"
  xmap <expr>a<BS>          exists('loaded_matchup') ? "\<Plug>(matchup-a%)" : "\<BS>"
  omap <expr>a<BS>          exists('loaded_matchup') ? "\<Plug>(matchup-a%)" : "\<BS>"

  " command line mode
  cnoremap qw               <Esc>
  cnoremap <C-h>            <BS>
  cnoremap <expr><C-j>      pumvisible() ? "\<C-n>" : "\<down>"
  cnoremap <expr><C-k>      pumvisible() ? "\<C-p>" : "\<up>"
  cnoremap <C-b>            <left>
  cnoremap <C-f>            <right>
  cnoremap <C-l>            <right>
  cnoremap <M-b>            <C-left>
  cnoremap <M-f>            <C-right>
  cnoremap <C-a>            <Home>
  cnoremap <C-e>            <End>
  cnoremap <C-d>            <Del>
  cnoremap <C-_>            <C-k>
  cnoremap <C-v>            <C-r>=expand('%:p:h') <CR>

  " terminal mode
  tnoremap <Esc>            <C-\><C-n>
  tnoremap <M-tab>          <C-\><C-n>:b#<CR>

  " fast save
  inoremap qw               <Esc>:w<CR>
  nnoremap qw               :w<CR>
  nnoremap <C-s>            :w<CR>
  inoremap <C-s>            <C-o>:w<CR>
  nnoremap qwe              :wall<CR>
  nnoremap qww              :w !sudo tee % >/dev/null<CR>
  nnoremap qld              :call feedkeys(':saveas '.expand(expand('%:p:h').'/'))<CR>
  nnoremap qla              :call feedkeys(':saveas ')<CR>
  "}}}

  " window and buffer management {{{
  nnoremap <silent>qq       :call <sid>close_current_window()<CR>
  nnoremap <silent>qk       :call <sid>choose_close_win()<CR>
  nnoremap <silent>qn       :call <sid>close_win_or_kill_buffer('next')<CR>
  nnoremap <silent>qp       :call <sid>close_win_or_kill_buffer('prev')<CR>
  nnoremap <silent>qo       :only<CR>
  nnoremap <silent>qh       :q<CR>
  nnoremap <silent>qkk      :q!<CR>
  nnoremap <silent>qd       :try\|bd\|catch\|endtry<CR>
  " nnoremap <silent>qd       :close<CR>
  nnoremap <silent>qb       :call <sid>killotherBuffers()<CR>
  nnoremap <silent>qf       :call <sid>delete_current_buffer_file()<CR>
  nnoremap <silent>qe       :call <sid>safe_erase_buffer()<CR>
  nnoremap <silent>qr       :call <sid>rename_file()<CR>
  nnoremap <silent>quu      :call <sid>safe_revert_buffer()<CR>

  nnoremap <silent>so       :call feedkeys(':vs ')<CR>
  nnoremap <silent>sv       :vs<CR><C-w>w
  nnoremap <silent>ss       :sp<CR><C-w>w
  nnoremap <silent>sp       :vs +bp<CR>
  nnoremap <silent>s[       :sp +bp<CR>
  nnoremap <silent>sn       :vs +bn<CR>
  nnoremap <silent>s]       :sp +bn<CR>
  nnoremap <silent>sb       :b#<CR>
  nnoremap <silent>si       <C-w>x<C-w>w
  nnoremap <silent>s-       <C-w>K
  nnoremap <silent>s\       <C-w>L
  nnoremap <silent>sm       :res\|vert res<CR>zz
  nnoremap <silent>s=       :winc =<CR>
  nnoremap <silent>st       :tabnew<CR>
  nnoremap <silent>s3       :vs\|vs\|<CR>
  nnoremap <silent>s0       :vert rightb new<CR>
  " last edit buffer
  nnoremap <silent><leader><tab>  :b#<CR>
  nnoremap <silent><M-tab>  :res\|vert res<CR>zz

  " hotkey for buf and tab selection, no need plugins {{{
  " select window
  nnoremap <silent><Space>1       :call Winjump(1)<CR>
  nnoremap <silent><Space>2       :call Winjump(2)<CR>
  nnoremap <silent><Space>3       :call Winjump(3)<CR>
  nnoremap <silent><Space>4       :call Winjump(4)<CR>
  nnoremap <silent><Space>5       :call Winjump(5)<CR>
  nnoremap <silent><Space>6       :call Winjump(6)<CR>
  nnoremap <silent><Space>7       :call Winjump(7)<CR>
  nnoremap <silent><Space>8       :call Winjump(8)<CR>
  " select tabline
  nnoremap <silent>sh             :call Tabjump("prev")<CR>
  nnoremap <silent>sl             :call Tabjump("next")<CR>
  nnoremap <silent><tab>h         :call Tabjump("prev")<CR>
  nnoremap <silent><tab>l         :call Tabjump("next")<CR>
  nnoremap <silent><leader>1      :call Tabjump(1)<CR>
  nnoremap <silent><leader>2      :call Tabjump(2)<CR>
  nnoremap <silent><leader>3      :call Tabjump(3)<CR>
  nnoremap <silent><leader>4      :call Tabjump(4)<CR>
  nnoremap <silent><leader>5      :call Tabjump(5)<CR>
  nnoremap <silent><leader>6      :call Tabjump(6)<CR>
  nnoremap <silent><leader>7      :call Tabjump(7)<CR>
  nnoremap <silent><leader>8      :call Tabjump(8)<CR>
  nnoremap <silent><leader>9      :call Tabjump(9)<CR>
  " }}}

  " inc/decrease buffer width/height
  nnoremap <silent> <M-[>         :10winc <<CR>
  nnoremap <silent> <M-]>         :10winc ><CR>
  nnoremap <silent> <M-->         :10winc -<CR>
  nnoremap <silent> <M-=>         :10winc +<CR>

  " improve window scroll
  auto VimEnter * noremap
        \  <expr> zz              <sid>win_scroll(1, 'z')
  nnoremap <expr> <C-f>           <sid>win_scroll(1, 'f')
  nnoremap <expr> <C-b>           <sid>win_scroll(0, 'f')
  nnoremap <expr> <C-d>           <sid>win_scroll(1, 'd')
  nnoremap <expr> <C-u>           <sid>win_scroll(0, 'd')
  nnoremap <expr> i               winline() != winheight(0) ? "zzi" : "i"
  nnoremap <expr> a               winline() != winheight(0) ? "zza" : "a"

  " improve fold mapping
  auto VimEnter *
        \ nnoremap zj  zjzz |
        \ nnoremap zk  zkzz
  nnoremap <expr> l               foldclosed('.') > -1 ? 'zazz' : 'l'
  nnoremap <expr> <CR>            <sid>OpenFoldOrGotoMiddle(1)
  nnoremap <expr> s<CR>           <sid>OpenFoldOrGotoMiddle(0)

  " Toggle zz mode
  nnoremap <silent><leader>az     :call <sid>Toggle_ZZMode()<CR>
  " }}}

  " edit related {{{
  " insert new line
  nnoremap <tab>o                 o<Esc>
  nnoremap <tab>p                 O<Esc>j
  " inset empty box
  nnoremap <silent><Space>iem     :call <sid>MinusBox()<CR>
  nnoremap <silent><Space>iee     :call <sid>EqualBox()<CR>
  " insert file head
  nnoremap <silent><Space>ihn     :call <sid>SetFileHead()<CR>
  nnoremap <silent><Space>ihe     :call <sid>SetFileHead('info1')<CR>
  nnoremap <silent><Space>ihh     :call <sid>SetFileHead('info0')<CR>
  " insert current file absPath
  nnoremap <leader>ap             i<C-r>=expand('%:p')<CR><Esc>

  " indenting in visual mode
  xnoremap >                      >gv|
  xnoremap <                      <gv
  xnoremap <C-l>                  >gv|
  xnoremap <C-h>                  <gv
  " select blocks after indenting
  nnoremap >                      >>_
  nnoremap <                      <<_

  " format
  nnoremap <silent>g=             :call <sid>format()<CR>
  " Remove trailing Spaces
  nnoremap <silent>d<Space>       :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

  " Select
  noremap  vv                     V
  nnoremap <leader>aa             ggVG
  nnoremap <leader>af             VG
  " Easier search and replace
  xnoremap <C-r>                  :<C-u>call <sid>VSetSearch()<CR>:,$s/<C-R>=@/<CR>//gc<left><left><left>
  xnoremap <C-s>                  :s///g<left><left><left><CR>

  " Select last paste
  nnoremap <expr> g1              '`['.strpart(getregtype(), 0, 1).'`]'


  " yank and paste {{{
  if has('unnamedplus')
    nnoremap <leader>y            :call <sid>EasyCopy_inPairs()<CR>
    xnoremap <leader>y            "+y
    xnoremap <leader>d            "+d
    " lower case paste below
    nnoremap <leader>p            "+p
    xnoremap <leader>p            "+p
    " upper case paste above
    nnoremap <leader>P            "+P
    xnoremap <leader>P            "+P
  else
    nnoremap <leader>y            :call <sid>EasyCopy_inPairs()<CR>
    xnoremap <leader>y            "*y
    xnoremap <leader>d            "*d
    " lower case paste below
    nnoremap <leader>p            "*p
    xnoremap <leader>p            "*p
    " upper case paste above
    nnoremap <leader>P            "*P
    xnoremap <leader>P            "*P
  endif

  " !a:0, Copy buffer absolute path to X11 clipboard
  " 2,    Copy current line of file`s github url to clipboard
  " 3,    Copy select lines of file`s github url to clipboard
  nnoremap <silent><C-c>          :call <sid>CopyToClipboard()<CR>
  nnoremap <silent><M-g>          :call <sid>CopyToClipboard(2)<CR>
  xnoremap <silent><C-c>          :<C-u>call <sid>CopyToClipboard(3)<CR>
  " }}}
  " }}}

  " misc {{{
  " quickfix list movement
  nnoremap <silent><leader>qn     :cnext<CR>
  nnoremap <silent><leader>qp     :cprev<CR>
  nnoremap <silent><leader>ql     :copen<CR>
  nnoremap <silent><leader>qc     :call setqflist([])<CR>

  " help
  nnoremap <expr><F1>             &ft ==# 'vim' ? ":update\<CR>:source %<CR>"
                                  \ : !&modified ? ":e\<CR>" : "\<F1>"
  nnoremap <silent>K              :call util#help_wrapper()<CR>
  nnoremap <Space>hh              :call feedkeys(':EchoHelp ')<CR>
  " show full path
  nnoremap <C-g>                  2<C-g>
  " echo prefix
  nnoremap <leader>ee             :call feedkeys(':echo ')<CR>
  " call function
  nnoremap <leader>ef             :call feedkeys(':call ')<CR>
  " show syntax summary
  nnoremap <leader>eg             :syntax<CR>
  " highlight
  nnoremap <leader>eh             :call feedkeys(':EchoHlight ')<CR>
  " show plugin installed or not
  nnoremap <leader>eh             :call feedkeys(':CheckInstall ')<CR>
  " maparp
  noremap  <leader>em             :call feedkeys(':EchoMap ')<CR>
  " set options
  noremap  <leader>eo             :call feedkeys(':set ')<CR>
  " show version
  nnoremap <leader>ev             :version<CR>
  " echo last paste, selected must be expr, also can execute selected
  xnoremap <leader>er             "ry:<C-u>try\|echo <C-r>=@r<CR>\|catch\|endtry<CR>

  " directory operatios
  nnoremap <leader>db             :lcd %:p:h<CR>
  nnoremap <leader>dd             :call feedkeys(':lcd ')<CR>
  nnoremap <leader>dw             :lcd<CR>
  nnoremap <leader>dp             :pwd<CR>

  " g related
  auto VimEnter *
        \ nnoremap g0             g*|
        \ nnoremap g9             gf

  if has('nvim')
    nnoremap <Space>qh            :checkhealth<CR>
  endif
  " }}}

  " Open config files {{{
  nnoremap <leader>aci            :vs ~/.SpaceVim.d/init.vim<CR>
  nnoremap <leader>acr            :vs ~/.SpaceVim.d/vimrc<CR>
  nnoremap <leader>acf            :vs ~/.SpaceVim.d/config/functions.vim<CR>
  nnoremap <leader>acg            :vs ~/.SpaceVim.d/config/general.vim<CR>
  nnoremap <leader>ach            :vs ~/.SpaceVim.d/config/highlight.vim<CR>
  nnoremap <leader>aco            :vs ~/.SpaceVim.d/config/option.vim<CR>
  nnoremap <leader>acb            :vs ~/.SpaceVim.d/autoload/mapping/basic.vim<CR>
  nnoremap <leader>acd            :vs ~/.SpaceVim.d/autoload/default.vim<CR>
  if !g:has_py
    nnoremap <leader>acm          :exec 'Unite file_rec/'.(has('nvim') ? 'neovim' : 'async').' -path=~/.SpaceVim.d'<CR>
    nnoremap <leader>ac<Space>    :exec 'Unite file_rec/'.(has('nvim') ? 'neovim' : 'async').' -path=~/.SpaceVim'<CR>
  elseif len(glob(g:home.'init.toml')) && 0
    nnoremap <leader>acm          :Denite file/rec -path=~/.SpaceVim.d<CR>
    nnoremap <leader>ac<Space>    :Denite file/rec -path=~/.SpaceVim<CR>
  else
    nnoremap <leader>acm          :LeaderfFile ~/.SpaceVim.d<CR>
    nnoremap <leader>ac<Space>    :LeaderfFile ~/.SpaceVim<CR>
  endif
  if g:is_spacevim
    nnoremap <leader>aca          :vs ~/.SpaceVim.d/autoload/MySpaceVim/Main.vim<CR>
    nnoremap <leader>acu          :vs ~/.SpaceVim.d/autoload/MyVim/Main.vim<CR>
    nnoremap <leader>acc          :vs ~/.SpaceVim.d/config/SpaceVim/config.vim<CR>
    nnoremap <leader>ack          :vs ~/.SpaceVim.d/config/SpaceVim/keymap.vim<CR>
    nnoremap <leader>acy          :vs ~/.SpaceVim.d/config/Vim/option.vim<CR>
    nnoremap <leader>acv          :vs ~/.SpaceVim.d/config/Vim/config.vim<CR>
    nnoremap <leader>acl          :vs ~/.SpaceVim.d/config/Vim/keymap.vim<CR>
    nnoremap <leader>acp          :vs ~/.SpaceVim.d/config/SpaceVim/plugins_before/
    nnoremap <leader>ac[          :vs ~/.SpaceVim.d/config/Vim/plugins/
    nnoremap <leader>ace          :vs ~/.SpaceVim.d/autoload/MySpaceVim/bootstrap.vim<CR>
  elseif !g:is_spacevim
    nnoremap <leader>aca          :vs ~/.SpaceVim.d/autoload/MyVim/Main.vim<CR>
    nnoremap <leader>acu          :vs ~/.SpaceVim.d/autoload/MySpaceVim/Main.vim<CR>
    nnoremap <leader>acc          :vs ~/.SpaceVim.d/config/Vim/config.vim<CR>
    nnoremap <leader>ack          :vs ~/.SpaceVim.d/config/Vim/keymap.vim<CR>
    nnoremap <leader>acy          :vs ~/.SpaceVim.d/config/SpaceVim/option.vim<CR>
    nnoremap <leader>acv          :vs ~/.SpaceVim.d/config/SpaceVim/config.vim<CR>
    nnoremap <leader>acl          :vs ~/.SpaceVim.d/config/SpaceVim/keymap.vim<CR>
    nnoremap <leader>acp          :vs ~/.SpaceVim.d/config/Vim/plugins/
    nnoremap <leader>ac[          :vs ~/.SpaceVim.d/config/SpaceVim/plugins_before/
  endif
  let g:Lf_CacheDirectory = expand('~/.cache')
  "}}}
endfunction


" Window Manipulate {{{
" Kill next or previous window or buffer {{{
function! s:close_win_or_kill_buffer(num) abort
  if winnr('$') > 1
    try
      if a:num ==# 'next'
        exec 'close ' . (winnr() + 1)
      elseif a:num ==# 'prev'
        exec 'close ' . (winnr() - 1)
      endif
    catch  /^Vim\%((\a\+)\)\=:E939/
      return
    endtry
  else
    call s:kill_buffer(a:num)
  endif
endfunction

" Kill next or previous buffer {{{
function! s:kill_buffer(num) abort
  " collect all buffers
  let ls = split(execute(':ls'), "\n")
  let buffers = []
  for b in ls
    let nr = str2nr(matchstr(b, '\d\+'))
    call add(buffers, nr)
  endfor

  let c_bufnr = bufnr('%')
  let c_bufidx = index(buffers, c_bufnr)

  if a:num ==# 'next'
    let handle_bufidx = c_bufidx + 1
  elseif a:num ==# 'prev'
    let handle_bufidx = c_bufidx - 1
  endif

  if len(buffers) == 1 
    call util#echohl(' Only one buffer exists!') 
    return
  endif

  try
    " throw : out of index 
    let handle_bufnr = buffers[handle_bufidx]

    if getbufvar(handle_bufnr, '&modified', 0)
      call util#echohl(' Buffer has been modified, please check by yourself!')
      exec 'buffer ' . handle_bufnr
      return 
    endif
    
    exec 'bdelete ' . handle_bufnr | redraw
  catch
    call util#echohl(' No ' . a:num . ' buffer !')
  endtry
endfunction
" }}}

" Open fold or goto line middle {{{
function! s:OpenFoldOrGotoMiddle(mode) abort
  if &ft ==# 'qf'
    return "\<CR>\<C-w>p\<C-w>q"
  endif
  if a:mode
    return foldclosed('.') > -1 ? 'zazz' : (
          \ col('.') + 1 >= col('$') || col('.') == (winwidth(0) - 4)/2 )
          \ ? 'zazz' : 'gmzz'
  else
    return foldclosed('.') > -1 ? 'zMzazz' : (
          \ col('.') + 1 >= col('$') || col('.') == (winwidth(0) - 4)/2 )
          \ ? 'zMzazz' : 'gmzz'
  endif
endfunction " }}}

" Close Window {{{
" close current window or popup window
" mapping qq
function! s:close_current_window() abort
  let winnr = 0
  for i in range(1, winnr('$'))
    if getwinvar(i, '&ft') ==# 'diff'
          \ || match(getwinvar(i, 'netrw_prvfile'), 'coc.*document') > -1
          \ || match(getwinvar(i, 'netrw_prvfile'), '__runner__') > -1
          \ || len(getwinvar(i, 'quickfix_title'))
      let winnr = i
    endif
  endfor
  let key = "\<C-w>c"
  if winnr
    exe 'normal! '. winnr. key
  else
    exe 'normal! '. key
  endif
endfunction "}}}

" Choose Close Window {{{
function! s:choose_close_win() abort
  let cwinnr = winnr()
  if exists(':ChooseWin')
    ChooseWin
    exec 'winc c|'.cwinnr.'winc w'
  else
    call util#echohl('Please input window number: ')
    let twinnr = nr2char(getchar())
    exec twinnr.'winc w|winc c|'.cwinnr.'winc w'
    redraw | echo ''
  endif
endfunction  " }}}

" Window Scroll {{{
function! s:win_scroll(forward, mode)
  " args: forward : 1, 0
  "       mode    : f half screen, d several lines
  let winnr = 0
  for i in range(1, winnr('$'))
    if getwinvar(i, 'float') || getwinvar(i, '$previewwindow')
          \ || match(getwinvar(i, 'netrw_prvfile'), '__LanguageClient__') > -1
          \ || match(getwinvar(i, 'netrw_prvfile'), 'coc.*document') > -1
      let winnr = i
    endif
  endfor

  if a:forward && a:mode ==# 'f'
    let key = max([winheight(0) - 2, 1]) ."\<C-d>".(line('w$') >= line('$') ? 'L' : 'M')
  elseif !a:forward && a:mode ==# 'f'
    let key = max([winheight(0) - 2, 1]) ."\<C-u>".(line('w0') <= 1 ? 'H' : 'M')
  elseif a:forward && a:mode ==# 'd'
    let key = (line('w$') >= line('$') ? 'j' : "3\<C-e>")
  elseif !a:forward && a:mode ==# 'd'
    let key = (line('w0') <= 1         ? 'k' : "3\<C-y>")
  elseif a:forward && a:mode ==# 'z'
    let key = (winline() == (winheight(0)+1) / 2) ? 'zt' : (winline() == &scrolloff + 1) ? 'zb' : 'zz'
  endif
  if winnr
    return winnr."\<C-w>w\<C-w>K".'zngg'.key."\<C-w>p"
    " return winnr."\<C-w>w".'zn'.key."\<C-w>p"
  else
    return key
  endif
endfunction "}}}

" Toggle zzmode {{{
let s:zzmode = 0
function! s:Toggle_ZZMode() abort
  if s:zzmode == 0
    set scrolloff=999
    echo '  ZZMode now is on!'
    let s:zzmode = 1
  else
    set scrolloff=2
    echo '  ZZMode now is off!'
    let s:zzmode = 0
  endif
endfunction
" }}}
" }}}

" Buffer Manipulate {{{ 
" Rename File {{{
function! s:rename_file() abort
  let save_cursor = getpos('.')
  let curbufnr = bufnr('%')
  try
    let newn = input({
          \ 'prompt'  : 'New name: ',
          \ 'default' : expand('%:p'). ' -> '. expand('%:p'),
          \ 'completion' : 'file',
          \ 'cancelreturn' : 1})
    if newn == 1 | return | endif
  catch
    let newn = input(
          \ 'New name/Cancel(n): ',
          \ expand('%:p').' -> '. expand('%:p'),
          \ 'file'
          \ )
    if newn ==# 'n' | return | endif
  endtry
  if glob(newn) !=# ''
    call util#echohl(' The file already exists !', 'n')
    return
  endif
  if rename(expand('%'), newn) == 0
    call util#echohl(' Sucessfully rename file !', 'n')
  endif
  exec 'e ' newn
  exec 'bd' curbufnr
  call setpos('.', save_cursor)
endfunction " }}}

" Delete Current Buffer File {{{
function! s:delete_current_buffer_file() abort
  if s:MESSAGE.confirm('Are you sure you want to delete this file')
    let f = expand('%')
    if delete(f) == 0
      call <sid>close_current_buffer('n')
      echo "File '" . f . "' successfully deleted!"
    else
      call s:MESSAGE.warn('Failed to delete file:' . f)
    endif
  endif
endfunction
function! s:close_current_buffer(...) abort " {{{
  let buffers = s:BUFFER.listed_buffers()
  let bn = bufnr('%')
  let f = ''
  if getbufvar(bn, '&modified', 0)
    redraw
    echohl WarningMsg
    if len(a:000) > 0
      let rs = get(a:000, 0)
    else
      echon 'save changes to "' . bufname(bn) . '"?  Yes/No/Cancel'
      let rs = nr2char(getchar())
    endif
    echohl None
    if rs ==? 'y'
      write
    elseif rs ==? 'n'
      let f = '!'
      redraw
      echohl ModeMsg
      echon 'discarded!'
      echohl None
    else
      redraw
      echohl ModeMsg
      echon 'canceled!'
      echohl None
      return
    endif
  endif

  if &buftype ==# 'terminal'
    exe 'bd!'
    return
  endif

  let cmd_close_buf = 'bd' . f
  let index = index(buffers, bn)
  if index != -1
    if index == 0
      if len(buffers) > 1
        exe 'b' . buffers[1]
        exe cmd_close_buf . bn
      else
        exe cmd_close_buf . bn
      endif
    elseif index > 0
      if index + 1 == len(buffers)
        exe 'b' . buffers[index - 1]
        exe cmd_close_buf . bn
      else
        exe 'b' . buffers[index + 1]
        exe cmd_close_buf . bn
      endif
    endif
  endif
endfunction " }}}
" }}}

" Kill other Buffers {{{
function! s:killotherBuffers() abort
  if confirm('Kill all other buffers?', "&Yes\n&No\n&Cancel") == 1
    let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    for i in blisted
      if i != bufnr('%')
        try
          exe 'bw ' . i
        catch
        endtry
      endif
    endfor
  endif
endfunction
" }}}

" Safe Erase Buffer {{{
let s:MESSAGE = SpaceVim#api#import('vim#message')
let s:BUFFER  = SpaceVim#api#import('vim#buffer')
function! s:safe_erase_buffer() abort
  if s:MESSAGE.confirm('Erase content of buffer ' . expand('%:t'))
    normal! ggtdG
  else
    echo 'canceled!'
  endif
endfunction " }}}

" Safe Reload Buffer File from Disk {{{
function! <sid>safe_revert_buffer() abort
  if s:MESSAGE.confirm('Revert buffer form ' . expand('%:p'))
    edit!
  endif
  redraw!
endfunction " }}}
"}}}

" Easy Edit {{{
" insert nice box " {{{
let s:cmsign = {
      \ 'vim'      : '"',
      \ 'sh'       : '#',
      \ 'python'   : '#',
      \ 'ps1'      : '#',
      \ 'cpp'      : '//',
      \ 'c'        : '//',
      \ 'java'     : '//',
      \ 'scala'    : '//',
      \ 'go'       : '//',
      \ 'rust'     : '//',
      \ 'markdown' : '',
      \ }
function! <sid>EqualBox() abort
  call s:inshbox(s:cmsign[&ft], '=')
endfunc
function! <sid>MinusBox() abort
  call s:inshbox(s:cmsign[&ft], '-')
endfunc
function! s:inshbox(cmsign, reptsign) abort
  let head = !MatchCl('^$') ? ['', ''] : []
  let head += [
        \ a:cmsign. repeat(a:reptsign, 80),
        \ a:cmsign,
        \ a:cmsign. repeat(a:reptsign, 80),
        \ '',
        \ ]
  call append(line('.'), head)
  call setpos('.', [0, line('.')+len(head)-2, 2])
  call feedkeys("a\<Space>")
endfun
"}}}

" insert file head {{{
let s:dict = {
      \ ''       : ['"', 'scriptencoding utf-8'                                 ],
      \ 'vim'    : ['"', 'scriptencoding utf-8'                                 ],
      \ 'sh'     : ['#', '#! /usr/bin/env bash'                                 ],
      \ 'ps1'    : ['#', ''                                                     ],
      \ 'python' : ['#', '#! /usr/bin/env python3', '# -*- coding: utf-8 -*-'   ],
      \ 'ipynb'  : ['#', '#! /usr/bin/env python3', '# -*- coding: utf-8 -*-'   ],
      \ 'java'   : ['*', ''                       , '/*'                        ],
      \ 'scala'  : ['*', ''                       , '/*'                        ],
      \ 'c'      : ['*', '#include <stdio.h>'     , '/*'                        ],
      \ 'cpp'    : ['*', '#include <iostream>'    , 'using namespace std;', '/*'],
      \ 'text'   : ['*', ''                       , '/*'                        ],
      \ }
function! <sid>SetFileHead(...) abort
  " args: info = ''     , no headinfo
  "       info = 'info0', headinfo with no box surrounded
  "       info = 'info1', headinfo with == box surrounded
  let info = a:0 ? a:1 : ''

  let cmsign = s:dict[&ft][0]
  let list = add(s:dict[&ft][1:], info)
  call <sid>insfhead(cmsign, list)
endfunction
function! s:insfhead(cmsign, list) abort
  let head = []
  " file headinfo has box or not
  let hasEqual = 1 
  if &ft ==# 'vim'
    let head += <sid>insinfo(a:cmsign, hasEqual, a:list[-2])[:-2]
    let head += a:list[:-2] + ['']
  else
    let head += a:list[-2] ==# '/*' ? a:list[0:-3] : a:list[0:-2]
    let head += len(a:list[-1]) && a:list[0] !=# '' ? [''] : []

    let head += a:list[-1] ==# 'info0' ? <sid>insinfo(a:cmsign, !hasEqual, a:list[-2])
          \ :   a:list[-1] ==# 'info1' ? <sid>insinfo(a:cmsign, hasEqual , a:list[-2])
          \ :   ['', '']
  endif

  call append(0, head)
  call setpos('.', [0, len(head)+1, 1])
  startinsert
endfunction

function! s:insinfo(cmsign, hasEqual, ...) abort
  if a:0 && a:1 ==# '/*'
    let HEAD = a:hasEqual ? [
          \ '/*'. repeat('=', 80),
          \ ' ' . a:cmsign . ' File Name    : '. expand('%')    ,
          \ ' ' . a:cmsign . ' Author       : AlanDing'         ,
          \ ' ' . a:cmsign . ' Created Time : '. strftime('%c') ,
          \ ' ' . a:cmsign . ' Description  : '                 ,
          \ ] : [
          \ '/*'. a:cmsign ,
          \ ' ' . a:cmsign . ' File Name    : '. expand('%')   ,
          \ ' ' . a:cmsign . ' Author       : AlanDing'        ,
          \ ' ' . a:cmsign . ' Created Time : '. strftime('%c'),
          \ ' ' . a:cmsign . ' Description  : '                ,
          \ ]
    let HEAD += [
          \ (a:hasEqual ? repeat('=', 80).'*/': ' */'),
          \ ''
          \ ]
  else
    let HEAD = [
          \ a:hasEqual ? a:cmsign. repeat('=', 80) : ''  ,
          \ a:cmsign . ' File Name    : '. expand('%')   ,
          \ a:cmsign . ' Author       : AlanDing'        ,
          \ a:cmsign . ' Created Time : '. strftime('%c'),
          \ a:cmsign . ' Description  : '                ,
          \ a:hasEqual ? a:cmsign. repeat('=', 80) : ''  ,
          \ ''
          \ ]
  endif
  return HEAD
endfunction "}}}

" format {{{
function! s:format() abort
  let save_cursor = getpos('.')
  normal! gg=G
  call setpos('.', save_cursor)
endfunction " }}}

" copy buffer absolute path to X11 clipboard {{{
function! s:CopyToClipboard(...) abort
  if a:0
    if executable('git')
      let repo_home = fnamemodify(s:findDirInParent('.git', expand('%:p')), ':p:h:h')
      if repo_home !=# '' || !isdirectory(repo_home)
        let branch = split(systemlist('git -C '. repo_home. ' branch -a |grep "*"')[0],' ')[1]
        let remotes = filter(systemlist('git -C '. repo_home. ' remote -v'),"match(v:val,'^origin') >= 0 && match(v:val,'fetch') > 0")
        if len(remotes) > 0
          let remote = remotes[0]
          if stridx(remote, '@') > -1
            let repo_url = 'https://github.com/'. split(split(remote,' ')[0],':')[1]
            let repo_url = strpart(repo_url, 0, len(repo_url) - 4)
          else
            let repo_url = split(remote,' ')[0]
            let repo_url = strpart(repo_url, stridx(repo_url, 'http'),len(repo_url) - 4 - stridx(repo_url, 'http'))
          endif
          let f_url =repo_url. '/blob/'. branch. '/'. strpart(expand('%:p'), len(repo_home) + 1, len(expand('%:p')))
          if g:is_win
            let f_url = substitute(f_url, '\', '/', 'g')
          endif
          if a:1 == 2
            let current_line = line('.')
            let f_url .= '#L' . current_line
          elseif a:1 == 3
            let f_url .= '#L' . getpos("'<")[1] . '-L' . getpos("'>")[1]
          endif
          try
            let @+ = f_url
            echo 'Copied github url to clipboard'
          catch /^Vim\%((\a\+)\)\=:E354/
            if has('nvim')
              echohl WarningMsg | echom 'Cannot find clipboard, for more info see :h clipboard' | echohl None
            else
              echohl WarningMsg | echom 'You need to compile your vim with +clipboard feature' | echohl None
            endif
          endtry
        else
          echohl WarningMsg | echom 'This git repo has no remote host' | echohl None
        endif
      else
        echohl WarningMsg | echom 'This file is not in a git repo' | echohl None
      endif
    else
      echohl WarningMsg | echom 'You need to install git!' | echohl None
    endif
  else
    try
      let @+=expand('%:p')
      echo 'Copied file path to clipboard ' . @+
    catch /^Vim\%((\a\+)\)\=:E354/
      if has('nvim')
        echohl WarningMsg | echom 'Can not find clipboard, for more info see :h clipboard' | echohl None
      else
        echohl WarningMsg | echom 'You need to compile you vim with +clipboard feature' | echohl None
      endif
    endtry
  endif
endf
func! s:findFileInParent(what, where) abort
  let old_suffixesadd = &suffixesadd
  let &suffixesadd = ''
  let file = findfile(a:what, escape(a:where, ' ') . ';')
  let &suffixesadd = old_suffixesadd
  return file
endf
func! s:findDirInParent(what, where) abort
  let old_suffixesadd = &suffixesadd
  let &suffixesadd = ''
  let dir = finddir(a:what, escape(a:where, ' ') . ';')
  let &suffixesadd = old_suffixesadd
  return dir
endf " }}}

" copy text in pairs to system clipboard {{{
function! s:EasyCopy_inPairs() abort
  let within = Within('pair', 1)
  let reg = has('unnamedplus') ? '+' : '*'
  if within[0]
    try
      exec 'let @'.reg.' = ""'
      exec 'normal! mx"'.reg.'yi'. within[1]
      if len('@'.reg) > 1
        call util#echohl(' Yanked text in pairs to system clipboard!')
      endif
    catch
      call util#echohl(' Failed yank in pairs!')
    finally
      normal! `x
    endtry
  endif
endfunction " }}}

function! s:VSetSearch() abort " {{{
  let temp = @s
  normal! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction " }}}
" }}}


" Define Plugin Mappings  {{{
function! s:DefinePlug() abort
  " use in core layer
  nnoremap <Plug>(EasyCopy-inPairs)     :call <sid>EasyCopy_inPairs()<CR>
  nnoremap <Plug>(Toggle-ZZMode)        :call <sid>Toggle_ZZMode()<cr>
  nnoremap <Plug>(Safe-Erase-Buffer)    :call <sid>safe_erase_buffer()<cr>
  nnoremap <Plug>(Safe-Revert-Buffer)   :call <sid>safe_revert_buffer()<cr>
  " use in edit layer
  nnoremap <Plug>(Insert-EqualBox)      :call <sid>EqualBox()<CR>
  nnoremap <Plug>(Insert-MinusBox)      :call <sid>MinusBox()<CR>
  nnoremap <Plug>(CopyCursorCodeUrl)    :call <sid>CopyToClipboard(2)<CR>
  xnoremap <Plug>(CopySelectCodeUrls)   :<C-u>call <sid>CopyToClipboard(3)<CR>
  command! -nargs=?   SetFileHead       call  <sid>SetFileHead(<f-args>)
endfunction " }}}

" Unmap SpaceVim mappings {{{
function! s:unmap_SPC() abort
  if g:is_spacevim
    nnoremap s   <nop>
    nnoremap q   <nop>
    try
      nunmap   g*
      nunmap   g#
      nunmap   g$
      nunmap   gx
      nunmap   \p
      nunmap   \P
      nunmap   \qc
      nunmap   \qr
      nunmap   \ql
      nunmap   \qp
      nunmap   \qn
      unmap    g%
      vunmap   <C-s>
      nunmap   <tab>
      nunmap   <F7>
      iunmap   jk
      nunmap   ,<Space>
      nunmap   [SPC]-
      nunmap   [SPC]+
      nunmap   <leader>-
      nunmap   <leader>+

      unlet g:_spacevim_mappings['-']
      unlet g:_spacevim_mappings['+']
      unlet g:_spacevim_mappings_space['-']
      unlet g:_spacevim_mappings_space['+']
      " file
      unlet g:_spacevim_mappings_space.f.s
      unlet g:_spacevim_mappings_space.f.S
      unlet g:_spacevim_mappings_space.f.D
      unlet g:_spacevim_mappings_space.f.v
      unlet g:_spacevim_mappings_space.f.y
      " chang case
      unlet g:_spacevim_mappings_space.x.u
      unlet g:_spacevim_mappings_space.x.U
      unlet g:_spacevim_mappings_space.x.i['-']
      unlet g:_spacevim_mappings_space.x.i['_']
      unlet g:_spacevim_mappings_space.x.i.U
      unlet g:_spacevim_mappings_space.x.i.c
      unlet g:_spacevim_mappings_space.x.i.C
      " text transient state
      unlet g:_spacevim_mappings_space.x.J
      unlet g:_spacevim_mappings_space.x.K
      " transpose
      unlet g:_spacevim_mappings_space.x.t
    catch
    endtry
  endif
endfunction " }}}

" vim: set sw=2 ts=2 sts=2 et tw=78 fdm=marker:
