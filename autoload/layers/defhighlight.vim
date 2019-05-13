"================================================================================
" File Name    : autoload/layers/defhighlight.vim
" Author       : AlanDing
" mail         : 
" Created Time : Mon 13 May 2019 09:37:00 PM CST
"================================================================================
scriptencoding utf-8



function! layers#defhighlight#plugins() abort
  return
endfunction


function! layers#defhighlight#config() abort
  if len(s:hicolor) > 0
    for [ft, colors] in items(s:hicolor)
      augroup layer_defhighlight
        autocmd!
        auto FileType ft call <sid>highlight_apply(ft, colors)
      augroup END
    endfor
  endif
endfunction


let s:syntaxcmds = {}
let s:hicolor    = {}
function! layers#defhighlight#set_variable(var) abort
  " [ guifg, guibg, ctermfg, ctermbg, italic]
  " -1 if None or negative
  let s:hicolor = get(a:var, 'hicolor', {})
endfunction

function! layers#defhighlight#get_variable() abort
  return s:
endfunction


function! s:highlight_apply(ft, colors) abort
  if a:ft ==# 'python'
    " fix python syntax highlighting
    syntax keyword pythonSelf self
  endif
  let s:syntaxcmds[a:ft] = []
  for [group, attr_val] in items(a:colors)
    call add(s:syntaxcmds[a:ft], <sid>hi_one(group, attr_val))
  endfor
endfunction

function! s:hi_one(group, attr_val) abort
  let attrs = {
        \ 'guifg'   : 0,
        \ 'guibg'   : 1,
        \ 'ctermfg' : 2,
        \ 'ctermbg' : 3,
        \ 'italic'  : 4
        \ }
  let cmdlist = []
  for [attr, idx] in items(attrs)
    if idx != 4
      let cmd = a:attr_val[idx] != -1 ? attr. '=' .a:attr_val[idx] : ''
      call add(cmdlist, cmd)
    else
      let cmd = a:attr_val[4] ? 'gui=italic cterm=italic' : ''
      call add(cmdlist, cmd)
    endif
  endfor
  let g:alan = join(sort(deepcopy(cmdlist)), ' ')
  let g:blan = sort(join(deepcopy(cmdlist), ' '))
  let statement = 'hi! '. a:group .' '. join(cmdlist, ' ')
  exec statement
  return statement
endfunction
