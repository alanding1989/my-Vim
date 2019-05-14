hi semshiLocal           ctermfg=209 guifg=#ff875f
hi semshiGlobal          ctermfg=214 guifg=#ffaf00
hi semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold
hi semshiParameter       ctermfg=75  guifg=#5fafff
hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
hi semshiFree            ctermfg=218 guifg=#ffafd7
hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
hi semshiAttribute       ctermfg=49  guifg=#00ffaf
hi semshiSelf            ctermfg=249 guifg=#b2b2b2
hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f

hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
sign define semshiError text=E> texthl=semshiErrorSign


" [ guifg, guibg, ctermfg, ctermbg, italic, bold], -1 if None or negative
let g:_defhighlight_var = { 'hlcolor' : {
      \ 'python' : {
      \    'semshiLocal'    : [ '#fd971f',  -1,  -1,  -1, 0, 0],
      \    'semshiImported' : [ '#f92672',  -1,  -1,  -1, 0, 1],
      \    'semshiSelf'     : [ '#df5fdb',  -1,  -1,  -1, 1, 0],
      \    'semshiBuiltin'  : [ '#14cfcf',  -1,  -1,  -1, 0, 0],
      \    'pythonSelf'     : [ '#df5fdb',  -1,  -1,  -1, 1, 0],
      \    'pythonClassVar' : [ '#61afef',  -1,  -1,  -1, 0, 0],
      \ },
      \ }}
