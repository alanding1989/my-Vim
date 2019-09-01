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

let s:general_enable_light      = 0
let s:general_enable_darkstring = 0
let g:_defhighlight_var.hlcolor.general = extend({
      \ 'Constant'    : ['#98c379',        -1,  -1, -1, 1, 0],
      \ 'String'      : ['#98c379',        -1,  -1, -1, 1, 0],
      \ 'Character'   : ['#98c379',        -1,  -1, -1, 1, 0],
      \
      \ 'Number'      : ['#d19a66',        -1,  -1, -1, 0, 0],
      \ 'Float'       : ['#d19a66',        -1,  -1, -1, 0, 0],
      \ 'Boolean'     : ['#e5c07b',        -1,  -1, -1, 1, 0],
      \
      \ 'Function'    : ['#a3e234',        -1,  -1, -1, 0, 0],
      \ 'Identifier'  : ['#ffaf00',        -1, 214, -1, 0, 0],
      \
      \ 'Statement'   : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Conditional' : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Repeat'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Label'       : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Operator'    : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Keyword'     : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Exception'   : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Include'     : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'Typedef'     : ['#f92672',        -1,  -1, -1, 0, 0],
      \
      \ 'Structure'   : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'StorageClass': ['#aab6e1',        -1,  -1, -1, 1, 0],
      \ }, s:general_enable_light ? {
      \ 'Type'        : ['#e5c07b',        -1, 207, -1, 0, 0],
      \ } : {})
      " \ 'Type'        : ['#607fbf',        -1, 180, -1, 0, 0],
      " \ 'Constant'    : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      " \ 'String'      : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      " \ 'Character'   : ['#98c379', '#3b4048',  -1, -1, 1, 0],
" darker String background
let s:general_darkstring = {
      \ 'Constant'    : ['#98c379', '#3c3836',  -1, -1, 1, 0],
      \ 'String'      : ['#98c379', '#3c3836',  -1, -1, 1, 0],
      \ 'Character'   : ['#98c379', '#3c3836',  -1, -1, 1, 0],
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
      \ 'pythonStatement'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonOperator'       : ['#f92672',        -1,  -1, -1, 0, 0],
      \
      \ 'pythonKeyword'        : ['#e5c07b',        -1,  -1, -1, 1, 0],
      \
      \ 'semshiImported'       : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'semshiBuiltin'        : ['#5fafff',        -1, 180, -1, 1, 0],
      \ 'semshiSelf'           : ['#b2b2b2',        -1, 249, -1, 0, 0],
      \ 'semshiAttribute'      : ['#c678dd',        -1,  -1, -1, 1, 0],
      \
      \ 'pythonFunction'       : ['#a3e234',        -1,  -1, -1, 0, 0],
      \ 'pythonDecoratorName'  : ['#a3e234',        -1,  -1, -1, 1, 0],
      \
      \ 'semshiParameter'      : ['#ffaf00',        -1, 214, -1, 0, 0],
      \ 'semshiGlobal'         : ['#e5c07b',        -1, 180, -1, 0, 0],
      \
      \ 'pythonString'         : ['#98c379',        -1,  -1, -1, 1, 0],
      \ 'pythonRawString'      : ['#b8bb26',        -1,  -1, -1, 1, 0],
      \ 'pythonDelimiter'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonNumber'         : ['#d19a66',        -1,  -1, -1, 0, 0],
      \ }, 0 || g:is_vim8 ? {
      \ 'pythonConditional'    : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonImport'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonException'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonRepeat'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \
      \ 'pythonBuiltinObj'     : ['#c678dd',        -1,  -1, -1, 1, 0],
      \ 'pythonBuiltinType'    : ['#5fafff',        -1,  -1, -1, 1, 0],
      \ 'pythonClassVar'       : ['#c678dd',        -1,  -1, -1, 0, 0],
      \ } : {})
let s:python_lightParam  = {
      \ 'semshiBuiltin'        : ['#607fbf',        -1, 180, -1, 0, 1],
      \ 'semshiParameter'      : ['#e5c07b',        -1, 214, -1, 0, 0],
      \ 'semshiGlobal'         : ['#ffaf00',        -1, 180, -1, 0, 0],
      \ }
