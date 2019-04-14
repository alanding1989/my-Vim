" ================================================================================
" General environment check
" ================================================================================
scriptencoding utf-8


let g:is_mac              = has('mac') || has('osx')
let g:is_unix             = (has('mac') || has('osx')) + has('unix')
let g:is_win              = (has('win32') || has('win32unix')) + has('win64')
let g:is_win32            = g:is_win == 1
let g:is_win64            = g:is_win == 2
let g:is_nvim             = has('nvim')
let g:is_vim8             = v:version >= 800 && !g:is_nvim
let g:is_gui              = has('gui_running') + has('gui_macvim')
let g:is_macvim           = g:is_gui == 2
let g:is_spacevim         = exists('g:spacevim_version')
let g:is_async            = g:is_vim8 || g:is_nvim
let g:has_timer           = has('timers')
let g:has_display         = empty($DISPLAY)
let g:has_terminal        = g:is_nvim || (has('patch-8.0.1108') && has('terminal'))

let g:project_root_marker = ['.root', '.project', '.idea', '.vscode',
      \ '.svn', '.git', '.hg', '.bzr', '_darcs']


if g:is_unix || g:is_mac
  " linux
  let g:vim_plugindir       = g:home.'config/Vim/plugins/'
  let g:ruby_host_prog      = exepath('neovim-ruby-host')
  let g:node_host_prog      = exepath('neovim-node-host')
  let g:python_host_prog    = '/home/alanding/software/anaconda3/envs/py27/bin/python2.7'
  let g:python3_host_prog   = '/home/alanding/software/anaconda3/envs/py36/bin/python3.6'
else
" windows
  let g:vim_plugindir       = g:home.'config\Vim\plugins\'
  let g:ruby_host_prog      = exepath('neovim-ruby-host')
  let g:node_host_prog      = exepath('neovim-node-host')
  let g:python_host_prog    = 'D:\devtools\python\Anaconda3\envs\py27\python'
  let g:python3_host_prog   = 'D:\devtools\python\Anaconda3\envs\py36\python'
endif

" vim only
if !g:is_nvim && has('pythonx')
  set pyxversion=3
endif
