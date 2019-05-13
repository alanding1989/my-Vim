" ================================================================================
" autocmds.vim
" ================================================================================
scriptencoding utf-8



augroup edit_related
  auto!
  autocmd BufNewFile * call SetFileHead()
  " put cursor at last edit position when open file
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exec "normal! g`\"" | endif
augroup END


augroup colorscheme_related
  auto!
  " italic matched paren e.g. if-endif
  autocmd ColorScheme one         hi clear Folded | hi Folded ctermfg=59  guifg=#5C6370
  autocmd ColorScheme OceanicNext hi clear Folded | hi Folded ctermfg=243 guifg=#65737e
        \                       | hi Cursorline ctermbg=16 guibg=#2c323c
  autocmd ColorScheme *           hi MatchParen cterm=italic,bold gui=italic,bold
        \                       | hi Folded cterm=italic gui=italic | hi Comment cterm=italic gui=italic
augroup END


if g:has_terminal && !g:is_spacevim
  if exists('##TerminalOpen')
    augroup Unixterminal_related
      auto!
      autocmd TerminalOpen * setl nonumber signcolumn=no
    augroup END
  endif
endif
