"================================================================================
" bootstrap.vim -- for init.toml entry
" Section: MySpaceVim
"================================================================================
scriptencoding utf-8



function! MySpaceVim#bootstrap#before() abort
  " load minimal setting
  let g:home = glob('~/.SpaceVim.d/')
  call default#load()

endfunction


function! MySpaceVim#bootstrap#after() abort
  call SpaceVim#custom#Reg_langSPC('vim', function('s:language_specified_mappings'))
  call util#so_file('keymap.vim', 'SPC')
  call s:loadconfig(['core', 'autocomplete'])

endfunction


function! s:loadconfig(list) abort
  for layer in a:list
    try
      call layers#{layer}#config()
    catch
      call layer#core#config()
    endtry
  endfor
endfunction


function! s:language_specified_mappings() abort
  call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 't'],
        \ 'call setline(line("$"), "\" vim:set sw=2 ts=2 sts=2 et tw=78 fmd=marker")',
        \ 'insert Vim file tail', 1)
  call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'a'], 'call call('
        \ . string(s:_function('s:addParam')) . ', [])',
        \ '@ add debug Parameter', 1)
endfunction


" function() wrapper "{{{
if v:version > 703 || v:version == 703 && has('patch1170')
  function! s:_function(fstr) abort
    return function(a:fstr)
  endfunction
else
  function! s:_SID() abort
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze__SID$')
  endfunction
  let s:_s = '<SNR>' . s:_SID() . '_'
  function! s:_function(fstr) abort
    return function(substitute(a:fstr, 's:', s:_s, 'g'))
  endfunction
endif "}}}
