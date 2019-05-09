" ================================================================================
" General environment setting
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
let g:is_root             = $USER ==# 'root' || $USERNAME ==# 'Administrator'

let g:github_username     = 'alanding1989'
let g:project_root_marker = ['.root', '.project', '.idea', '.vscode',
      \ '.svn', '.git', '.hg', '.bzr', '_darcs']
let g:vim_plugindir       = expand(g:home.'config/Vim/plugins/')
" if use init.toml, it will not source <g:home.'config/SpaceVim/config.vim'>
" so add g:spacevim_plugin_bundle_dir here
if g:is_spacevim
  let g:spacevim_plugin_bundle_dir = g:is_win ? 'D:\.cache\vimfiles\' :
        \ '/home/alanding/.cache/vimfiles'.(g:is_root ? '-root/' : '-alan/')
endif


" python provider {{{
" neovim
if g:is_unix || g:is_mac
  " linux
  let g:ruby_host_prog      = '/home/alanding/.rbenv/shims/neovim-ruby-host'
  let g:node_host_prog      = '/opt/lang-tools/nvm/versions/node/v11.9.0/bin/neovim-node-host'
  let g:python_host_prog    = '/home/alanding/software/anaconda3/envs/py27/bin/python2.7'
  let g:python3_host_prog   = '/home/alanding/software/anaconda3/envs/py36/bin/python3.6'
else
  " windows
  let g:ruby_host_prog      = exepath('neovim-ruby-host')
  let g:node_host_prog      = exepath('neovim-node-host')
  let g:python_host_prog    = 'D:\devtools\python\Anaconda3\envs\py27\python.exe'
  let g:python3_host_prog   = 'D:\devtools\python\Anaconda3\envs\py36\python.exe'
endif

" vim only
if !g:is_nvim
  set pyxversion=3
  if g:is_unix || g:is_mac
    " linux
    " set pythonthreedll=/home/alanding/software/anaconda3/envs/py36/lib/libpython3.so
  else
    " windows
    set pythonthreedll=D:\devtools\python\Anaconda3\envs\py36\python36.dll
    set pythonthreehome=D:\devtools\python\Anaconda3\envs\py36
  endif
endif
"}}}

let g:has_py              = has('python3')
