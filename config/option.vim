"=============================================================================
" file name   : option.vim
" description : basic option
"=============================================================================
set nocompatible


" set list

" Ui {{{
set number relativenumber
set autoindent smartindent cindent

set smarttab expandtab
set shiftwidth=4 tabstop=4 softtabstop=4 textwidth=78

set linebreak

set foldlevel=0 foldmethod=syntax
set foldtext=Foldtext()
augroup my_config
  auto!
  autocmd FileType vim,conf,zsh,sh setlocal foldmethod=marker foldlevel=0
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
set matchpairs+=<:>,=:;

" autocomplete
set complete=.,w,b,u,t
set completeopt=menu,menuone,noinsert
set pumheight=15

set mouse=nv
"}}}

" System {{{
set autoread
set hidden

if has('clipboard')
  if has('unnamedplus')  " use @+ for system clipboard
    set clipboard=unnamed,unnamedplus
  else         " On mac and Windows, use @*
    set clipboard=unnamed
  endif
endif

" speed up
set lazyredraw
set synmaxcol=300

" set updatetime=500

set tags=./.tags;,.tags
"}}}

" Encoding {{{
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

" Extension for search {{{
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

" Backup Setting {{{
set noswapfile
if !g:is_spacevim
  " set nowritebackup
  " must be /home/alanding, not root
  let s:undofile  = g:is_win ? 'D:/.cache/Vim/undofile' :
        \ g:linux_home. '.cache/MyVim'.(g:is_root ? '-root' : '-alan').'/undofile'
  let s:backupdir = g:is_win ? 'D:/.cache/Vim/backup' :
        \ g:linux_home. '.cache/MyVim'.(g:is_root ? '-root' : '-alan').'/backup'
  let s:swapdir   = g:is_win ? 'D:/.cache/Vim/swap' :
        \ g:linux_home. '.cache/MyVim'.(g:is_root ? '-root' : '-alan').'/swap'
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
