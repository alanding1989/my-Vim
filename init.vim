"=============================================================================
" Entry file for Nvim
"=============================================================================


" vim home path
let g:home = fnamemodify(resolve(expand('<sfile>:p')), ':h').'/'



call default#load()

if g:is_spacevim
  " SpaceVim for nvim
  call My_SpaceVim#Main#init()
else
  " My Vim
  call My_Vim#Main#init()
endif
