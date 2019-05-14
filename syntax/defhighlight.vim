syntax clear

syn  keyword  MyAttr      guifg guibg ctermfg cermbg gui cterm
syn  match    MyTitle     /\w.*\s:$/      contained
syn  match    HiGroup     /^[a-zA-Z]*\s*/ contains=MyTitle
syn  match    MyEqual     /=/
syn  match    MyGuiVal    /#[0-9a-z]\{5,6\}/
syn  match    MyCtermVal  /\d\{1,3}/


hi def link   MyTitle     Identifier  
hi def link   MyFt        Title
hi def link   MyAttr      Repeat
hi def link   HiGroup     Type
hi def link   MyGuiVal    String
hi def link   MyEqual     Operator
hi def link   MyCtermVal  Number  