let s:python_brightClass = {
      \ 'semshiImported'       : ['#56b6c2',        -1,  -1, -1, 0, 1],
      \ }
      " \ 'pythonString'         : ['#98c379', '#3b4048',  -1, -1, 1, 0],

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
      \ 'cInclude'                     : ['#f92672',   -1,  -1, -1, 0, 1],
      \ 'cIncluded'                    : ['#f92672',   -1,  -1, -1, 0, 1],
      \ 'cStatement'                   : ['#f92672',   -1,  -1, -1, 0, 1],
      \ 'chromaticaKeyword'            : ['#f92672',   -1,  -1, -1, 0, 1],
      \ 'chromaticaException'          : ['#f92672',   -1,  -1, -1, 0, 1],
      \ 'Type'                         : ['#f92672',   -1, 207, -1, 0, 1],
      \ 'Typedef'                      : ['#f92672',   -1, 207, -1, 0, 1],
      \ 'AutoType'                     : ['#f92672',   -1, 207, -1, 0, 1],
      \
      \ 'chromaticaTypeRef'            : ['#e5c07b',   -1,  -1, -1, 0, 0],
      \ 'chromaticaCXXBaseSpecifier'   : ['#1aa3a1',   -1, 207, -1, 0, 1],
      \ 'chromaticaSpecifier'          : ['#1aa3a1',   -1, 207, -1, 0, 1],
      \
      \ 'Namespace'                    : ['#1aa3a1',   -1,  -1, -1, 0, 1],
      \ 'chromaticaClassDecl'          : ['#1aa3a1',   -1,  -1, -1, 0, 1],
      \ 'chromaticaStructDecl'         : ['#1aa3a1',   -1,  -1, -1, 0, 1],
      \ 'chromaticaUnionDecl'          : ['#1aa3a1',   -1,  -1, -1, 0, 1],
      \ 'chromaticaEnumDecl'           : ['#1aa3a1',   -1,  -1, -1, 0, 1],
      \
      \ 'Member'                       : ['#c678dd',   -1,  -1, -1, 1, 0],
      \ 'Variable'                     : ['#fd971f',   -1, 214, -1, 0, 0],
      \ 'Linkage'                      : ['#82b1ff',   -1,  39, -1, 0, 0],
      \ 'OperatorOverload'             : ['#6c9f9d',   -1,  -1, -1, 1, 0],
      \ 'cStorageClass'                : ['#aab6e1',   -1,  -1, -1, 1, 0],
      \ }, !executable('clang') ? {
      \ 'cIncluded'                    : ['#1aa3a1',   -1,  -1, -1, 0, 1],
      \ } : {})
let s:cpp_darktype = {
      \ 'Type'                         : ['#607fbf',   -1, 207, -1, 0, 0],
      \ 'chromaticaTypeRef'            : ['Grey'   ,   -1, 'Grey', -1, 0, 0],
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
      \ 'javaStatement'                : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'javaConditional'              : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'javaRepeat'                   : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'javaExceptions'               : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'javaAssert'                   : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'javaScopeDecl'                : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'javaConstant  '               : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'javaOperator  '               : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'javaExternal'                 : ['#f92672',        -1,  -1, -1, 0, 0],
      \
      \ 'javaLangClass'                : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'javaClassDecl'                : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'javaC_JavaLang'               : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'javaE_JavaLang'               : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'javaR_JavaLang'               : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'javaX_JavaLang'               : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 
      \ 'javaTypedef'                  : ['#c678dd',        -1,  -1, -1, 1, 0],
      \
      \ 'javaMethodDecl'               : ['#a3e234',        -1,  -1, -1, 0, 0],
      \ 'javaLangObject'               : ['#a3e234',        -1,  -1, -1, 0, 0],
      \ 'javaVarArg'                   : ['#ffaf00',        -1, 214, -1, 0, 0],
      \
      \ 'javaDocParam'                 : ['#c678dd',        -1,  -1, -1, 1, 0],
      \ 'javaDocSeeTagParam'           : ['#c678dd',        -1,  -1, -1, 1, 0],
      \ 'javaAnnotation'               : ['#5fafff',        -1,  -1, -1, 1, 0],
      \ }, 0 ? {
      \ 'javaType'                     : ['#607fbf',        -1, 207, -1, 1, 0],
      \ 'javaStorageClass'             : ['#f92672',        -1,  -1, -1, 0, 0],
      \ } : {})
