"================================================================================
" File Name    : config/highlight.vim
" Author       : AlanDing
" Created Time : Sat 25 May 2019 08:35:40 PM CST
" Description  : highlight customize
"================================================================================
scriptencoding utf-8




" Param: [guifg, guibg, ctermfg, ctermbg, italic, bold],
"        -1 if None or Negative.
"
let g:_defhighlight_var = { 'hlcolor' : {} }


" Default Highlight: {{{

" Util Function: {{{
function! s:addColor(dict, lang) abort
  for [key, val] in items(a:dict)
    let g:_defhighlight_var.hlcolor[a:lang][key] = val
  endfor
endfunction " }}}

" Define Color: " {{{
let s:Statement    = '#f92672'
let s:Conditional  = s:Statement
let s:Repeat       = s:Statement
let s:Label        = s:Statement
let s:Operator     = s:Statement
let s:Keyword      = s:Statement
let s:Exception    = s:Statement
let s:Include      = s:Statement
let s:Typedef      = s:Statement

let s:RawString    = '#b8bb26'
let s:String       = '#98c379'
let s:StringBack   = '#3b4048'
let s:Constant     = s:String
let s:Character    = s:String

let s:Number       = '#d19a66'
let s:Float        = s:Number

let s:Function     = '#a3e234'
let s:Identifier   = '#ffaf00'

let s:Builtin      = '#5fafff'
let s:Type         = '#e5c07b'
let s:Type2        = '#607fbf'
let s:Boolean      = s:Type

let s:Class        = '#1aa3a1'
let s:Structure    = s:Class
let s:StorageClass = '#ae81ff'
let s:Self         = '#b2b2b2'
let s:Field        = '#c678dd' " Typedef
" }}}


let s:general_enable_light      = 0
let s:general_enable_darkstring = 0
let g:_defhighlight_var.hlcolor.general = extend({
      \ 'Constant'    : [s:String      ,        -1,  -1, -1, 1, 0],
      \ 'String'      : [s:String      ,        -1,  -1, -1, 1, 0],
      \ 'Character'   : [s:Character   ,        -1,  -1, -1, 1, 0],
      \                                
      \ 'Number'      : [s:Number      ,        -1,  -1, -1, 0, 0],
      \ 'Float'       : [s:Float       ,        -1,  -1, -1, 0, 0],
      \ 'Boolean'     : [s:Boolean     ,        -1,  -1, -1, 1, 0],
      \                                
      \ 'Function'    : [s:Function    ,        -1,  -1, -1, 0, 0],
      \ 'Identifier'  : [s:Identifier  ,        -1, 214, -1, 0, 0],
      \                                
      \ 'Statement'   : [s:Statement   ,        -1,  -1, -1, 0, 0],
      \ 'Conditional' : [s:Conditional ,        -1,  -1, -1, 0, 0],
      \ 'Repeat'      : [s:Repeat      ,        -1,  -1, -1, 0, 0],
      \ 'Label'       : [s:Label       ,        -1,  -1, -1, 0, 0],
      \ 'Operator'    : [s:Operator    ,        -1,  -1, -1, 0, 0],
      \ 'Keyword'     : [s:Keyword     ,        -1,  -1, -1, 0, 0],
      \ 'Exception'   : [s:Exception   ,        -1,  -1, -1, 0, 0],
      \ 'Include'     : [s:Include     ,        -1,  -1, -1, 0, 0],
      \ 'Typedef'     : [s:Typedef     ,        -1,  -1, -1, 0, 0],
      \                                
      \ 'Structure'   : [s:Class       ,        -1,  -1, -1, 0, 1],
      \ 'StorageClass': [s:StorageClass,        -1,  -1, -1, 1, 0],
      \ }, s:general_enable_light ? {
      \ 'Type'        : [s:Type        ,        -1, 207, -1, 0, 0],
      \ } : {})
      " \ 'Type'        : [s:Type2,        -1, 180, -1, 0, 0],
      " \ 'Constant'    : [s:String, s:StringBack,  -1, -1, 1, 0],
      " \ 'String'      : [s:String, s:StringBack,  -1, -1, 1, 0],
      " \ 'Character'   : [s:String, s:StringBack,  -1, -1, 1, 0],
" darker String background
let s:general_darkstring = {
      \ 'Constant'    : [s:String      , '#3c3836',  -1, -1, 1, 0],
      \ 'String'      : [s:String      , '#3c3836',  -1, -1, 1, 0],
      \ 'Character'   : [s:Character   , '#3c3836',  -1, -1, 1, 0],
      \ }
if s:general_enable_darkstring
  call s:addColor(s:general_darkstring, 'general')
endif
" }}}


" Language Highlight: {{{

" Python: {{{
let s:enable_python_brightClass = 0
let s:enable_python_lightParam  = 0
let g:python_highlight_all      = 1
let g:_defhighlight_var.hlcolor.python = extend({
      \ 'pythonStatement'      : [s:Statement,   -1,  -1, -1, 0, 0],
      \ 'pythonOperator'       : [s:Statement,   -1,  -1, -1, 0, 0],
      \
      \ 'pythonKeyword'        : [s:Type,        -1,  -1, -1, 1, 0],
      \
      \ 'semshiImported'       : [s:Class,       -1,  -1,  0, 0, 1],
      \ 'semshiBuiltin'        : [s:Builtin,     -1, 180, -1, 1, 0],
      \ 'semshiSelf'           : [s:Self,        -1, 249, -1, 0, 0],
      \ 'semshiAttribute'      : [s:Field,       -1,  -1,  1, 0, 0],
      \
      \ 'pythonFunction'       : [s:Function,    -1,  -1, -1, 0, 0],
      \ 'pythonDecoratorName'  : [s:Function,    -1,  -1, -1, 1, 0],
      \
      \ 'semshiParameter'      : [s:Identifier,  -1, 214, -1, 0, 0],
      \ 'semshiGlobal'         : [s:Type,        -1, 180, -1, 0, 0],
      \
      \ 'pythonString'         : [s:String,      -1,  -1, -1, 1, 0],
      \ 'pythonRawString'      : [s:RawString,   -1,  -1, -1, 1, 0],
      \ 'pythonDelimiter'      : [s:Statement,   -1,  -1, -1, 0, 0],
      \ 'pythonNumber'         : [s:Number,      -1,  -1, -1, 0, 0],
      \ }, 0 || g:is_vim8 ? {
      \ 'pythonConditional'    : [s:Statement,   -1,  -1, -1, 0, 0],
      \ 'pythonImport'         : [s:Statement,   -1,  -1, -1, 0, 0],
      \ 'pythonException'      : [s:Statement,   -1,  -1, -1, 0, 0],
      \ 'pythonRepeat'         : [s:Statement,   -1,  -1, -1, 0, 0],
      \
      \ 'pythonBuiltinObj'     : [s:Field,       -1,  -1, -1, 1, 0],
      \ 'pythonBuiltinType'    : [s:Builtin,     -1,  -1, -1, 1, 0],
      \ 'pythonClassVar'       : [s:Field,       -1,  -1, -1, 0, 0],
      \ } : {})
let s:python_lightParam  = {
      \ 'semshiBuiltin'        : [s:Type2,       -1, 180, -1, 0, 1],
      \ 'semshiParameter'      : [s:Type,        -1, 214, -1, 0, 0],
      \ 'semshiGlobal'         : [s:Identifier,  -1, 180, -1, 0, 0],
      \ }
let s:python_brightClass = {
      \ 'semshiImported'       : ['#56b6c2',     -1,  -1, -1, 0, 1],
      \ }
      " \ 'pythonString'         : [s:String, s:StringBack,  -1, -1, 1, 0],

" Jupyter Notebook
let g:_defhighlight_var.hlcolor.ipynb = g:_defhighlight_var.hlcolor.python

if s:enable_python_lightParam
  call s:addColor(s:python_lightParam, 'python')
endif
if s:enable_python_brightClass
  call s:addColor(s:python_brightClass, 'python')
endif
" }}}

" C Cpp: {{{
let s:enable_cpp_dark_type = 0
let g:_defhighlight_var.hlcolor.cpp = extend({
      \ 'cInclude'                     : [s:Statement,   -1,  -1, -1, 0, 1],
      \ 'cIncluded'                    : [s:Statement,   -1,  -1, -1, 0, 1],
      \ 'cStatement'                   : [s:Statement,   -1,  -1, -1, 0, 1],
      \ 'chromaticaKeyword'            : [s:Statement,   -1,  -1, -1, 0, 1],
      \ 'chromaticaException'          : [s:Statement,   -1,  -1, -1, 0, 1],
      \ 'Type'                         : [s:Statement,   -1, 207, -1, 0, 1],
      \ 'Typedef'                      : [s:Statement,   -1, 207, -1, 0, 1],
      \ 'AutoType'                     : [s:Statement,   -1, 207, -1, 0, 1],
      \
      \ 'chromaticaTypeRef'            : [s:Type,        -1,  -1, -1, 0, 0],
      \ 'chromaticaCXXBaseSpecifier'   : [s:Class,       -1, 207, -1, 0, 1],
      \ 'chromaticaSpecifier'          : [s:Class,       -1, 207, -1, 0, 1],
      \
      \ 'Namespace'                    : [s:Class,       -1,  -1, -1, 0, 1],
      \ 'chromaticaClassDecl'          : [s:Class,       -1,  -1, -1, 0, 1],
      \ 'chromaticaStructDecl'         : [s:Class,       -1,  -1, -1, 0, 1],
      \ 'chromaticaUnionDecl'          : [s:Class,       -1,  -1, -1, 0, 1],
      \ 'chromaticaEnumDecl'           : [s:Class,       -1,  -1, -1, 0, 1],
      \
      \ 'Member'                       : [s:Field,       -1,  -1, -1, 1, 0],
      \ 'Variable'                     : ['#fd971f',     -1, 214, -1, 0, 0],
      \ 'Linkage'                      : ['#82b1ff',     -1,  39, -1, 0, 0],
      \ 'OperatorOverload'             : ['#6c9f9d',     -1,  -1, -1, 1, 0],
      \ 'cStorageClass'                : ['#aab6e1',     -1,  -1, -1, 1, 0],
      \ }, !executable('clang') ? {
      \ 'cIncluded'                    : [s:Class,       -1,  -1, -1, 0, 1],
      \ } : {})
let s:cpp_darktype = {
      \ 'Type'                         : [s:Type2,       -1, 207, -1, 0, 0],
      \ 'chromaticaTypeRef'            : ['Grey'  ,   -1, 'Grey', -1, 0, 0],
      \ }
if s:enable_cpp_dark_type
  call s:addColor(s:cpp_darktype, 'c')
  call s:addColor(s:cpp_darktype, 'cpp')
endif
let g:_defhighlight_var.hlcolor.c = g:_defhighlight_var.hlcolor.cpp
" }}}

" Java: {{{
let g:java_highlight_all = 1
let g:java_highlight_functions = 1
" let g:java_mark_braces_in_parens_as_errors = 1
let g:java_comment_strings = 1
let g:_defhighlight_var.hlcolor.java = extend({
      \ 'javaStatement'                : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'javaConditional'              : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'javaRepeat'                   : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'javaExceptions'               : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'javaAssert'                   : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'javaScopeDecl'                : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'javaConstant  '               : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'javaOperator  '               : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'javaExternal'                 : [s:Statement,        -1,  -1, -1, 0, 0],
      \
      \ 'javaLangClass'                : [s:Class,            -1,  -1, -1, 0, 1],
      \ 'javaClassDecl'                : [s:Class,            -1,  -1, -1, 0, 1],
      \ 'javaC_JavaLang'               : [s:Class,            -1,  -1, -1, 0, 1],
      \ 'javaE_JavaLang'               : [s:Class,            -1,  -1, -1, 0, 1],
      \ 'javaR_JavaLang'               : [s:Class,            -1,  -1, -1, 0, 1],
      \ 'javaX_JavaLang'               : [s:Class,            -1,  -1, -1, 0, 1],
      \ 
      \ 'javaTypedef'                  : [s:Field,            -1,  -1, -1, 1, 0],
      \
      \ 'javaMethodDecl'               : [s:Function,         -1,  -1, -1, 0, 0],
      \ 'javaLangObject'               : [s:Function,         -1,  -1, -1, 0, 0],
      \ 'javaVarArg'                   : [s:Identifier,       -1, 214, -1, 0, 0],
      \
      \ 'javaDocParam'                 : [s:Field,            -1,  -1, -1, 1, 0],
      \ 'javaDocSeeTagParam'           : [s:Field,            -1,  -1, -1, 1, 0],
      \ 'javaAnnotation'               : [s:Builtin,          -1,  -1, -1, 1, 0],
      \ }, 0 ? {
      \ 'javaType'                     : [s:Type2,            -1, 207, -1, 1, 0],
      \ 'javaStorageClass'             : [s:StorageClass,     -1,  -1, -1, 0, 0],
      \ } : {})
" }}}

" Scala: {{{
let g:_defhighlight_var.hlcolor.scala = {
      \ 'scalaImport'                  : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'scalaTypeStatement'           : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'scalaKeyword'                 : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'scalaKeywordModifier'         : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'scalaSpecialFunction'         : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'scalaOperator'                : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'scalaTypeOperator'            : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'scalaTypeExtension'           : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'scalaTypePostExtension'       : [s:Statement,        -1,  -1, -1, 0, 0],
      \
      \ 'scalaClass'                   : [s:Class,            -1,  -1, -1, 0, 1],
      \ 'scalaTypeDeclaration'         : [s:Type2,            -1, 207, -1, 1, 0],
      \ 'scalaInstanceHash'            : [s:Type2,            -1, 207, -1, 1, 0],
      \ 'scalaCapitalWord'             : [s:Field,            -1, 176, -1, 1, 0],
      \
      \ 'scalaTypeAnnotation'          : [s:Builtin,          -1,  75, -1, 1, 0],
      \ 'scalaTypeAnnotationParameter' : [s:Field,            -1,  -1, -1, 1, 0],
      \
      \ 'scalaNameDefinition'          : [s:Identifier,       -1,  -1, -1, 0, 0],
      \ 'scalaParameterAnnotation'     : [s:Identifier,       -1, 214, -1, 0, 0],
      \ 'scalaInterpolation'           : [s:Identifier,       -1, 214, -1, 0, 0],
      \ 'scalaFInterpolation'          : [s:Identifier,       -1, 214, -1, 0, 0],
      \ 'scalaSymbol'                  : [s:Identifier,       -1, 214, -1, 0, 0],
      \
      \ 'scalaString'                  : [s:String, s:StringBack,  -1, -1, 1, 0],
      \ 'scalaStringEmbeddedQuote'     : [s:String, s:StringBack,  -1, -1, 1, 0],
      \ 'scalaTripleString'            : [s:String, s:StringBack,  -1, -1, 1, 0],
      \ 'scalaTripleFString'           : [s:String, s:StringBack,  -1, -1, 1, 0],
      \ 'scalaChar'                    : [s:RawString,        -1,  -1, -1, 1, 0],
      \ 'scalaEscapedChar'             : [s:RawString,        -1,  -1, -1, 1, 0],
      \
      \ 'scalaNumber'                  : [s:Number,           -1,  -1, -1, 0, 0],
      \ }
      " \ 'scalaExternal'                : [s:Statement,      -1,  -1, -1, 0, 0],
      " \ 'scalaSpecial'                 : [s:Statement,      -1,  -1, -1, 0, 0],
      " \ 'scalaAnnotation'              : [s:Builtin,        -1,  75, -1, 1, 0], " PreProc
      "
      " \ 'scalaCaseFollowing'           : [s:Identifier,     -1, 214, -1, 0, 0], " Special
      " \ 'scalaUnicodeChar'             : [s:RawString,      -1,  -1, -1, 1, 0],
" }}}

" Go: {{{
let g:_defhighlight_var.hlcolor.go = {
      \ 'goDeclType'          : [s:Class,   -1,  -1, -1, 0, 1],
      \
      \ 'goBuiltins'          : [s:Builtin,   -1, 207, -1, 1, 0],
      \
      \ 'goType'              : [s:Type2,   -1, 207, -1, 0, 1],
      \ 'goSignedInts'        : [s:Type2,   -1, 207, -1, 0, 1],
      \ 'goUnsignedInts'      : [s:Type2,   -1, 207, -1, 0, 1],
      \ 'goFloats'            : [s:Type2,   -1, 207, -1, 0, 1],
      \ 'goComplexes'         : [s:Type2,   -1, 207, -1, 0, 1],
      \ 'goExtraType'         : [s:Type2,   -1, 207, -1, 0, 1],
      \
      \ 'goField'             : [s:Field,   -1,  -1, -1, 1, 0],
      \
      \ 'goFunction'          : [s:Function,   -1,  -1, -1, 0, 0],
      \ 'goFunctionCall'      : [s:Function,   -1, 207, -1, 1, 0],
      \ 'goParamName'         : [s:Identifier,   -1, 214, -1, 0, 0],
      \ 'goSpecialString'     : [s:String,   -1, 214, -1, 0, 0],
      \ }
" #1aa3a1
" goExtraType
" }}}

" TypeScript: {{{
let g:_defhighlight_var.hlcolor.typescript = extend({
      \ 'typescriptSource'         : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptIdentier'       : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptStorageClass'   : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptOperator'       : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptBoolean'        : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptNull'           : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptMessage'        : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptGlobal'         : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptDeprecated'     : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptConditional'    : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptRepeat'         : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptBranch'         : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptLabel'          : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptStatement'      : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptExceptions'     : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptReserved'       : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'typescriptLogicSymbols'   : [s:Statement,        -1,  -1, -1, 0, 0],
      \
      \ 'pythonKeyword'            : [s:Type,             -1,  -1, -1, 1, 0],
      \
      \ 'semshiImported'           : [s:Class,            -1,  -1, -1, 0, 1],
      \ 'semshiBuiltin'            : [s:Builtin,          -1, 180, -1, 1, 0],
      \ 'semshiSelf'               : [s:Self,             -1, 249, -1, 0, 0],
      \ 'semshiAttribute'          : [s:Field,            -1,  -1, -1, 1, 0],
      \
      \ 'pythonFunction'           : [s:Function,         -1,  -1, -1, 0, 0],
      \ 'pythonDecoratorName'      : [s:Function,         -1,  -1, -1, 1, 0],
      \
      \ 'typescriptParameters'     : [s:Identifier,       -1, 214, -1, 0, 0],
      \ 'semshiGlobal'             : [s:Type,             -1, 180, -1, 0, 0],
      \
      \ 'pythonString'             : [s:String, s:StringBack,  -1, -1, 1, 0],
      \ 'pythonRawString'          : [s:RawString,        -1,  -1, -1, 1, 0],
      \ 'pythonDelimiter'          : [s:Statement,        -1,  -1, -1, 0, 0],
      \ 'pythonNumber'             : [s:Number,           -1,  -1, -1, 0, 0],
      \ }, 0 || g:is_vim8 ? {
      \ } : {})
" let s:python_lightParam  = {
      " \ 'semshiBuiltin'        : [s:Type2,        -1, 180, -1, 0, 1],
      " \ 'semshiParameter'      : [s:Type,         -1, 214, -1, 0, 0],
      " \ 'semshiGlobal'         : [s:Identifier,   -1, 180, -1, 0, 0],
      " \ }
" let s:python_brightClass = {
      " \ 'semshiImported'       : ['#56b6c2',      -1,  -1, -1, 0, 1],
      " \ }

" let g:_defhighlight_var.hlcolor.ipynb = g:_defhighlight_var.hlcolor.python
"
" if s:enable_python_lightParam
  " call s:addColor(s:python_lightParam, 'python')
" endif
" if s:enable_python_brightClass
  " call s:addColor(s:python_brightClass, 'python')
" endif
" }}}

" CSharp: {{{
let g:_defhighlight_var.hlcolor.cs = {
      \ 'csModifier'              : [s:Statement,    -1,  -1, -1, 0, 0],
      \ 'csClass'                 : [s:Statement,    -1,  -1, -1, 0, 0],
      \ 'csIsType'                : [s:Statement,    -1,  -1, -1, 0, 0],
      \ 'csStorage'               : [s:Statement,    -1,  -1, -1, 0, 0],
      \
      \ 'csClassType'             : [s:Class,        -1,  -1, -1, 0, 1],
      \ 'csNewType'               : [s:Class,        -1,  -1, -1, 0, 1],
      \ 
      \ 'csConstant'              : [s:Field,        -1,  -1, -1, 1, 0],
      \
      \ 'csGlobal'                : [s:Field,        -1,  -1, -1, 1, 0],
      \ }
" }}}
" }}}


" ColorScheme: {{{

" Wth ColorScheme:
augroup highlight_related
  auto!
  autocmd ColorScheme gruvbox     hi clear Folded | hi Folded guifg=#928374 ctermfg=245
  autocmd ColorScheme nord        hi clear Folded | hi Folded guifg=#5C6370 ctermfg=59
  autocmd ColorScheme one         hi clear Folded | hi Folded guifg=#5C6370 ctermfg=59
  autocmd ColorScheme PaperColor  hi clear Folded | hi Folded guifg=#5C6370 ctermfg=59
  autocmd ColorScheme OceanicNext hi clear Folded | hi Folded guifg=#65737e ctermfg=243
        \                       | hi  Cursorline  guibg=#2c323c    ctermbg=16
  autocmd ColorScheme *           hi! MatchParen  gui=italic,bold  cterm=italic,bold
        \                       | hi! Folded      gui=italic       cterm=italic
        \                       | hi! Comment     gui=italic       cterm=italic
        \                       | hi! String      guifg=#98c379    gui=italic  cterm=italic
augroup END

" Without ColorScheme: {{{
hi! clear        SpellBad
hi! clear        SpellCap
hi! clear        SpellRare
hi! clear        SpellLocal
hi! SignColumn   guibg=NONE       ctermbg=NONE
hi! LineNr       ctermfg=DarkGrey ctermbg=NONE cterm=NONE    term=bold 
hi! LineNr       guifg=DarkGrey   guibg=NONE   gui=NONE 
hi! Pmenu        guifg=black      guibg=gray   ctermfg=black ctermbg=gray  
hi! PmenuSel     guifg=brown      guibg=gray   ctermfg=gray  ctermbg=brown 
 " }}}
" }}}


" Gui Setting Vim: {{{
if has('gui_running')
  hi! SpellBad   gui=undercurl  guisp=red
  hi! SpellCap   gui=undercurl  guisp=blue
  hi! SpellRare  gui=undercurl  guisp=magenta
  hi! SpellRare  gui=undercurl  guisp=cyan
else
  hi! SpellBad   term=underline cterm=underline term=standout ctermfg=1
  hi! SpellCap   term=underline cterm=underline
  hi! SpellRare  term=underline cterm=underline
  hi! SpellLocal term=underline cterm=underline
endif

" gui ui
if has('gui_running')
  set guioptions-=m " Hide menu bar.
  set guioptions-=T " Hide toolbar
  set guioptions-=L " Hide left-hand scrollbar
  set guioptions-=r " Hide right-hand scrollbar
  set guioptions-=b " Hide bottom scrollbar
  set showtabline=0 " Hide tabline
  set guioptions-=e " Hide tab

  if g:is_win
    set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI:qDRAFT
  elseif g:is_unix
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11
  else
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
  endif
endif
"}}}

