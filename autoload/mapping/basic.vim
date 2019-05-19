" =============================================================================
" mapping/basic.vim --- default keymap
" Section mappings
" =============================================================================
scriptencoding utf-8


function! mapping#basic#load() abort
  let g:mapleader       = ';'
  let g:maplocalleader  = "\<Space>"
  set timeout
  " set timeoutlen=800
  auto VimEnter * call s:unmap_SPC()

  " mode mapping {{{
  nnoremap  -           q
  nnoremap  --          @a
  nnoremap  s           <nop>
  nnoremap  q           <nop>
  nnoremap  ,           <Space>l
  " NOTE: below 4 used in edgemotion, tmux-navigate
  nnoremap <C-k>        <C-w>k
  nnoremap <C-j>        <C-w>j
  nnoremap <C-h>        <C-w>h
  nnoremap <C-l>        <C-w>l
  nnoremap <C-a>        ^
  noremap  <C-e>        $

  " insert mode
  inoremap <expr><C-j>  pumvisible() ? "\<C-n>" : "\<down>"
  inoremap <expr><C-k>  pumvisible() ? "\<C-p>" : "\<up>"
  inoremap <expr><C-e>  pumvisible() ? (!g:has_py ?
        \ asyncomplete#cancel_popup() : "\<C-e>") : "\<End>"
  inoremap <C-a>        <Esc>^i
  inoremap <C-b>        <left>
  inoremap <C-f>        <right>
  inoremap <C-l>        <right>
  inoremap <C-p>        <C-left>
  inoremap <C-n>        <C-right>
  inoremap <m-b>        <C-left>
  inoremap <m-f>        <C-right>
  inoremap <expr><C-h>  pumvisible() ? "\<C-e><BS>" : DelEmptyPair()
  inoremap <C-d>        <Del>
  inoremap <C-q>        <Esc>ld$a
  inoremap <C-u>        <C-g>u<C-u>
  inoremap <C-_>        <C-k>
  map  <expr> <BS>      exists('loaded_matchup') ? "\<Plug>(matchup-%)"  : "\<BS>"
  xmap <expr>i<BS>      exists('loaded_matchup') ? "\<Plug>(matchup-i%)" : "\<BS>"
  omap <expr>i<BS>      exists('loaded_matchup') ? "\<Plug>(matchup-i%)" : "\<BS>"
  xmap <expr>a<BS>      exists('loaded_matchup') ? "\<Plug>(matchup-a%)" : "\<BS>"
  omap <expr>a<BS>      exists('loaded_matchup') ? "\<Plug>(matchup-a%)" : "\<BS>"

  " command line mode
  cnoremap qw           <Esc>
  cnoremap <C-h>        <BS>
  cnoremap <C-j>        <down>
  cnoremap <C-k>        <up>
  cnoremap <C-b>        <left>
  cnoremap <C-f>        <right>
  cnoremap <C-l>        <right>
  cnoremap <m-b>        <C-left>
  cnoremap <m-f>        <C-right>
  cnoremap <C-a>        <Home>
  cnoremap <C-e>        <End>
  cnoremap <C-d>        <Del>
  cnoremap <C-_>        <C-k>
  cnoremap <C-v>        <C-r>=expand('%:p:h') <CR>

  " terminal mode
  tnoremap <Esc>        <C-\><C-n>
  tnoremap <m-tab>      <C-\><C-n>:b#<CR>

  " fast save
  inoremap qw           <Esc>:w<CR>
  nnoremap qw           :w<CR>
  nnoremap <C-s>        :w<CR>
  inoremap <C-s>        <C-o>:w<CR>
  nnoremap qwe          :wall<CR>
  nnoremap qww          :w !sudo tee % >/dev/null<CR>
  nnoremap qs           :saveas 
  nnoremap <m-s>        :saveas 
  inoremap <m-s>        <C-o>:saveas 
  "}}}

  " window and buffer management {{{
  nnoremap <silent>qq   :call <sid>close_window()<CR>
  nnoremap <silent>qn   :clo<C-r>=winnr()+1<CR><CR>
  nnoremap <silent>qp   :clo<C-r>=winnr()-1<CR><CR>
  " nnoremap <silent>qu   :winc z<CR>
  nnoremap <silent>qu   :call <sid>safe_revert_buffer()<CR>
  nnoremap <silent>qo   :only<CR>
  nnoremap <silent>qh   :q<CR>
  nnoremap <silent>qd   :try\|bd\|catch\|endtry<CR>
  nnoremap <silent>qb   :call <sid>killotherBuffers()<CR>
  nnoremap <silent>qf   :call <sid>delete_current_buffer_file()<CR>
  nnoremap <silent>qe   :call <sid>safe_erase_buffer()<CR>
  nnoremap <silent>qr   :call <sid>rename_file()<CR>
  nnoremap <silent>qkk  :qa!<CR>

  nnoremap <silent>so   :call feedkeys(':vs ')<CR> 
  nnoremap <silent>sv   :vs<CR><C-w>w
  nnoremap <silent>ss   :sp<CR><C-w>w
  nnoremap <silent>sp   :vs +bp<CR>
  nnoremap <silent>s[   :sp +bp<CR>
  nnoremap <silent>sn   :vs +bn<CR>
  nnoremap <silent>s]   :sp +bn<CR>
  nnoremap <silent>sb   :b#<CR>
  nnoremap <silent>si   <C-w>x<C-w>w
  nnoremap <silent>s-   <C-w>K
  nnoremap <silent>s\   <C-w>L
  nnoremap <silent>sm   :res\|vert res<CR>zz
  nnoremap <silent>s=   :winc =<CR>
  nnoremap <silent>st   :tabnew<CR>
  nnoremap <silent>s3   :vs\|vs\|<CR>
  nnoremap <silent>s0   :vert rightb new<CR>
  nnoremap <silent>su   :nohl<CR>
  " last edit buffer
  nnoremap <silent><leader><tab>   :b#<CR>

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
  nnoremap <silent> <m-->      :10winc <<CR>
  nnoremap <silent> <m-=>      :10winc ><CR>
  nnoremap <silent> <m-[>      :10winc -<CR>
  nnoremap <silent> <m-]>      :10winc +<CR>

  " improve window scroll
  auto VimEnter * noremap 
        \  <expr> zz           <sid>win_scroll(1, 'z')
  nnoremap <expr> <C-f>        <sid>win_scroll(1, 'f')
  nnoremap <expr> <C-b>        <sid>win_scroll(0, 'f')
  nnoremap <expr> <C-d>        <sid>win_scroll(1, 'd')
  nnoremap <expr> <C-u>        <sid>win_scroll(0, 'd')

  " Toggle fold
  nnoremap <expr> <CR>         <sid>OpenFoldOrGotoMiddle(1)
  nnoremap <expr> <S-CR>       <sid>OpenFoldOrGotoMiddle(0)
  " Toggle zz mode
  nnoremap <leader>az          :call <sid>Toggle_ZZMode()<cr>
  " }}}

  " edit related {{{
  call <sid>Delimitor_init()

  " insert new line
  nnoremap <tab>o      o<Esc>
  nnoremap <tab>p      O<Esc>j
  " inset empty box
  nnoremap <Space>iee  :call <sid>MinusBox()<CR>
  nnoremap <Space>ieh  :call <sid>EqualBox()<CR>
  " insert file head
  nnoremap <Space>ih   :call <sid>SetFileHead()<CR>

  " indenting in visual mode
  xnoremap >           >gv|
  xnoremap <           <gv
  xnoremap <C-l>       >gv|
  xnoremap <C-h>       <gv
  " select blocks after indenting
  nnoremap >           >>_
  nnoremap <           <<_

  " format
  nnoremap g=          :call <sid>format()<CR>

  " Remove spaces at the end of lines
  nnoremap <silent> d<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

  " Select
  noremap  vv          V
  nnoremap <leader>aa  ggVG
  nnoremap <leader>ae  VG
  " Select last paste
  nnoremap <silent><expr> <leader>ap  '`['.strpart(getregtype(), 0, 1).'`]'
  " C-r: Easier search and replace
  xnoremap <C-r>    :<C-u>call <sid>VSetSearch()<CR>:,$s/<C-R>=@/<CR>//gc<left><left><left>

  " yank and paste {{{
  if has('unnamedplus')
    nnoremap <leader>y   :call <sid>EasyCopy_inPairs()<CR>
    xnoremap <leader>y   "+y
    xnoremap <leader>d   "+d
    " lower case paste after
    nnoremap <leader>p   "+p
    xnoremap <leader>p   "+p
    inoremap <C-v>       "+p
    " upper case paste before
    nnoremap <leader>P   "+P
    xnoremap <leader>P   "+P
  else
    xnoremap <leader>y   "*y
    xnoremap <leader>d   "*d
    " lower case paste after
    nnoremap <leader>p   "*p
    xnoremap <leader>p   "*p
    inoremap <C-v>       "+p
    " upper case paste before
    nnoremap <leader>P   "*P
    xnoremap <leader>P   "*P
  endif

  " Copy buffer absolute path to X11 clipboard'
  nnoremap <C-c>          :call <sid>CopyToClipboard()<CR>
  " }}}
  " }}}

  " misc {{{
  " quickfix list movement
  nnoremap <leader>qn    :cnext<CR>
  nnoremap <leader>qp    :cprev<CR>
  nnoremap <leader>ql    :copen<CR>
  nnoremap <leader>qc    :call setqflist([])<CR>

  " help
  nnoremap K             :call util#help_wrapper()<CR>
  nnoremap <Space>hh     :EchoHelp 
  " show full path
  nnoremap <C-g>         2<C-g>
  " echo prefix
  nnoremap <leader>ee    :echo 
  " call function
  nnoremap <leader>ef    :call 
  " set options
  noremap  <leader>eo    :set 
  " highlight
  nnoremap <leader>eh    :EchoHlight 
  " maparp
  noremap  <leader>em    :EchoMap 
  " show version
  nnoremap <leader>ev    :version<CR>

  " directory operatios
  nnoremap <leader>db    :lcd %:p:h<CR>
  nnoremap <leader>dd    :lcd 
  nnoremap <leader>dw    :lcd<CR>
  nnoremap <leader>dp    :pwd<CR>

  " g related
  auto VimEnter *
        \ nnoremap g0    g*   |
        \ nnoremap go    gf   |
        \ nnoremap gm    ga   |
        \ nnoremap gc    :call util#echohl('col number: ', col('.'))<CR>

  if has('nvim')
    nnoremap <Space>qh   :checkhealth<CR>
  endif

  call <sid>definePlug()
  " }}}

  " Open config files {{{
  nnoremap <leader>aci         :vs ~/.SpaceVim.d/init.vim<CR>
  nnoremap <leader>acr         :vs ~/.SpaceVim.d/vimrc<CR>
  nnoremap <leader>acg         :vs ~/.SpaceVim.d/config/general.vim<CR>
  nnoremap <leader>aco         :vs ~/.SpaceVim.d/config/option.vim<CR>
  nnoremap <leader>acb         :vs ~/.SpaceVim.d/autoload/mapping/basic.vim<CR>
  nnoremap <leader>acd         :vs ~/.SpaceVim.d/autoload/default.vim<CR>
  if !g:has_py
    nnoremap <leader>acm       :exec 'Unite file_rec/'.(has('nvim') ?
          \ 'neovim' : 'async').' -path=~/.SpaceVim.d'<CR>
    nnoremap <leader>ac<Space> :exec 'Unite file_rec/'.(has('nvim') ?
          \ 'neovim' : 'async').' -path=~/.SpaceVim'<CR>
  elseif glob(g:home.'init.toml') !=# ''
    nnoremap <leader>acm       :Denite file/rec -path=~/.SpaceVim.d<CR>
    nnoremap <leader>ac<Space> :Denite file/rec -path=~/.SpaceVim<CR>
  else
    nnoremap <leader>acm       :LeaderfFile ~/.SpaceVim.d<CR>
    nnoremap <leader>ac<Space> :LeaderfFile ~/.SpaceVim<CR>
  endif
  if g:is_spacevim
    nnoremap <leader>aca       :vs ~/.SpaceVim.d/autoload/My_SpaceVim/Main.vim<CR>
    nnoremap <leader>acu       :vs ~/.SpaceVim.d/autoload/My_Vim/Main.vim<CR>
    nnoremap <leader>acc       :vs ~/.SpaceVim.d/config/SpaceVim/config.vim<CR>
    nnoremap <leader>ack       :vs ~/.SpaceVim.d/config/SpaceVim/keymap.vim<CR>
    nnoremap <leader>acy       :vs ~/.SpaceVim.d/config/Vim/option.vim<CR>
    nnoremap <leader>acv       :vs ~/.SpaceVim.d/config/Vim/config.vim<CR>
    nnoremap <leader>acl       :vs ~/.SpaceVim.d/config/Vim/keymap.vim<CR>
    nnoremap <leader>acp       :vs ~/.SpaceVim.d/config/SpaceVim/plugins_before/
    nnoremap <leader>ac[       :vs ~/.SpaceVim.d/config/Vim/plugins/
  elseif !g:is_spacevim
    nnoremap <leader>aca       :vs ~/.SpaceVim.d/autoload/My_Vim/Main.vim<CR>
    nnoremap <leader>acu       :vs ~/.SpaceVim.d/autoload/My_SpaceVim/Main.vim<CR>
    nnoremap <leader>acc       :vs ~/.SpaceVim.d/config/Vim/config.vim<CR>
    nnoremap <leader>ack       :vs ~/.SpaceVim.d/config/Vim/keymap.vim<CR>
    nnoremap <leader>acy       :vs ~/.SpaceVim.d/config/SpaceVim/option.vim<CR>
    nnoremap <leader>acv       :vs ~/.SpaceVim.d/config/SpaceVim/config.vim<CR>
    nnoremap <leader>acl       :vs ~/.SpaceVim.d/config/SpaceVim/keymap.vim<CR>
    nnoremap <leader>acp       :vs ~/.SpaceVim.d/config/Vim/plugins/
    nnoremap <leader>ac[       :vs ~/.SpaceVim.d/config/SpaceVim/plugins_before/
  endif
  let g:Lf_CacheDirectory      = expand('~/.cache')
  "}}}
endfunction


function! s:definePlug() abort
  " <Plug> use in g:home . config/SpaceVim/keymap.vim
  nnoremap <Plug>(EasyCopy-inPairs) :call <sid>EasyCopy_inPairs()<CR>
  nnoremap <plug>(Toggle-ZZMode)    :call <sid>Toggle_ZZMode()<cr>
  " <Plug> use in edit layer
  nnoremap <Plug>(SetFileHead)      :call <sid>SetFileHead()<CR>
  nnoremap <Plug>(Insert-EqualBox)  :call <sid>EqualBox()<CR>
  nnoremap <Plug>(Insert-MinusBox)  :call <sid>MinusBox()<CR>
endfunction


" Delimit Mapping {{{
function! s:Delimitor_init() abort
  " inoremap <expr> =   MatchDel('=', '\(=\+\s\)\\|\(>\+\s\)\\|\(<\+\s\)\\|\(+\+\s\)\\|\(-\+\s\)')
  inoremap <expr> =   MatchDel('=', '\v(\=+\s\_$)\|(\>+\s\_$)\|(\<+\s\_$)\|(\++\s\_$)\|(-+\s\_$)')
  inoremap <expr> \|  MatchDel('\|', '\|\+\s$')
  inoremap <expr> &   MatchDel('&', '&\+\s$')
  inoremap <expr> #   MatchDel('#', '\v(\=+\s)\|(\=\~)\|(!\=)\|(!\~)')
  inoremap <expr> ~   MatchDel('~', '\(=\+\s\)')
  inoremap <expr> >   MatchDel('>', '\v(\>+\s)\|(\=\s\_$)\|(-\s\_$)')
  inoremap <expr> <   MatchDel('<', '\v^\s*(if\|el\|wh\|let)', '>')
  inoremap <expr> ,   CurChar(0, '\s') && Within('pair')[0] ? "\<BS>,\<Space>" : (CurChar(1, '') ? "," : ",\<Space>")
  call s:AutoClose()
  call s:AutoPairs()
  call s:Numfix()
  auto FileType sh  call <sid>Bashfix()
  auto FileType vim inoremap <expr> " 
        \ MatchCl('\v(^\_$)\|(^\s*\w*\s\_$)\|(^\s+\_$)')
        \ ? "\"\<Space>" : AutoClo('"', '"')
endfunction
function! s:AutoClose() abort " {{{
  let autoclose = [
        \ ')', ']', '}', '-', '+', '?',
        \ ]
  for r in autoclose
    exec 'inoremap <expr> '.r.' AutoClo('.string(r).')'
  endfor
endfunction " }}}
function! s:AutoPairs() abort " {{{
  let autopairs = get(b:, 'autopairs', get(g:, 'autopairs', {
        \ '('  : ')' ,
        \ '['  : ']' ,
        \ '{'  : '}' ,
        \ "'"  : "'" ,
        \ '"'  : '"' ,
        \ '`'  : '`' ,
        \ '*'  : '*' ,
        \ '《' : '》',
        \ }))
  for [l, r] in items(autopairs)
    exec 'inoremap <expr> '.l.' AutoClo('.string(l).', '.string(r).')'
  endfor
endfunction " }}} 
function! s:Numfix() abort " {{{
  for num in range(1, 9)
    exec 'inoremap <expr> '.num.' MatchDel('.num.",
          \ '\\v.*\\s\\W\\s\-\\s$')"
  endfor
endfunction " }}} 
function! s:Bashfix() abort " {{{
  for char in ['d', 'e', 'f', 'z', 'n']
    exec 'inoremap <expr> '.char.' MatchDel('.string(char).', "-\\s_$", 1)'
  endfor
endfunction "}}}
" }}} 

" Window and Buffer Manipulate {{{
" Open fold or goto line middle {{{
function! s:OpenFoldOrGotoMiddle(mode) abort
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

" Quit_preview Window {{{
function! s:close_window() abort
  let winnr = 0
  for i in range(1, winnr('$'))
    if getwinvar(i, '&ft') ==# 'diff'
      let winnr = i
    endif
  endfor
  let key = "\<C-w>c"
  if winnr
    exe 'normal!' winnr "\<C-w>w" key
  else
    exe 'normal!' key
  endif
endfunction "}}}

" Window Scroll {{{
function! s:win_scroll(forward, mode)
  let winnr = 0
  for i in range(1, winnr('$'))
    if getwinvar(i, 'float') || getwinvar(i, '$previewwindow')
      let winnr = i
    endif
  endfor
  " f half screen, d several lines
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
    return winnr."\<C-w>w".'zn'.key."\<C-w>p"
  else
    return key
  endif
endfunction "}}}

" Toggle zzmode {{{
 " param init {{{
let s:zzmode = 0
let s:save_rhs = {}
let s:zzmodekey = {
      \ 'dd'     : 'ddzz',
      \ 'd'      : 'dzz',
      \ '#'      : '#zz',
      \ '*'      : '*zz',
      \ 'j'      : 'jzz',
      \ 'k'      : 'kzz',
      \ 'G'      : 'Gzz',
      \ 'H'      : 'Hzz',
      \ 'L'      : 'Lzz',
      \ '('      : '(zz',
      \ ')'      : ')zz',
      \ '{'      : '{zz',
      \ '}'      : '}zz',
      \ '[{'     : '[{zz',
      \ ']}'     : ']}zz',
      \ } " }}}
function! s:Toggle_ZZMode() abort
  if s:zzmode == 0
    exec 'normal! M'
    for [lhs, rhs] in items(s:zzmodekey)
      let s:save_rhs[lhs] = maparg(lhs, 'n')
      exec 'nnoremap ' lhs rhs
    endfor
    let s:zzmode = 1
    echo '  zzmode now is on!'
  else
    for [lhs, rhs] in items(s:save_rhs)
      if !empty(rhs)
        exec 'nnoremap ' lhs rhs
      else
        exec 'nunmap ' lhs
      endif
    endfor
    let s:zzmode = 0
    echo '  zzmode now is off!'
  endif
endfunction
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
" }}}

" File Manipulate {{{
" rename file {{{
function! s:rename_file() abort
  let curbufnr = bufnr('%')
  let newn = input('New name: '.expand('%:p').' -> ', expand('%:p'))
  if glob(newn) !=# ''
    call util#echohl(' The file already exists !', 'n')
    return
  endif
  call rename(expand('%'), newn)
  exec 'e ' newn
  exec 'bd' curbufnr
endfunction " }}}

" safe erase buffer {{{
let s:MESSAGE = SpaceVim#api#import('vim#message')
let s:BUFFER  = SpaceVim#api#import('vim#buffer')
function! s:safe_erase_buffer() abort
  if s:MESSAGE.confirm('Erase content of buffer ' . expand('%:t'))
    normal! ggdG
  else
    echo 'canceled!'
  endif
endfunction " }}}

" delete current buffer file {{{
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
"}}}

" Easy Edit {{{
" insert nice box " {{{
function! <sid>EqualBox() abort
  if &ft ==# 'vim'
    call s:inshbox('"', '=')
  elseif &ft ==# 'sh' || &ft ==# 'python' || &ft ==# 'ps1'
    call s:inshbox('# ', '=')
  elseif &ft ==# 'scala' || &ft ==# 'cpp' || &ft ==# 'c'
    call s:inshbox('//', '=')
  endif
endfunc
function! <sid>MinusBox() abort
  if &ft ==# 'vim'
    call s:inshbox('"', '-')
  elseif &ft ==# 'sh' || &ft ==# 'python' || &ft ==# 'ps1'
    call s:inshbox('# ', '-')
  elseif &ft ==# 'scala' || &ft ==# 'cpp' || &ft ==# 'c'
    call s:inshbox('//', '-')
  endif
endfunc
function! s:inshbox(cmsign, reptsign) abort
  call setline(line('.')   , a:cmsign.repeat(a:reptsign, 80))
  call  append(line('.')   , a:cmsign)
  call  append(line('.')+1 , a:cmsign.repeat(a:reptsign, 80))
  call  append(line('.')+2 , '')
  silent exec 'normal! 03j'
endfun
"}}}

" insert file head {{{
function! <sid>SetFileHead() abort
  if &filetype ==# 'vim'
    call s:insfhead('"', 'scriptencoding utf-8', '')

  elseif &filetype ==# 'sh'
    call s:insfhead('#', '#! /usr/bin/env bash', '')

  elseif &filetype ==# 'ps1'
    call s:insfhead('#', '', '')

  elseif &filetype ==# 'python' || &filetype ==# 'ipynb'
    call s:insfhead('#', '#! /usr/bin/env python3', '# -*- coding: utf-8 -*-')

  elseif &filetype ==# 'scala'
    call s:insfhead('#', '', '', '/*')

  elseif &filetype ==# 'cpp'
    call s:insfhead('#', '#include <iostream>', 'using namespace std;', '/*')

  elseif &filetype ==# 'c'
    call s:insfhead('#', '#include <stdio.h>', '', '/*')
  endif
endfun
function! s:insfhead(cmsign, head1, head2, ...) abort
  if a:0 == 0
    let head = [
          \ a:cmsign. repeat('=', 80),
          \ a:cmsign. ' File Name    : '. expand('%'),
          \ a:cmsign. ' Author       : AlanDing',
          \ a:cmsign. ' Created Time : '. strftime('%c'),
          \ a:cmsign. repeat('=', 80),
          \ ]
    let head = &ft ==# 'sh' ? insert(head, a:head1, 0) : head
  elseif a:0 == 1
    let head = [
          \ a:1     . repeat('=', 80),
          \ a:cmsign. ' File Name    : '. expand('%'),
          \ a:cmsign. ' Author       : AlanDing',
          \ a:cmsign. ' Created Time : '. strftime('%c'),
          \ a:cmsign. repeat('=', 80). join(reverse(split(a:1)), ''),
          \ ]
  endif
  if a:head1 !=# '' && a:head2 ==# ''
    let shit = &ft ==# 'sh' ? ['', ''] : [a:head1, '', '']
    call map(shit, {key, val -> add(head, val)})
  elseif a:head2 !=# ''
    call map([a:head1, a:head2, '', ''], {key, val -> add(head, val)})
  else
    call map(['', ''], {key, val -> add(head, val)})
  endif
  call append(0, head)
  call setpos('.', [0, len(head), 1])
endfunc "}}}

" format {{{
function! s:format() abort
  let save_cursor = getpos('.')
  normal! gg=G
  call setpos('.', save_cursor)
endfunction " }}}

" copy buffer absolute path to X11 clipboard {{{
function! s:CopyToClipboard(...) abort
  if a:0
    echom 1
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
            let @+=f_url
            echo 'Copied to clipboard'
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
      echo 'Copied to clipboard ' . @+
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
  if within[0]
    try
      let a_save = @+
      let @+ = ''
      exec 'normal! mx"+yi'. within[1]
      if len(@+) > 1
        call util#echohl('Sucessfully yank text in pairs to system clipboard !')
      endif
    catch
      let @+ = a_save
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

" Unmap SpaceVim mappings {{{
function! s:unmap_SPC() abort
  if g:is_spacevim
    nnoremap s <nop>
    nnoremap q <nop>
    try
      nunmap   \p
      nunmap   \P
      nunmap   \qc
      nunmap   \qr
      nunmap   \ql
      nunmap   \qp
      nunmap   \qn
      unmap    g%
      nunmap   <F7>
      nunmap   <tab>
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