" }}}

" Scala: {{{
let g:_defhighlight_var.hlcolor.scala = {
      \ 'scalaImport'                  : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaTypeStatement'           : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaKeyword'                 : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaKeywordModifier'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaSpecialFunction'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaOperator'                : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaTypeOperator'            : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaTypeExtension'           : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'scalaTypePostExtension'       : ['#f92672',        -1,  -1, -1, 0, 0],
      \
      \ 'scalaClass'                   : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'scalaTypeDeclaration'         : ['#607fbf',        -1, 207, -1, 1, 0],
      \ 'scalaInstanceHash'            : ['#607fbf',        -1, 207, -1, 1, 0],
      \ 'scalaCapitalWord'             : ['#c678dd',        -1, 176, -1, 1, 0],
      \
      \ 'scalaTypeAnnotation'          : ['#5fafff',        -1,  75, -1, 1, 0],
      \ 'scalaTypeAnnotationParameter' : ['#c678dd',        -1,  -1, -1, 1, 0],
      \
      \ 'scalaNameDefinition'          : ['#ffaf00',        -1,  -1, -1, 0, 0],
      \ 'scalaParameterAnnotation'     : ['#ffaf00',        -1, 214, -1, 0, 0],
      \ 'scalaInterpolation'           : ['#ffaf00',        -1, 214, -1, 0, 0],
      \ 'scalaFInterpolation'          : ['#ffaf00',        -1, 214, -1, 0, 0],
      \ 'scalaSymbol'                  : ['#ffaf00',        -1, 214, -1, 0, 0],
      \
      \ 'scalaString'                  : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \ 'scalaStringEmbeddedQuote'     : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \ 'scalaTripleString'            : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \ 'scalaTripleFString'           : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \ 'scalaChar'                    : ['#b8bb26',        -1,  -1, -1, 1, 0],
      \ 'scalaEscapedChar'             : ['#b8bb26',        -1,  -1, -1, 1, 0],
      \
      \ 'scalaNumber'                  : ['#d19a66',        -1,  -1, -1, 0, 0],
      \ }
      " \ 'scalaExternal'                : ['#f92672',        -1,  -1, -1, 0, 0],
      " \ 'scalaSpecial'                 : ['#f92672',        -1,  -1, -1, 0, 0],
      " \ 'scalaAnnotation'              : ['#5fafff',        -1,  75, -1, 1, 0], " PreProc
      "
      " \ 'scalaCaseFollowing'           : ['#ffaf00',        -1, 214, -1, 0, 0], " Special
      " \ 'scalaUnicodeChar'             : ['#b8bb26',        -1,  -1, -1, 1, 0],
" }}}

" Go: {{{
let g:_defhighlight_var.hlcolor.go = {
      \ 'goDeclType'          : ['#1aa3a1',   -1,  -1, -1, 0, 1],
      \
      \ 'goBuiltins'          : ['#5fafff',   -1, 207, -1, 1, 0],
      \
      \ 'goType'              : ['#607fbf',   -1, 207, -1, 0, 1],
      \ 'goSignedInts'        : ['#607fbf',   -1, 207, -1, 0, 1],
      \ 'goUnsignedInts'      : ['#607fbf',   -1, 207, -1, 0, 1],
      \ 'goFloats'            : ['#607fbf',   -1, 207, -1, 0, 1],
      \ 'goComplexes'         : ['#607fbf',   -1, 207, -1, 0, 1],
      \ 'goExtraType'         : ['#607fbf',   -1, 207, -1, 0, 1],
      \
      \ 'goField'             : ['#c678dd',   -1,  -1, -1, 1, 0],
      \
      \ 'goFunction'          : ['#a3e234',   -1,  -1, -1, 0, 0],
      \ 'goFunctionCall'      : ['#a3e234',   -1, 207, -1, 1, 0],
      \ 'goParamName'         : ['#ffaf00',   -1, 214, -1, 0, 0],
      \ 'goSpecialString'     : ['#98c379',   -1, 214, -1, 0, 0],
      \ }
