"================================================================================
" File Name    : autoload/mapping/util.vim
" Author       : AlanDing
" Created Time : Fri 17 May 2019 06:43:28 PM CST
"================================================================================
scriptencoding utf-8
  

function! mapping#util#jumpback(...) abort
  " a;1 funcref
  " a:2 motion, fparam
  let b:savemap = maparg('<C-o>', 'i')
  if a:0 == 2 && type(a:2) == type({})
    let i = 1
    for [motion, condition] in items(a:2)
      exec 'let b:_save_curpos'.i.' = getpos(".")'
      exec 'let b:motion'.i.' = motion'
      if call(a:1, condition)
        exec 'inoremap <buffer><expr><C-o> <sid>setpos(b:_save_curpos'.i.', b:savemap, b:motion'.i.')'
        let i += 1
      endif
    endfor
  endif
endfunction
function! <sid>setpos(pos, premap, motion) abort
  call setpos('.', a:pos)
  if !empty(a:premap)
    exec 'inoremap <buffer><C-o> '.a:premap
  else
    iunmap <buffer><C-o>
  endif
  return a:motion
endfunction

" function! mapping#util#JumpBack(...) abort
  " let sel_save = &selection
  " let &selection = 'exclusive'
  " let reg_save = @@
"
  " if a:0
    " silent exe 'normal! gvc'
  " else
    " silent exe 'normal! `[v`]c'
  " endif
  " startinsert
"
  " let &selection = sel_save
  " let @@ = reg_save
" endfunction

function! mapping#util#check_bs() abort
  let col = col('.') - 1
  return col > 0 || getline('.')[col('.')-2] !~# '\s'
endfunction
