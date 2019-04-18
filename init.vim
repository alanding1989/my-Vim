"=============================================================================
" Entry file for Nvim
"=============================================================================


" vim home path
let g:home = fnamemodify(resolve(expand('<sfile>:p')), ':h').'/'
" choose minimal setting
let g:tiny = 0



call default#load()

if g:is_spacevim && !g:tiny
  " SpaceVim for nvim
  call My_SpaceVim#Main#init()
else
  " My Vim
  call My_Vim#Main#init()
endif
