"=============================================================================
" vim.vim --- vim layer
" Parent Section: layers/lang
"=============================================================================
scriptencoding utf-8


let s:SID = SpaceVim#api#import('vim#sid')


function! layers#lang#vim#plugins() abort
  let plugins = []
  if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'ncm2'
    call add(plugins, ['ncm2/ncm2-vim', {'on_event': 'InsertEnter'}])
  endif
  if !g:is_spacevim
    if !layers#lsp#check_ft('vim')
      let plugins += [
            \ ['wsdjeg/vim-lookup',                                   {'merged' : 0}],
            \ ['tweekmonster/exception.vim',                          {'merged' : 0}],
            \ ['syngan/vim-vimlint',                 {'on_ft' : 'vim', 'for': 'vim'}],
            \ ['ynkdir/vim-vimlparser',              {'on_ft' : 'vim', 'for': 'vim'}],
            \ ['todesking/vint-syntastic',           {'on_ft' : 'vim', 'for': 'vim'}],
            \ ]
    endif
    call add(plugins,['tweekmonster/helpful.vim', {'on_cmd'  : 'HelpfulVersion'}])
    call add(plugins,['Shougo/neco-vim',          {'on_event': 'InsertEnter'   }])
    if g:autocomplete_method ==# 'coc'
      call add(plugins, ['neoclide/coc-neco', {'merged': 0}])
    elseif g:autocomplete_method ==# 'asyncomplete'
      call add(plugins, ['prabirshrestha/asyncomplete-necovim.vim', {'merged': 0}])
    endif
  endif
  return plugins
endfunction

function! layers#lang#vim#config() abort
  if g:is_spacevim
    call SpaceVim#mapping#gd#add('vim', function('s:go_to_def'))
    call SpaceVim#custom#Reg_langSPC('vim', function('s:language_specified_mappings'))
  else
    augroup layer_lang_vim
      autocmd!
      autocmd FileType vim call s:language_specified_mappings()
    augroup END
  endif
endfunction

function! s:language_specified_mappings() abort
  nnoremap <buffer> <F1> :update<CR>:source %<CR>
  if g:is_spacevim
    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 't'],
          \ 'call setline(line("$"), "\" vim:set sw=2 ts=2 sts=2 et tw=78 fmd=marker")',
          \ 'insert Vim file tail', 1)
  else
    nnoremap <buffer><silent> gd          :call <sid>go_to_def()<CR>
    nnoremap <buffer><silent> <Space>it   :call append(line('.'), ' vim:set sw=2 ts=2 sts=2 et tw=78 fmd=marker')<CR>
    nnoremap <buffer><silent> <space>le   :call <sid>eval_cursor()<CR>
    nnoremap <buffer><silent> <space>lv   :call <sid>helpversion_cursor()<CR>
    nnoremap <buffer><silent> <space>lf   :call exception#trace()<CR>
  endif
endfunction

function! s:eval_cursor() abort
  let is_keyword = &iskeyword
  set iskeyword+=:
  set iskeyword+=(
  let cword = expand('<cword>')
  if cword =~# '^g:'
    echo  cword . ' is ' eval(cword)
    " if is script function
  elseif cword =~# '^s:' && cword =~# '('
    let sid = s:SID.get_sid_from_path(expand('%'))
    if sid >= 1
      let func = '<SNR>' . sid . '_' . split(cword, '(')[0][2:] . '()'
      try
        echon 'Calling func:' . func . ', result is:' . eval(func)
      catch
        echohl WarningMsg
        echo 'failed to call func: ' . func
        echohl None
      endtry
    else
      echohl WarningMsg
      echo 'can not find SID for current script'
      echohl None
    endif
  else
    echohl WarningMsg
    echon 'can not eval script val:'
    echohl None
    echon cword
  endif
  let &iskeyword = is_keyword
endfunction

function! s:helpversion_cursor() abort
  exe 'HelpfulVersion' expand('<cword>')
endfunction

if g:is_spacevim
  function! s:go_to_def() abort
    if SpaceVim#layers#lsp#check_filetype('vim')
      call SpaceVim#lsp#go_to_def()
    else
      call lookup#lookup()
    endif
  endfunction
else
  function! s:go_to_def() abort
    if layers#lsp#check_ft('vim')
      call layers#lsp#go_to_def()
    else
      call lookup#lookup()
    endif
  endfunction
endif
