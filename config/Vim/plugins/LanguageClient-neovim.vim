"================================================================================
" File Name    : config/Vim/plugins/LanguageClient-neovim.vim
" Created Time : Sun 21 Apr 2019 12:08:14 AM CST
"================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


" NOTE: read
" https://github.com/autozimu/LanguageClient-neovim/pull/514#issuecomment-404463033
" for contents of settings.json for vue-language-server
"
" NOTE: for debugging LanguageClient-neovim
" let g:LanguageClient_loggingLevel = 'DEBUG'
" let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'


let g:LanguageClient_settingsPath             = expand(g:home.'/LCN-settings.json')
let g:LanguageClient_hoverPreview             = 'auto'
let g:LanguageClient_diagnosticsEnable        = get(g:, 'g:LanguageClient_diagnosticsEnable', 0)
let g:LanguageClient_diagnosticsSignsMax      = 0
let g:LanguageClient_diagnosticsList          = 'Quickfix'
let g:LanguageClient_selectionUI              = 'location-list'
let g:LanguageClient_completionPreferTextEdit = 1



" symbols {{{
if g:is_spacevim
  finish
endif

let g:LanguageClient_diagnosticsDisplay = {
      \ 1: {
      \ 'name': 'Error',
      \ 'signText': g:linter_error_symbol,
      \ },
      \ 2: {
      \ 'name': 'Warning',
      \ 'signText': g:linter_warning_symbol,
      \ },
      \ 3: {
      \ 'name': 'Information',
      \ 'signText': g:linter_info_symbol,
      \ },
      \ 4: {
      \ 'name': 'Hint',
      \ 'signText': g:linter_info_symbol,
      \ },
      \ }

if g:checker ==# 'neomake'
  let g:LanguageClient_diagnosticsDisplay[1].texthl = 'NeomakeError'
  let g:LanguageClient_diagnosticsDisplay[1].signTexthl = 'NeomakeErrorSign'

  let g:LanguageClient_diagnosticsDisplay[2].texthl = 'NeomakeWarning'
  let g:LanguageClient_diagnosticsDisplay[2].signTexthl = 'NeomakeWarningSign'

  let g:LanguageClient_diagnosticsDisplay[3].texthl = 'NeomakeInfo'
  let g:LanguageClient_diagnosticsDisplay[3].signTexthl = 'NeomakeInfoSign'

  let g:LanguageClient_diagnosticsDisplay[4].texthl = 'NeomakeMessage'
  let g:LanguageClient_diagnosticsDisplay[4].signTexthl = 'NeomakeMessageSign'
elseif g:checker ==# 'ale'
  let g:LanguageClient_diagnosticsDisplay[1].texthl = 'ALEError'
  let g:LanguageClient_diagnosticsDisplay[1].signTexthl = 'ALEErrorSign'

  let g:LanguageClient_diagnosticsDisplay[2].texthl = 'ALEWarning'
  let g:LanguageClient_diagnosticsDisplay[2].signTexthl = 'ALEWarningSign'

  let g:LanguageClient_diagnosticsDisplay[3].texthl = 'ALEInfo'
  let g:LanguageClient_diagnosticsDisplay[3].signTexthl = 'ALEInfoSign'

  let g:LanguageClient_diagnosticsDisplay[4].texthl = 'ALEInfo'
  let g:LanguageClient_diagnosticsDisplay[4].signTexthl = 'ALEInfoSign'
endif
"}}}
