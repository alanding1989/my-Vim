"
"
"
" function! s:hi_one(group) abort
"   let attrs = {
"         \ 'guifg'   : 0,
"         \ 'guibg'   : 1,
"         \ 'ctermfg' : 2,
"         \ 'ctermbg' : 3,
"         \ 'italic'  : 4
"         \ }
"   let cmdlist = []
"   for [attr, idx] in items(attrs)
"     if idx != 4
"       let val = s:color[a:group][idx]
"       let cmd = val != -1 ? attr. '='. val : ''
"       call add(cmdlist, cmd)
"     else
"       let cmd = s:color[a:group][4] ? 'gui=italic cterm=italic' : ''
"       call add(cmdlist, cmd)
"     endif
"   endfor
"   let sta = 'hi! '. a:group .' '. join(cmdlist, ' ')
"   exec sta
"   return sta
" endfunction
"
"
"
" function! s:defhighlight() abort
"   " [ guifg, guibg, ctermfg, ctermbg, italic]
"   " -1 if None or negative
"   let s:color = {
"         \ 'pythonSelf'     : [ '#61afef',  -1,  75,  -1,  1 ],
"         \ 'pythonClassVar' : [ '#61afef',  -1,  75,  -1,  1 ],
"         \ }
"
"   " fix python syntax highlighting
"   syntax keyword pythonSelf self
"
"   let syntaxcmds = []
"   for group in keys(s:color)
"     call add(syntaxcmds, s:hi_one(group))
"   endfor
"   return syntaxcmds
" endfunction
"
" " call s:defhighlight()
"
"
" " hi! pythonSelf       gui=italic guifg=#61afef cterm=italic ctermfg=75
" "
" " if g:is_vim8
" "   " python-syntax
" "   hi! pythonClassVar gui=italic guifg=#61afef cterm=italic ctermfg=75
" " endif
"
" " hi semshiLocal           ctermfg=209 guifg=#ff875f
" " hi semshiGlobal          ctermfg=214 guifg=#ffaf00
" " hi semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold
" " hi semshiParameter       ctermfg=75  guifg=#5fafff
" " hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
" " hi semshiFree            ctermfg=218 guifg=#ffafd7
" " hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
" " hi semshiAttribute       ctermfg=49  guifg=#00ffaf
" " hi semshiSelf            ctermfg=249 guifg=#b2b2b2
" " hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
" " hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f
" "
" " hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
" " hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
" " sign define semshiError text=E> texthl=semshiErrorSign
