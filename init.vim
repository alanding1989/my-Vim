"=============================================================================
" Entry file for Nvim
"=============================================================================


" vim home path
let g:home = fnamemodify(resolve(expand('<sfile>:p')), ':h').'/'



call default#load()

if g:is_spacevim
  " SpaceVim for nvim
  call MySpaceVim#Main#init()
else
  " My Vim
  call MyVim#Main#init()
endif

