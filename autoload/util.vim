" ================================================================================
" util.vim
" ================================================================================
scriptencoding utf-8



" echo mapping rhs {{{
function! util#maparg_wrapper(...) abort
  if a:0 == 1 && a:1 ==# 'v'
    try
      " Scriptease plugin
      call feedkeys(':Verbose map ')
    catch
      call feedkeys(':verbose map ')
    endtry
  elseif a:0 == 1
    " n mode
    if !empty(maparg('<'.a:1.'>'))
      exec "echo maparg('<".a:1.">')"
    else
      exec "echo maparg('".a:1."')"
    endif
  elseif a:0 == 2 && a:1 !=# 'leader' && a:2 !=# 'spc'
    " specify mode
    if !empty(maparg('<'.a:1.'>', a:2))
      exec "echo maparg('<".a:1.">', '".a:2."')"
    elseif !empty(maparg(a:1, a:2))
      exec "echo maparg('".a:1."', '".a:2."')"
    endif
  elseif a:0 == 2 && a:1 ==# 'leader'
    " n mode
    exec "echo maparg('<".a:1.'>'.a:2."', 'n')"
    " SPC
  elseif a:0 == 2 && a:2 ==# 'spc'
    exec "echo maparg('[SPC]".a:1."', 'n')"
  elseif a:0 == 3 && a:3 ==# 'spc'
    exec "echo maparg('[SPC]".a:1."', '".a:2."')"
    " specify mode
  elseif a:0 == 3
    exec "echo maparg('<".a:1.'>'.a:2."', '".a:3."')"
  endif
endfunc "}}}


" source config/*.vim files {{{
function! util#so_file(path, ...) abort
  let gen_p  = glob(g:home.'config/'.a:path)
  let SPC_p  = glob(g:home.'config/SpaceVim/'.a:path)
  let Vim_p  = glob(g:home.'config/Vim/'.a:path)
  let arbi_p = glob(g:home.a:path)
  let g:home = glob(g:home)
  if a:1 ==# 'g' && s:filereadable(gen_p)
    exec 'so ' gen_p
  elseif a:1 ==# 'SPC' && s:filereadable(SPC_p)
    exec 'so ' SPC_p
  elseif a:1 ==# 'Vim' && s:filereadable(Vim_p)
    exec 'so ' Vim_p
  elseif s:filereadable(arbi_p)
    exec 'so ' arbi_p
  endif
endfunc
function! s:filereadable(path) abort
  if filereadable(a:path)
    return 1
  else
    echohl WarningMsg
    echo ' invalid file name, please check!'
    echohl NONE
    return 0
  endif
endfunction
"}}}


function! util#path(path) abort
  " return resolve(expand(a:path))
  return glob(a:path)
endfunction


" help wrapper {{{
function! util#help_wrapper(...) abort
  if &ft ==# 'vim' || &ft ==# 'startify'
    if g:is_nvim
      let input = input({
            \ 'prompt'      : 'help keyword: ',
            \ 'completion'  : 'help'          ,
            \ 'cancelreturn': 1               ,
            \ })
      if input == 1 | return | endif
    else
      let input = input('help keyword: ', '', 'help')
    endif
    let cword = expand('<cword>')

    if empty(input) && !empty(cword)
      exec ':vert bo help '.cword
    elseif input ==? 'f' && !empty(cword)
      exec ':help '.cword | exec ':resize'
    elseif !empty(input)
      try
        let input0 = split(input)[0]
        let input1 = split(input)[1]
        if input1 ==# 'f'
          exec ':help '.input0 | exec ':resize'
        endif
      catch
        exec ':vert bo help '.input
      endtry
    endif
  else
    call CocActionAsync('doHover')
  endif
endfunc "}}}


" highlight wrapper {{{
function! util#hlight_wrapper(mode) abort
  if a:mode ==# 'c'
    exec ':highlight '.expand('<cword>')
  else
    exec ':highlight'
  endif
endfunction " }}}


" SpaceVim test mode {{{
function! util#test_SPC(...) abort
  if empty(glob(g:home.'init.toml'))
    !cp $HOME/.SpaceVim.d/backup/root/.SpaceVim.d/init.toml $HOME/.SpaceVim.d
    !cd $HOME/.SpaceVim
    !git checkout master
    " echo ' Test environment is on!'
  elseif filereadable(g:home.'init.toml')
    !rm -rf $HOME/.SpaceVim.d/init.toml
    !cd $HOME/.SpaceVim
    !git checkout myspacevim
    " echo ' Test environment is off'
  endif
endfunction "}}}


" function() wrapper for memo "{{{
" change relative s: to abs <SNR>
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
