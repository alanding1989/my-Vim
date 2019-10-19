" ================================================================================
" autocmds.vim
" ================================================================================
scriptencoding utf-8



augroup edit_related
  auto!
  " put cursor at last edit position when open file
  autocmd BufReadPost * call s:goto_last_edit_line()

  " autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        " \ | exec "normal! g`\""
        " \ | endif
  autocmd BufWritePost init.toml source $MYVIMRC
augroup END

function! s:goto_last_edit_line() abort
  if line("'\"") > 1 && line("'\"") <= line("$")
     exec "normal! g`\"" 
  endif
endfunction

if g:has_terminal && !g:is_spacevim
  if exists('##TerminalOpen')
    augroup Unixterminal_related
      auto!
      autocmd TerminalOpen * setl nonumber signcolumn=no
    augroup END
  endif
endif
