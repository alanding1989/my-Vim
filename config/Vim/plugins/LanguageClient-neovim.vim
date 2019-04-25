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

let g:LanguageClient_loadSettings             = 1
let g:LanguageClient_settingsPath             = expand('~/.vim/LCN-settings.json')
let g:LanguageClient_diagnosticsEnable        = get(g:, 'g:LanguageClient_diagnosticsEnable', 0)
let g:LanguageClient_diagnosticsSignsMax      = 0
let g:LanguageClient_diagnosticsList          = v:null
let g:LanguageClient_selectionUI              = 'quickfix'
let g:LanguageClient_completionPreferTextEdit = 1
let g:LanguageClient_useVirtualText           = 1
let g:LanguageClient_useFloatingHover         = 1
let g:LanguageClient_hoverPreview             = 'Never'


" NOTE: for debugging LanguageClient-neovim
" let g:LanguageClient_loggingFile = '/tmp/lc.log'
" let g:LanguageClient_loggingLevel = 'DEBUG'


" symbols {{{
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

let s:serverCommands = {
      \ 'c'          : ['clangd'],
      \ 'cpp'        : ['clangd'],
      \ 'css'        : ['css-languageserver', '--stdio'],
      \ 'dockerfile' : ['docker-langserver', '--stdio'],
      \ 'go'         : ['go-langserver', '-mode', 'stdio'],
      \ 'haskell'    : ['hie-wrapper', '--lsp'],
      \ 'html'       : ['html-languageserver', '--stdio'],
      \ 'javascript' : ['javascript-typescript-stdio'],
      \ 'objc'       : ['clangd'],
      \ 'objcpp'     : ['clangd'],
      \ 'php'        : ['php', $HOME.'/.cache/Vim/dein-plug/repos/github.com/felixfbecker/php-language-server/bin/php-language-server.php'],
      \ 'python'     : ['pyls'],
      \ 'ipynb'      : ['pyls'],
      \ 'sh'         : ['bash-language-server', 'start'],
      \ 'scala'      : ['metals-vim'],
      \ 'typescript' : ['typescript-language-server', '--stdio'],
      \ }
let g:LanguageClient_serverCommands = {}

for [ft, cmds] in items(s:serverCommands)
  if index(g:lsp_ft, ft) > -1
    let g:LanguageClient_serverCommands[ft] = cmds
  endif
endfor
