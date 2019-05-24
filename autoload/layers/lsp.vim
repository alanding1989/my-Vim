"=============================================================================
" lsp.vim
"=============================================================================
scriptencoding utf-8


function! layers#lsp#plugins() abort
  let plugins = []

  if get(g:, 'autocomplete_method') ==# 'coc'
    " nop
  elseif has('nvim') && has('python3')
    if g:is_win
      call add(plugins, ['autozimu/LanguageClient-neovim',
            \ {'merged': 0, 'build': 'powershell -executionpolicy bypass -File install.ps1',
            \ 'do': 'powershell -executionpolicy bypass -File install.ps1'}])
    else
      call add(plugins, ['autozimu/LanguageClient-neovim',
            \ {'merged': 0, 'build': 'bash install.sh',
            \ 'do': 'bash install.sh'}])
    endif
  else
    call add(plugins, ['prabirshrestha/async.vim', {'merged' : 0}])
    call add(plugins, ['prabirshrestha/vim-lsp'  , {'merged' : 0}])
  endif
  return plugins
endfunction


function! layers#lsp#config() abort
  call layers#lsp#reg_server(s:enabled_serverCommands)
endfunction


function! layers#lsp#checkft(ft) abort
  return has_key(s:enabled_serverCommands, a:ft)
endfunction


if get(g:, 'autocomplete_method') ==# 'coc'
  function! layers#lsp#reg_server(serverCommands) abort
    return
  endfunction

elseif has('nvim') && has('python3')
  function! layers#lsp#reg_server(serverCommands) abort
    let g:LanguageClient_serverCommands = {}
    for [ft, cmds] in items(a:serverCommands)
      let g:LanguageClient_serverCommands[ft] = cmds
    endfor
  endfunction

else
  function! layers#lsp#reg_server(serverCommands) abort
    for [ft, cmds] in items(a:serverCommands)
      exec 'au User lsp_setup call lsp#register_server({'
            \ . "'name': 'LSP',"
            \ . "'cmd': {server_info -> " . string(cmds) . '},'
            \ . "'whitelist': ['" .  ft . "' ],"
            \ . '})'
      exec 'autocmd FileType ' . ft . ' setlocal omnifunc=lsp#complete'
    endfor
  endfunction
endif

" serverCommands {{{
  let s:serverCommands = extend({
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
        \ 'php'        : ['php', expand($HOME.'/.cache/Vim/dein-plug/repos/github.com/felixfbecker/php-language-server/bin/php-language-server.php')],
        \ 'python'     : ['pyls'],
        \ 'ipynb'      : ['pyls'],
        \ 'scala'      : ['metals-vim'],
        \ 'typescript' : ['typescript-language-server', '--stdio'],
        \ },
        \ g:is_nvim ? {
        \ 'sh'         : ['bash-language-server', 'start'],
        \ 'vim'        : ['vim-language-server' , '--stdio'],
        \ } : {}
        \ )
" }}}
let s:enabled_serverCommands = {}
function! layers#lsp#set_variable(var) abort
  let enable_lsp_ft = get(a:var, 'ft', [])
  for ft in enable_lsp_ft
    if has_key(s:serverCommands, ft)
      let s:enabled_serverCommands[ft] = s:serverCommands[ft]
    endif
  endfor
endfunction


" mappings {{{
if get(g:, 'autocomplete_method') ==# 'coc'
  function! layers#lsp#show_doc() abort
    call CocActionAsync('doHover')
  endfunction

  function! layers#lsp#go_to_def() abort
    call CocActionAsync('jumpDefinition')
  endfunction

  function! layers#lsp#rename() abort
    call CocActionAsync('rename')
  endfunction

  function! layers#lsp#references() abort
    call CocActionAsync('jumpReferences')
  endfunction
elseif has('nvim') && has('python3')
  function! layers#lsp#show_doc() abort
    call LanguageClient_textDocument_hover()
  endfunction

  function! layers#lsp#go_to_def() abort
    call LanguageClient_textDocument_definition()
  endfunction

  function! layers#lsp#rename() abort
    call LanguageClient_textDocument_rename()
  endfunction

  function! layers#lsp#references() abort
    call LanguageClient_textDocument_references()
  endfunction
else
  function! layers#lsp#show_doc() abort
    LspHover
  endfunction

  function! layers#lsp#go_to_def() abort
    LspDefinition
  endfunction

  function! layers#lsp#rename() abort
    LspRename
  endfunction

  function! layers#lsp#references() abort
    LspReferences
  endfunction
endif
"}}}
