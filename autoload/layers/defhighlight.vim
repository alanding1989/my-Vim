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
  if len(s:hlcolor) > 0
    for [ft, colors] in items(s:hlcolor)
      exec 'auto FileType '.ft.' call s:highlight_apply('.string(ft).', '.string(colors).')'
    endfor
  endif
endfunction


let s:hlcolor    = {}
function! layers#defhighlight#set_variable(var) abort
  " [ guifg, guibg, ctermfg, ctermbg, italic], -1 if None or negative
  let s:hlcolor = get(a:var, 'hlcolor', {})
endfunction


function! s:highlight_apply(ft, colors) abort
  let s:hlcmds = {}
  let s:hlcmds[a:ft] = []
  for [group, attr_val] in items(a:colors)
    call add(s:hlcmds[a:ft], <sid>hl_one(group, attr_val))
  endfor
  call map(items(a:colors), {key, val -> add(s:hlcmds[a:ft], <sid>hl_one(key, val))})
endfunction

function! s:hl_one(group, attr_val) abort
  let attrs = {
        \ 'guifg'   : 0,
        \ 'guibg'   : 1,
        \ 'ctermfg' : 2,
        \ 'ctermbg' : 3,
        \ 'italic'  : 4
        \ }
  let cmdlist = []
  for [attr, idx] in reverse(items(attrs))
    if idx != 4
      let cmd = a:attr_val[idx] != -1 ? attr. '=' .a:attr_val[idx] : ''
      call add(cmdlist, cmd)
    else
      let cmdi = a:attr_val[4] ? 'gui=italic cterm=italic' : ''
    endif
  endfor
  call add(cmdlist, cmdi)
  let g:statement = 'hi! '. a:group .' '. join(cmdlist, ' ')
  exec g:statement
  return g:statement
endfunction

function! layers#defhighlight#test_highlightcmds(...) abort
  let hlcmds = get(s:, 'hlcmds', {})
  if len(hlcmds) > 0
    let cmds = a:0 > 0 ? hlcmds[a:1] : hlcmds
  else
    let fts = join(keys(s:hlcolor), ' ')
    echohl WarningMsg
    echo ' No customized highlight, have you already opened a '. fts .' file ?'
    echohl NONE
    return
  endif
  topleft vsplit CustomizedHighlightCmds
  nnoremap <buffer> q :q<cr>
  nnoremap <silent> <buffer> qd :bd<CR>
  setlocal buftype=nofile nolist noswapfile nowrap cursorline nospell
  if type(cmds) == type([])
    call setline(1, info + hlcmds)
  else
    let line = 1
    for [ft, list] in items(cmds)
      let info = [
            \ ft .' Highlight Commands :',
            \ '',
            \ ]
      call setline(line, info + list)
      let line = line + len(info) + len(list) + 1
    endfor
  endif
  setl nomodifiable
endfunction
