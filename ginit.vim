"=============================================================================
" ginit.vim --- for neovim-qt
"=============================================================================
if g:is_spacevim
  finish
endif

if exists('g:GuiLoaded')
  if empty(g:guifont)
    exe 'Guifont! SauceCodePro Nerd Font Mono:h11:cANSI:qDRAFT'
  else
    exe 'Guifont! ' . g:guifont
  endif
  " As using neovim-qt by default

  " Disable gui popupmenu
  if exists(':GuiPopupmenu') == 2
    GuiPopupmenu 0
  endif

  " Disbale gui tabline
  if exists(':GuiTabline') == 2
    GuiTabline 0
  endif

  " colorscheme {{{
  if g:my_cs !=# ''
    try
      exec 'set background=' . g:my_bg
      exec 'colorscheme ' . g:my_cs
    catch
      exec 'colorscheme '. g:my_cs
    endtry
  else
    exec 'colorscheme '. g:my_cs
  endif
  auto ColorScheme *
        \ hi! clear SpellBad                     |
        \ hi! clear SpellCap                     |
        \ hi! clear SpellRare                    |
        \ hi! SpellBad  gui=undercurl guisp=red  |
        \ hi! SpellCap  gui=undercurl guisp=blue |
        \ hi! SpellRare gui=undercurl guisp=magenta
endif


" vim:set et sw=2:
