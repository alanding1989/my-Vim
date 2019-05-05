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
  " set ttimeout
  " set ttimeoutlen=50
  auto VimEnter * call s:unmap_SPC()

  " mode mapping {{{
  nnoremap  -           q
  nnoremap  --          @a
  nnoremap  s           <nop>
  nnoremap  q           <nop>
  nnoremap  ,           <space>l
  " NOTE: below 4 used in edgemotion, tmux-navigate
  nnoremap <c-k>        <c-w>k
  nnoremap <c-j>        <c-w>j
  nnoremap <c-h>        <c-w>h
  nnoremap <c-l>        <c-w>l
  nnoremap <c-a>        ^
  " NOTE: trailing space may in eol, use $ to move
  noremap  <c-e>        $
  nmap     <bs>         <Plug>(matchup-%)

  " insert mode
  inoremap <expr><c-j>  pumvisible() ? "\<c-n>" : "\<down>"
  inoremap <expr><c-k>  pumvisible() ? "\<c-p>" : "\<up>"
  inoremap <expr><c-e>  pumvisible() ? (!g:has_py ?
        \ asyncomplete#cancel_popup() : "\<c-e>") : "\<end>"
  inoremap <c-a>        <esc>^i
  inoremap <c-b>        <left>
  inoremap <c-f>        <right>
  inoremap <c-l>        <right>
  inoremap <c-p>        <c-left>
  inoremap <c-n>        <c-right>
  inoremap <m-b>        <c-left>
  inoremap <m-f>        <c-right>
  " NOTE: <C-h> will be overwritten in <Plug>delimitMateBS
  " if plug loaded successfully
  inoremap <expr><c-h>  pumvisible() ? "\<c-e><bs>" : "\<bs>"
  inoremap <c-d>        <del>
  inoremap <c-q>        <esc>ld$a
  inoremap <c-u>        <c-g>u<c-u>
  inoremap <c-_>        <c-k>

  " command line mode
  cnoremap qw           <esc>
  cnoremap <c-h>        <bs>
  cnoremap <c-j>        <down>
  cnoremap <c-k>        <up>
  cnoremap <c-b>        <left>
  cnoremap <c-f>        <right>
  cnoremap <c-l>        <right>
  cnoremap <c-a>        <home>
  cnoremap <c-e>        <end>
  cnoremap <c-d>        <del>
  cnoremap <c-_>        <c-k>
  cnoremap <c-v>        <c-r>=expand('%:p:h') <CR>

  " terminal mode
  tnoremap <esc>        <C-\><C-n>
  tnoremap <m-tab>      <C-\><C-n>:b#<CR>

  " fast save
  inoremap qw           <esc>
  nnoremap qw           :w<CR>
  nnoremap qwe          :wall<CR>
  nnoremap qww          :w !sudo tee % >/dev/null<CR>
  nnoremap qs           :saveas 
  nnoremap <m-s>        :saveas 
  inoremap <m-s>        <c-o>:saveas 
  nnoremap <c-s>        :w<CR>
  inoremap <c-s>        <c-o>:w<CR>
  "}}}


  " window and buffer management {{{
  nnoremap <silent>qq   :clo<CR>
  nnoremap <silent>qn   :clo<C-r>=winnr()+1<CR><CR>
  nnoremap <silent>qp   :clo<C-r>=winnr()-1<CR><CR>
  nnoremap <silent>qu   :wincmd z<CR>
  nnoremap <silent>qo   :only<CR>
  nnoremap <silent>qh   :q<CR>
  nnoremap <silent>qd   :try\|bd\|catch\|endtry<CR>
  nnoremap <silent>qb   :call <sid>killotherBuffers()<CR>
  nnoremap <silent>qf   :call <sid>delete_buffer_file()<CR>
  nnoremap <silent>qe   ggdG
  nnoremap <silent>qkk  :qa!<CR>

  nnoremap so           :vs 
  nnoremap <silent>sv   :vs<CR><C-w>w
  nnoremap <silent>ss   :sp<CR><C-w>w
  nnoremap <silent>sp   :vs +bp<CR>
  nnoremap <silent>s[   :sp +bp<CR>
  nnoremap <silent>sn   :vs +bn<CR>
  nnoremap <silent>s]   :sp +bn<CR>
  nnoremap <silent>sb   :b#<CR>
  nnoremap <silent>si   <c-w>x<C-w>w
  nnoremap <silent>s-   <c-w>K
  nnoremap <silent>s\   <c-w>L
  nnoremap <silent>sm   :res<CR>:vert resize<CR>
  nnoremap <silent>s=   :winc =<CR>
  nnoremap <silent>st   :tabnew<CR>
  nnoremap <silent>su   :nohl<CR>
  " last edit buffer
  nnoremap <silent><leader><tab>   :b#<CR>

  " hotkey for buf and tab selection, no need plugins {{{
  " select window
  nnoremap <silent><space>1       :call Winjump(1)<CR>
  nnoremap <silent><space>2       :call Winjump(2)<CR>
  nnoremap <silent><space>3       :call Winjump(3)<CR>
  nnoremap <silent><space>4       :call Winjump(4)<CR>
  nnoremap <silent><space>5       :call Winjump(5)<CR>
  nnoremap <silent><space>6       :call Winjump(6)<CR>
  nnoremap <silent><space>7       :call Winjump(7)<CR>
  nnoremap <silent><space>8       :call Winjump(8)<CR>
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
  nnoremap <silent> <m-->         :10winc <<CR>
  nnoremap <silent> <m-=>         :10winc ><CR>
  nnoremap <silent> <m-[>         :10winc -<CR>
  nnoremap <silent> <m-]>         :10winc +<CR>

  " improve window scroll
  nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
        \ 'zt' : (winline() == &scrolloff + 1) ? 'zb' : 'zz'
  noremap <expr> <C-f> max([winheight(0) - 2, 1])
        \ ."\<C-d>".(line('w$') >= line('$') ? "L" : "M")
  noremap <expr> <C-b> max([winheight(0) - 2, 1])
        \ ."\<C-u>".(line('w0') <= 1 ? "H" : "M")
  noremap <expr> <C-d> (line("w$") >= line('$') ? "j" : "3\<C-e>")
  noremap <expr> <C-u> (line("w0") <= 1         ? "k" : "3\<C-y>")

  " Toggle zz mode
  nnoremap zz          :call <sid>toggle_zzmode()<CR>
  " Toggle fold
  nnoremap <CR>        za
  nnoremap <s-CR>      zMza
  " }}}


  " edit related {{{
  auto FileType sh, inoremap <expr> =   match(getline('.'),
        \ '\v(\=\s){1}\_$\|(\>\s){1}\_$\|(\<\s){1}\_$\|(\+\s){1}\_$\|(\-\s){1}\_$') > -1 ?
        \ "\<bs>=<space>" : '='
  inoremap <expr> =   match(getline('.'),
        \ '\v(\=\s){1}\_$\|(\>\s){1}\_$\|(\<\s){1}\_$\|(\+\s){1}\_$\|(\-\s){1}\_$') > -1 ?
        \ "\<bs>=<space>" : '= '
  inoremap <expr> +   match(getline('.'), '\v\zs(if\|wh)') > -1 ? '+ ' : '+'
  inoremap <expr> -   match(getline('.'), '\v\zs(if\|wh)') > -1 ? '- ' : '-'
  inoremap <expr> >   match(getline('.'), '\v^\s*\zs(if\|wh)') > -1 ? '> '  : ">"
  inoremap <expr> <   match(getline('.'), '\v^\s*\zs(if\|wh)') > -1 ? '< '  : "<>"

  " Select
  noremap  vv          V
  nnoremap <leader>aa  ggVG
  nnoremap <leader>ae  VG

  " insert new line
  nnoremap <tab>o      o<ESC>
  nnoremap <tab>p      O<ESC>j
  " inset empty box
  nnoremap <space>iee  :call Insert_emptybox()<CR>
  nnoremap <space>ieh  :call Insert_headbox()<CR>
  " insert file head
  nnoremap <space>ih   :call SetFileHead()<CR>

  " Select blocks after indenting
  nnoremap >           >>_
  nnoremap <           <<_
  " indenting in visual mode
  xnoremap >           >gv|
  xnoremap <           <gv
  xnoremap <C-l>       >gv|
  xnoremap <C-h>       <gv

  " format
  nnoremap g=          :call <sid>format()<CR>
  " Remove spaces at the end of lines
  nnoremap <silent> d<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

  " C-r: Easier search and replace
  xnoremap <C-r>    :<C-u>call <SID>VSetSearch()<CR>:,$s/<C-R>=@/<CR>//gc<left><left><left>
  function! s:VSetSearch() abort
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  " yank and paste {{
  if has('unnamedplus')
    xnoremap <Leader>y   "+y
    " xnoremap <Leader>d "+d
    " lower case paste after
    nnoremap <Leader>p   "+p
    xnoremap <Leader>p   "+p
    " upper case paste before
    nnoremap <Leader>P   "+P
    xnoremap <Leader>P   "+P
  else
    xnoremap <Leader>y   "*y
    " xnoremap <Leader>d  "*d
    " lower case paste after
    nnoremap <Leader>p   "*p
    xnoremap <Leader>p   "*p
    " upper case paste before
    nnoremap <Leader>P   "*P
    xnoremap <Leader>P   "*P
  endif

  " Copy buffer absolute path to X11 clipboard'
  nnoremap <C-c>          :call <sid>CopyToClipboard()<CR>
  " Select last paste
  nnoremap <silent><expr> gp '`['.strpart(getregtype(), 0, 1).'`]'
  " }} }}


  " misc {{{
  " quickfix list movement
  " nnoremap <Leader>qn  :cnext<CR>
  " nnoremap <Leader>qp  :cprev<CR>
  " nnoremap <Leader>ql  :copen<CR>
  " nnoremap <Leader>qc  :call setqflist([])<CR>

  " help
  nnoremap K             :call util#help_wrapper()<CR>
  nnoremap <space>hh     :call util#vim_help_wrapper()<CR>
  " show full path
  nnoremap <c-g>         2<c-g>
  " echo prefix
  nnoremap <leader>ee    :echo 
  " highlight
  nnoremap <leader>eh    :<C-u>EchoHlight 
  " maparp
  noremap  <leader>em    :<C-u>EchoMap 
  " set options
  noremap  <leader>eo    :<C-u>set 
  " show version
  nnoremap <leader>ev    :version<CR>

  " directory operatios
  nnoremap <leader>db    :lcd %:p:h<CR>
  nnoremap <leader>dd    :lcd 
  nnoremap <leader>dw    :lcd<CR>
  nnoremap <leader>dp    :pwd<CR>

  if has('nvim')
    nnoremap <space>qh   :checkhealth<CR>
  endif
  "}}


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
    nnoremap <leader>ac<space> :exec 'Unite file_rec/'.(has('nvim') ?
          \ 'neovim' : 'async').' -path=~/.SpaceVim'<CR>
  elseif glob(g:home.'init.toml') !=# ''
    nnoremap <leader>acm       :Denite file/rec -path=~/.SpaceVim.d<CR>
    nnoremap <leader>ac<space> :Denite file/rec -path=~/.SpaceVim<CR>
  else
    nnoremap <leader>acm       :LeaderfFile ~/.SpaceVim.d<CR>
    nnoremap <leader>ac<space> :LeaderfFile ~/.SpaceVim<CR>
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
  elseif !g:is_spacevim
    nnoremap <leader>aca       :vs ~/.SpaceVim.d/autoload/My_Vim/Main.vim<CR>
    nnoremap <leader>acu       :vs ~/.SpaceVim.d/autoload/My_SpaceVim/Main.vim<CR>
    nnoremap <leader>acc       :vs ~/.SpaceVim.d/config/Vim/config.vim<CR>
    nnoremap <leader>ack       :vs ~/.SpaceVim.d/config/Vim/keymap.vim<CR>
    nnoremap <leader>acy       :vs ~/.SpaceVim.d/config/SpaceVim/option.vim<CR>
    nnoremap <leader>acv       :vs ~/.SpaceVim.d/config/SpaceVim/config.vim<CR>
    nnoremap <leader>acl       :vs ~/.SpaceVim.d/config/SpaceVim/keymap.vim<CR>
    nnoremap <leader>acp       :vs ~/.SpaceVim.d/config/Vim/plugins/
  endif "}}}
endfunction


" toggle zzmode {{
let s:zzmode = 0
function! s:toggle_zzmode() abort
  if s:zzmode == 0
    exec 'normal! M'
    call s:Zmap()
    let s:zzmode = 1
    echo '  zzmode now is on!'
  else
    call s:undoZmap()
    let s:zzmode = 0
    echo '  zzmode now is off!'
  endif
endfunction

function! s:Zmap() abort
  " Normal
  nnoremap dd ddzz
  " Visual
  vnoremap d dzz
  " Normal + Visual
  noremap # #zz
  noremap * *zz
  noremap j jzz
  noremap k kzz
  noremap G Gzz
  noremap H Hzz
  noremap L Lzz
  noremap ( (zz
  noremap ) )zz
  noremap { {zz
  noremap } }zz
  noremap [{ [{zz
  noremap ]} ]}zz
  noremap <c-f> <c-f>zz
  noremap <c-b> <c-b>zz
  noremap <c-d> <c-d>zz
  noremap <c-u> <c-u>zz
endfunction

function! s:undoZmap() abort
  " Normal
  nunmap dd
  " Visual
  vunmap d
  " Normal + Visual
  unmap #
  unmap *
  unmap j
  unmap k
  unmap G
  unmap H
  unmap L
  unmap (
  unmap )
  unmap {
  unmap }
  unmap [{
  unmap ]}
  unmap <c-f>
  unmap <c-b>
  unmap <c-d>
  unmap <c-u>
endfunction "}}

" local funcs   {{
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

function! s:format() abort
  let save_cursor = getpos('.')
  normal! gg=G
  call setpos('.', save_cursor)
endfunction

let s:MESSAGE = SpaceVim#api#import('vim#message')
let s:BUFFER  = SpaceVim#api#import('vim#buffer')
function! s:delete_buffer_file() abort
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
function! s:close_current_buffer(...) abort
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
endfunction

" Copy buffer absolute path to X11 clipboard'
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
endf

function! s:unmap_SPC() abort
  if g:is_spacevim
    iunmap jk
    nunmap <tab>
    nnoremap s <nop>
    nnoremap q <nop>
    try
      unmap   ,<Space>
      unmap   <F7>
      unmap   [SPC]-
      unmap   [SPC]+
      nunmap  <leader>-
      nunmap  <leader>+
      
      unlet g:_spacevim_mappings['-']
      unlet g:_spacevim_mappings['+']
      unlet g:_spacevim_mappings_space['-']
      unlet g:_spacevim_mappings_space['+']
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
endfunction " }}


" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker:
