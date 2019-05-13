"=============================================================================
" file name   : option.vim
" description : basic option
"=============================================================================
set nocompatible


" set list

" ui {{{
set number relativenumber
set autoindent smartindent cindent

set smarttab expandtab
set shiftwidth=2 tabstop=2 softtabstop=2 textwidth=78

set linebreak nowrap

set foldlevel=0 foldmethod=indent
set foldtext=Foldtext()
augroup my_fold
  auto!
  autocmd FileType vim,conf set foldmethod=marker foldlevel=0
augroup END

set backspace=indent,eol,start
if g:is_nvim
  set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶
elseif !g:is_nvim && !g:is_win
  set listchars=tab:\|\ ,trail:·,extends:>,precedes:<
endif

set fillchars=vert:!,fold:-

set scrolloff=2 sidescrolloff=5
set signcolumn=yes
set showtabline=2
set display+=lastline laststatus=2
set noshowmode showcmd wildmenu ruler shortmess+=c
set statusline=\%<\ \ %F\ [%1*%m%*%n%R%H]%=\ %Y.\ \ \ %0(%{&ff}\|%{&fenc}\ \ %l:%c\ -\ %p%%\/%L%)\ \  

" search
set hlsearch incsearch ignorecase smartcase
set showmatch matchtime=0

" autocomplete
set complete=.,w,b,u,t
set completeopt=menu,menuone,noinsert
set pumheight=15

set mouse=nv
"}}}

" system {{{
set autoread
set hidden

" if g:is_win
  " set renderoptions=type:directx
" endif
" speed up
set lazyredraw
set synmaxcol=200

" set updatetime=500

set tags=./.tags;,.tags
"}}}

" encoding {{{
set fileformats=unix,dos,mac
if has('multi_byte')
  " inside
  set encoding=utf-8
  " file default
  set fileencoding=utf-8
  " auto try setting when onen file
  set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1
endif
"}}}

" extension for search {{{
set suffixes+=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
set wildignorecase
set wildignore+=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
"}}}

" highlight {{{
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! clear SpellLocal
hi! SignColumn guibg=NONE ctermbg=NONE
hi! LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE
hi! LineNr gui=NONE guifg=DarkGrey guibg=NONE
hi! Pmenu    guibg=gray guifg=black ctermbg=gray  ctermfg=black
hi! PmenuSel guibg=gray guifg=brown ctermbg=brown ctermfg=gray
"}}}

" gui setting for vim {{{
if has('gui_running')
  hi! SpellBad  gui=undercurl guisp=red
  hi! SpellCap  gui=undercurl guisp=blue
  hi! SpellRare gui=undercurl guisp=magenta
  hi! SpellRare gui=undercurl guisp=cyan
else
  hi! SpellBad   term=underline cterm=underline term=standout ctermfg=1
  hi! SpellCap   term=underline cterm=underline
  hi! SpellRare  term=underline cterm=underline
  hi! SpellLocal term=underline cterm=underline
endif

" gui ui
if has('gui_running')
  set guioptions-=m " Hide menu bar.
  set guioptions-=T " Hide toolbar
  set guioptions-=L " Hide left-hand scrollbar
  set guioptions-=r " Hide right-hand scrollbar
  set guioptions-=b " Hide bottom scrollbar
  set showtabline=0 " Hide tabline
  set guioptions-=e " Hide tab

  if g:is_win
    set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI:qDRAFT
  elseif g:is_unix
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11
  else
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
  endif
endif
"}}}

" backup {{{
if !g:is_spacevim
  set noswapfile
  " set nowritebackup
  let s:undofile  = g:is_win ? 'D:/.cache/Vim/undofile' :
        \ '/home/alanding/.cache/My_Vim'.(g:is_root ? '-root' : '-alan').'/undofile'
  let s:backupdir = g:is_win ? 'D:/.cache/Vim/backup' :
        \ '/home/alanding/.cache/My_Vim'.(g:is_root ? '-root' : '-alan').'/backup'
  let s:swapdir   = g:is_win ? 'D:/.cache/Vim/swap' :
        \ '/home/alanding/.cache/My_Vim'.(g:is_root ? '-root' : '-alan').'/swap'
  if glob(s:undofile) ==# ''
    call mkdir(expand(s:undofile), 'p', 0700)
  endif
  if glob(s:backupdir) ==# ''
    call mkdir(expand(s:backupdir), 'p', 0700)
  endif
  if glob(s:swapdir) ==# ''
    call mkdir(expand(s:swapdir), 'p', 0700)
  endif
  set backup
  set undofile
  set undolevels=1000
  set history=1000
  exec 'set undodir='.expand(s:undofile)
  exec 'set backupdir='.expand(s:backupdir)
  exec 'set directory='.expand(s:swapdir)
  unlet s:undofile
  unlet s:backupdir
  unlet s:swapdir
endif
"}}}


scriptencoding utf-8
" vim:set sw=2 ts=2 sts=2 et tw=78 fmd=marker
