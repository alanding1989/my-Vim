" ================================================================================
" autocmds.vim
" ================================================================================
scriptencoding utf-8



augroup edit_related
  auto!
  " put cursor at last edit position when open file
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exec "normal! g`\"" 
        \ | endif
augroup END


augroup highlight_related
  auto!
  autocmd ColorScheme one         hi clear Folded | hi Folded guifg=#5C6370 ctermfg=59
  autocmd ColorScheme PaperColor  hi clear Folded | hi Folded guifg=#5C6370 ctermfg=59
  autocmd ColorScheme gruvbox     hi clear Folded | hi Folded guifg=#928374 ctermfg=245
  autocmd ColorScheme OceanicNext hi clear Folded | hi Folded guifg=#65737e ctermfg=243
        \                       | hi  Cursorline  guibg=#2c323c    ctermbg=16
  autocmd ColorScheme *           hi! MatchParen  gui=italic,bold  cterm=italic,bold
        \                       | hi! Folded      gui=italic       cterm=italic
        \                       | hi! Comment     gui=italic       cterm=italic
        \                       | hi! String      guifg=#98c379  guibg=#3c3836  gui=italic  cterm=italic
augroup END


if g:has_terminal && !g:is_spacevim
  if exists('##TerminalOpen')
    augroup Unixterminal_related
      auto!
      autocmd TerminalOpen * setl nonumber signcolumn=no
    augroup END
  endif
endif
