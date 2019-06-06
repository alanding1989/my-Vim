"================================================================================
" ui.vim -- layer ui settings
"================================================================================
scriptencoding utf-8



if SpaceVim#layers#isLoaded('core#statusline')
  finish
endif

exec 'so '.g:vim_plugindir.'ui.vim'
