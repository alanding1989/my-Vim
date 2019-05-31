"================================================================================
" File Name    : autoload/layers/defhighlight.vim
" Author       : AlanDing
" Created Time : Mon 13 May 2019 09:37:00 PM CST
"================================================================================
scriptencoding utf-8



function! layers#defhighlight#plugins() abort
  let plugins = []
  return plugins
endfunction


function! layers#defhighlight#config() abort
  if len(s:hlcolor) > 0
    for [ft, colors] in items(s:hlcolor)
      if ft ==# 'general'
        exec 'auto BufWinEnter * if <sid>checkft() |
              \ call s:highlight_apply('.string(ft).', '.string(colors).') | endif'
      else
        exec 'auto FileType '.ft.' call s:highlight_apply('.string(ft).', '.string(colors).')'
        exec 'auto FileType '.ft.' let b:current_syntax = '.string(ft)
      endif
    endfor
  endif

  if g:is_spacevim
    let g:_spacevim_mappings.a = {'name' : '+@ Session/Setting/Select'}
    call SpaceVim#mapping#def('nnoremap', '<leader>ah', ':call layers#defhighlight#test()<CR>',
          \ 'test custom highlight def', '', 'test custom highlight def')
  else
    nnoremap <silent><leader>ah :call layers#defhighlight#test()<CR>
  endif
endfunction

function! s:checkft() abort
  if empty(&ft)
    return 0
  endif
  let ftblacklist = ["vim", "startify", "help", 
        \ "qf", "defx", "vimfiler", "vista_kind"]
  if s:enable_vim_highlight
    call remove(ftblacklist, 0)
  endif
  let check = 0
  for ft in ftblacklist
    if &ft !=? ft
      let check = 1
      continue
    else
      let check = 0
      break
    endif
  endfor
  return check
endfunction

let s:hlcmds = {}
function! s:highlight_apply(ft, colors) abort
  let ftcmds = {}
  let ftcmds[a:ft] = []
  for [group, attr_val] in items(a:colors)
    call add(ftcmds[a:ft], <sid>hl_one(group, attr_val))
  endfor
  call extend(s:hlcmds, ftcmds)
endfunction

function! s:hl_one(group, attr_val) abort
  " a:group       highlight group
  " a:attr_val    value
  let attrs = {
        \ 'guifg'   : 0,
        \ 'guibg'   : 1,
        \ 'ctermfg' : 2,
        \ 'ctermbg' : 3,
        \ 'italic'  : 4,
        \ 'bold'    : 5
        \ }
  let strlist = []
  for [attr, idx] in reverse(items(attrs))
    if idx != 4 && idx != 5
      let cmd = a:attr_val[idx] != -1 ? attr. '=' .a:attr_val[idx] : ''
      call add(strlist, cmd)
    elseif idx == 4
      let cmdi = a:attr_val[4] ? 'gui=italic cterm=italic' : ''
    elseif idx == 5
      let cmdb = a:attr_val[5] ? 'gui=bold cterm=bold'     : ''
    endif
  endfor
  call add(strlist, cmdi) | call add(strlist, cmdb)
  exec 'hi! '. a:group .' '. join(strlist, ' ')

  " format hlcmds
  let hlcmd = a:group .repeat(' ', 20-len(a:group)). join(strlist, ' ')
  return hlcmd
endfunction


let s:hlcolor    = {}
let s:enable_vim_highlight = 0
function! layers#defhighlight#set_variable(var) abort
  " [ guifg, guibg, ctermfg, ctermbg, italic], -1 if None or negative
  let s:hlcolor = get(a:var, 'hlcolor', {})
  let s:enable_vim_highlight = get(a:var, 'enable_vim_highlight', 0)
endfunction


" TEST: {{{
function! layers#defhighlight#test(...) abort
  let hlcmds = get(s:, 'hlcmds', {})
  if len(hlcmds) == 0
    let fts = join(keys(s:hlcolor), ' ')
    echohl WarningMsg
    echo ' No customized highlight'
          \ . (empty(fts) ? '' : ', have you already opened a '. fts .' file ?')
    echohl NONE
    return
  endif
  topleft vsplit _Custom_Highlight_Cmds_
  nnoremap <silent><buffer> q  :q<CR>
  nnoremap <silent><buffer> qq :bd<CR>
  setlocal buftype=nofile nolist noswapfile nowrap cursorline nospell
  setlocal filetype=defhighlight
  let str = []
  if a:0 > 0
    let ft = toupper(a:1[0]) . a:1[1:]
    let info = [
          \ '',
          \ ft .' Highlight Commands :',
          \ '',
          \ ]
    let str = info + hlcmds[a:1]
  else
    for [ft, list] in items(hlcmds)
      let ft = toupper(ft[0]) . ft[1:]
      let info = [
            \ '',
            \ ft .' Highlight Commands :',
            \ '',
            \ ]
      let str = str + info + list
    endfor
  endif
  call setline(1, str)
  setl nomodifiable
endfunction
 " }}}
