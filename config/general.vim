" ===============================================================================
" General setting
" ===============================================================================
scriptencoding utf-8



"--------------------------------------------------------------------------------
" Environment Variables
"--------------------------------------------------------------------------------
let g:is_mac                       = has('mac') || has('osx')
let g:is_unix                      = (has('mac') || has('osx')) + has('unix')
let g:is_win                       = (has('win32') || has('win32unix')) + has('win64')
let g:is_win32                     = g:is_win == 1
let g:is_win64                     = g:is_win == 2
let g:is_nvim                      = has('nvim')
let g:is_vim8                      = v:version >= 800 && !g:is_nvim
let g:is_gui                       = has('gui_running') + has('gui_macvim')
let g:is_macvim                    = g:is_gui == 2
let g:is_spacevim                  = exists('g:spacevim_version')
let g:is_async                     = g:is_vim8 || g:is_nvim
let g:has_timer                    = has('timers')
let g:has_display                  = empty($DISPLAY)
let g:has_terminal                 = g:is_nvim || (has('patch-8.0.1108') && has('terminal'))
let g:is_root                      = $USER ==# 'root' || $USERNAME ==# 'Administrator'
let g:linux_home                    = '/home/alanding/'

" lang provider {{{
" neovim
if g:is_unix || g:is_mac
  " linux
  let g:ruby_host_prog             = g:linux_home. '.rbenv/shims/neovim-ruby-host'
  let g:node_host_prog             = '/opt/lang-tools/nvm/versions/node/v10.16.0/bin/neovim-node-host'
  let g:python_host_prog           = g:linux_home. 'software/lang-tools/python/anaconda3/envs/py27/bin/python2.7'
  let g:python3_host_prog          = g:linux_home. 'software/lang-tools/python/anaconda3/envs/py37/bin/python3.7'
else
  " windows
  let g:ruby_host_prog             = exepath('neovim-ruby-host')
  let g:node_host_prog             = exepath('neovim-node-host')
  let g:python3_host_prog          = 'D:\devtools\python\Anaconda3\envs\py36\python.exe'
endif

" vim
if !g:is_nvim
  if g:is_unix || g:is_mac
    set pythonthreedll=$HOME/software/lang-tools/python/anaconda3/envs/py37/lib/libpython3.7m.so
    " linux
  else
    " windows
    set pythonthreedll=D:\devtools\python\Anaconda3\envs\py36\python36.dll
    set pythonthreehome=D:\devtools\python\Anaconda3\envs\py36
  endif
endif
let g:has_py                       = has('python3')
"}}}


"--------------------------------------------------------------------------------
" Global Variables
"--------------------------------------------------------------------------------

" Ui {{{
let g:linter_error_symbol          = '❌'
let g:linter_warning_symbol        = '⚠️ '
let g:linter_info_symbol           = '➤'
let g:sidebar_width                = 25
let g:filetree_direction           = 'right'
let g:enable_cursorword            = (g:is_nvim || g:is_gui) ? 1 : 0
let g:enable_smart_clock_startup   = 0 && !g:is_win
let g:guifont                      = 'SauceCodePro Nerd Font Mono:h11'
" }}}

" System {{{
let g:cheats_dir                   = g:home.'cheats/'
let g:github_username              = 'alanding1989'
let g:vim_plugindir                = expand(g:home.'config/Vim/plugins/')
let g:project_root_marker          = ['.root', '.project', '.idea', '.vscode', '.editorconfig', '.git', '.svn']
let g:plugmanager                  = 'dein'
" if use init.toml, it will not source <g:home.'config/SpaceVim/config.vim'>
" must be /home/alanding, not root
let g:spacevim_plugin_bundle_dir   = g:is_win ? 'D:\.cache\vimfiles\'
      \ : g:linux_home. '.cache/vimfiles'. (g:is_root ? '-root/' : '-alan/')
let g:MyVim_plug_dir               = g:is_win ? 'D:\.cache\MyVim\'. g:plugmanager .'\'
      \ : g:linux_home. '.cache/MyVim'. (g:is_root ? '-root/' : '-alan/'). g:plugmanager .'/'
"}}}
