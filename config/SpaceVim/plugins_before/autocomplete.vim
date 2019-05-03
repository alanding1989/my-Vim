"================================================================================
" File Name    : config/SpaceVim/plugins_before/autocomplete.vim
" description  : autocomplete layers global settings
" NOTE: only for SpaceVim
"================================================================================
scriptencoding utf-8


"--------------------------------------------------------------------------------
" autocomplete method
"--------------------------------------------------------------------------------
" NOTE: SpaceVim use deoplete by default

" coc
if g:spacevim_autocomplete_method ==# 'coc'
  exec 'so '.g:vim_plugindir.'coc.vim'
endif

" deoplete
if g:spacevim_autocomplete_method ==# 'deoplete'
  " Note: If the feature is 1, you can`t expand snippet
  " trigger manually when |pumvisible()|, in order to
  " prevent conflicts with |CompleteDone| expand.
  let g:neosnippet#enable_complete_done = 1
  let g:tmuxcomplete#trigger = ''
endif

" ncm2
if g:spacevim_autocomplete_method ==# 'ncm2'
  " NOTE: SpaceVim doesn`t has ncm2 settings,
  " use ncm2 in SpaceVim need to disable deoplete
  let g:deoplete#enable_at_startup = 0
  exec 'so '.g:vim_plugindir.'ncm2.vim'
endif

" asyncomplete
if g:spacevim_autocomplete_method ==# 'asyncomplete'
  exec 'so '.g:vim_plugindir.'asyncomplete.vim'
endif

" ycm
if g:spacevim_autocomplete_method ==# 'ycm'
  exec 'so '.g:vim_plugindir.'YouCompleteMe.vim'
endif


"--------------------------------------------------------------------------------
" snippet
"--------------------------------------------------------------------------------
exec 'so '.g:vim_plugindir.'snippet.vim'


"--------------------------------------------------------------------------------
" other plugins for autocomplete layer
"--------------------------------------------------------------------------------
exec 'so '.g:vim_plugindir.'autocomp_plugins.vim'
