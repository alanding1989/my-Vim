"=============================================================================
" tags.vim --- tags layer
" Section: layer
"=============================================================================
scriptencoding utf-8


function! layers#tags#plugins() abort
  let plugins = []
  if !executable('ctags')
    echohl WarningMsg
    echo ' ctags is not executable, you need to install ctags first!'
    echohl NONE
    return plugins
  endif
  let plugins = [
        \ [ 'ludovicchabant/vim-gutentags',                                          {'merged': 0}],
        \ [ 'skywind3000/gutentags_plus'  , {'on_cmd': 'GscopeFind'     , 'on': 'GscopeFind'     }],
        \ [ 'skywind3000/vim-preview'     , {'on_cmd': 'PreviewQuickfix', 'on': 'PreviewQuickfix'}],
        \ ]
  call add(plugins, ['liuchengxu/vista.vim', {'on_cmd': 'Vista!!', 'on': 'Vista!!'}])
  return plugins
endfunction


function! layers#tags#config() abort
  set tags=./.tags;,.tags
  " gtags
  let $GTAGSLABEL = 'native-pygments'
  let $GTAGSCONF  = expand('~/.globalrc')
  " Cscope
  set cscopetag                  " 使用 cscope 作为 tags 命令
  if executable('gtags-cscope')
    set cscopeprg='gtags-cscope'   " 使用 gtags-cscope 代替 cscope
  endif
  call s:gutentags_plus()

  augroup layer_tags
    auto VimEnter * nnoremap <silent><F2> :Vista!!  \| doautocmd WinEnter<CR>
          \ | auto FileType markdown
          \         nnoremap <silent><F2> :Vista toc\| doautocmd WinEnter<CR>
    auto FileType vista_kind nnoremap <buffer> <silent> o :<C-u>call vista#cursor#FoldOrJump()<CR>
    auto FileType qf nnoremap <silent><buffer> p   :PreviewQuickfix<CR>
    auto FileType qf nnoremap <silent><buffer> pq  :PreviewClose<CR>
    " auto VimEnter *  nnoremap <F11> :PreviewSignature!<CR>
  augroup END
endfunction


" gutentags_plus {{{
function! s:gutentags_plus() abort
  if g:is_spacevim
    let g:_spacevim_mappings.g  = {'name': '+@ Gtags' }
    call SpaceVim#mapping#def('nnoremap', '<leader>gs', ":GscopeFind s \<C-R>\<C-W><CR>"                 , 'find symbol (reference)'           , '', 'find symbol (reference)')
    call SpaceVim#mapping#def('nnoremap', '<leader>gg', ":GscopeFind g \<C-R>\<C-W><CR>"                 , 'goto definition'                   , '', 'goto definition ')
    call SpaceVim#mapping#def('nnoremap', '<leader>gd', ":GscopeFind d \<C-R>\<C-W><CR>"                 , 'find funcs called by this func'    , '', 'find funcs called by this func')
    call SpaceVim#mapping#def('nnoremap', '<leader>gc', ":GscopeFind c \<C-R>\<C-W><CR>"                 , 'find funcs calling this func'      , '', 'find funcs calling this func')
    call SpaceVim#mapping#def('nnoremap', '<leader>gt', ":GscopeFind t \<C-R>\<C-W><CR>"                 , 'find text string'                  , '', 'find text string')
    call SpaceVim#mapping#def('nnoremap', '<leader>ge', ":GscopeFind e \<C-R>\<C-W><CR>"                 , 'find egrep pattern'                , '', 'find egrep pattern')
    call SpaceVim#mapping#def('nnoremap', '<leader>gf', ":GscopeFind f \<C-R>=expand('\<cfile>')<CR><CR>", 'goto file'                         , '', 'goto file')
    call SpaceVim#mapping#def('nnoremap', '<leader>gi', ":GscopeFind i \<C-R>=expand('\<cfile>')<CR><CR>", 'find files including the file name', '', 'find files including the file name')
    call SpaceVim#mapping#def('nnoremap', '<leader>ga', ":GscopeFind a \<C-R>\<C-W><CR>"                 , 'goto symbol assigned place'        , '', 'goto symbol assigned place')
  else
    " Find symbol (reference) under cursor
    nnoremap <silent> <leader>gs :GscopeFind s <C-R><C-W><CR>
    " Find symbol definition under cursor
    nnoremap <silent> <leader>gg :GscopeFind g <C-R><C-W><CR>
    " Functions called by this function
    nnoremap <silent> <leader>gd :GscopeFind d <C-R><C-W><CR>
    " Functions calling this function
    nnoremap <silent> <leader>gc :GscopeFind c <C-R><C-W><CR>
    " Find text string under cursor
    nnoremap <silent> <leader>gt :GscopeFind t <C-R><C-W><CR>
    " Find egrep pattern under cursor
    nnoremap <silent> <leader>ge :GscopeFind e <C-R><C-W><CR>
    " Find file name under cursor
    nnoremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<CR><CR>
    " Find files including the file name under cursor
    nnoremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<CR><CR>
    " Find places where current symbol is assigned
    nnoremap <silent> <leader>ga :GscopeFind a <C-R><C-W><CR>
  endif
endfunction "}}}
