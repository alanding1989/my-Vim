" ================================================================================
" plugin settings
" ================================================================================

" NOTE: read
" https://github.com/autozimu/LanguageClient-neovim/pull/514#issuecomment-404463033
" for contents of settings.json for vue-language-server

" NOTE: for debugging LanguageClient-neovim
" set noshowmode
" inoremap <silent> <c-q> <esc>:<c-u>q!<cr>
" let g:LanguageClient_loggingFile = '/tmp/lc.log'
" let g:LanguageClient_loggingLevel = 'DEBUG'

let g:LanguageClient_settingsPath = expand($WORKSPACE_DIR . '/.vim/settings.json')
let g:LanguageClient_completionPreferTextEdit = 1
" the suddennly popup of diagnostics sign is kind of annoying
let g:LanguageClient_diagnosticsSignsMax = 0
