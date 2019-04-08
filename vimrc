"=============================================================================
" Entry file for Vim
"=============================================================================


" vim home path
let g:home = fnamemodify(resolve(expand('<sfile>:p')), ':h').'/'



call default#load()

if g:is_spacevim
  " SpaceVim for nvim
  call My_SpaceVim#Main#init()
" elseif !g:is_win
else
  " My Vim
  call My_Vim#Main#init()
endif