" #1aa3a1
" goExtraType
" }}}

" TypeScript: {{{
let g:_defhighlight_var.hlcolor.typescript = extend({
      \ 'typescriptSource'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptIdentier'       : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptStorageClass'   : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptOperator'       : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptBoolean'        : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptNull'           : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptMessage'        : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptGlobal'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptDeprecated'     : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptConditional'    : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptRepeat'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptBranch'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptLabel'          : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptStatement'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptExceptions'     : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptReserved'       : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'typescriptLogicSymbols'   : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonStatement'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonOperator'       : ['#f92672',        -1,  -1, -1, 0, 0],
      \
      \ 'pythonKeyword'        : ['#e5c07b',        -1,  -1, -1, 1, 0],
      \
      \ 'semshiImported'       : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'semshiBuiltin'        : ['#5fafff',        -1, 180, -1, 1, 0],
      \ 'semshiSelf'           : ['#b2b2b2',        -1, 249, -1, 0, 0],
      \ 'semshiAttribute'      : ['#c678dd',        -1,  -1, -1, 1, 0],
      \
      \ 'pythonFunction'       : ['#a3e234',        -1,  -1, -1, 0, 0],
      \ 'pythonDecoratorName'  : ['#a3e234',        -1,  -1, -1, 1, 0],
      \
      \ 'typescriptParameters'    : ['#ffaf00',        -1, 214, -1, 0, 0],
      \ 'semshiGlobal'         : ['#e5c07b',        -1, 180, -1, 0, 0],
      \
      \ 'pythonString'         : ['#98c379', '#3b4048',  -1, -1, 1, 0],
      \ 'pythonRawString'      : ['#b8bb26',        -1,  -1, -1, 1, 0],
      \ 'pythonDelimiter'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonNumber'         : ['#d19a66',        -1,  -1, -1, 0, 0],
      \ }, 0 || g:is_vim8 ? {
      \ 'pythonConditional'    : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonImport'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonException'      : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'pythonRepeat'         : ['#f92672',        -1,  -1, -1, 0, 0],
      \
      \ 'pythonBuiltinObj'     : ['#c678dd',        -1,  -1, -1, 1, 0],
      \ 'pythonBuiltinType'    : ['#5fafff',        -1,  -1, -1, 1, 0],
      \ 'pythonClassVar'       : ['#c678dd',        -1,  -1, -1, 0, 0],
      \ } : {})
" let s:python_lightParam  = {
      " \ 'semshiBuiltin'        : ['#607fbf',        -1, 180, -1, 0, 1],
      " \ 'semshiParameter'      : ['#e5c07b',        -1, 214, -1, 0, 0],
      " \ 'semshiGlobal'         : ['#ffaf00',        -1, 180, -1, 0, 0],
      " \ }
" let s:python_brightClass = {
      " \ 'semshiImported'       : ['#56b6c2',        -1,  -1, -1, 0, 1],
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
      \ 'csModifier'              : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'csClass'                 : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'csIsType'                : ['#f92672',        -1,  -1, -1, 0, 0],
      \ 'csStorage'               : ['#f92672',        -1,  -1, -1, 0, 0],
      \
      \ 'csClassType'             : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 'csNewType'               : ['#1aa3a1',        -1,  -1, -1, 0, 1],
      \ 
      \ 'csConstant'              : ['#c678dd',        -1,  -1, -1, 1, 0],
      \
      \ 'javaVarArg'              : ['#ffaf00',        -1, 214, -1, 0, 0],
      \
      \ 'csGlobal'                : ['#c678dd',        -1,  -1, -1, 1, 0],
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

