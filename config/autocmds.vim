" ================================================================================
" autocmds.vim
" ================================================================================
scriptencoding utf-8



augroup edit_related
  auto!
  " add filehead
  autocmd BufNewFile
        \ *.cpp,*.c,*.sh,*.py,*.ipynb,*.scala,*.java,*.vim
        \ exec ':call SetFileHead()'

  " put cursor at last edit position when open file
  auto BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \	 exe "normal! g`\"" |
        \ endif
augroup END


augroup colorscheme_related

  " italic matched paren e.g. if-endif
  auto ColorScheme * hi MatchParen cterm=italic gui=italic cterm=bold
augroup END


if g:has_terminal && !g:is_spacevim
  if exists('##TerminalOpen')
    augroup Unixterminal_related
      auto!
      autocmd TerminalOpen * setl nonumber signcolumn=no
    augroup END
  endif
endif
