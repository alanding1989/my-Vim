" ================================================================================
" coc.nvim seetings
" ================================================================================
scriptencoding utf-8



" NOTE: set this will let <C-o> response very slow
" set updatetime=100
let g:neosnippet#enable_complete_done = 1

let g:coc_start_at_startup    = 1
let g:coc_snippet_next        = '<tab>'
let g:coc_snippet_prev        = '<c-o>'
let g:vim_node_rpc_folder     = exepath('vim-node-rpc')
let g:coc_filetype_map        = {
      \ 'html.swig': 'html',
    \ 'wxss'     : 'css',
      \ 'ipynb'    : 'python',
      \ }

augroup my_coc_settings
  auto!
  " show func signature after jump code placehold
  autocmd CursorHoldI,CursorMovedI * silent call CocActionAsync('showSignatureHelp')
  autocmd CursorHold               * silent call CocActionAsync('highlight')
  autocmd User CocDiagnosticChange AirlineRefresh
  if findfile(expand($HOME.'/.SpaceVim/coc-settings.json')) ==# ''
    if g:is_unix
      autocmd User CocNvimInit
            \ exec '!ln -s "'.expand($HOME.'/.vim/coc-settings.json')
            \ .'" "'.expand($HOME.'/.SpaceVim/coc-settings.json').'"'
    elseif g:is_win
      autocmd User CocNvimInit
            \ exec '!mklink /h "'.expand($HOME.'/.SpaceVim/coc-settings.json')
            \ .'" "'.expand($HOME.'/vimfiles/coc-settings.json').'"'
    endif
  endif
augroup END


" extensions {{{
" let g:coc_global_extensions = [
" \ 'coc-tsserver'   ,
" \ 'coc-json'       ,
" \ 'coc-html'       ,
" \ 'coc-css'        ,
" \ 'coc-java'       ,
" \ 'coc-rls'        ,
" \ 'coc-pyls'       ,
" \ 'coc-emmet'      ,
" \ 'coc-snippets'   ,
" \ 'coc-dictionary' ,
" \ 'coc-tag'        ,
" \ 'coc-word'       ,
" \ 'coc-emoji'      ,
" \ 'coc-gocode'     ,
" \ 'coc-neosnippet' ,
" \ 'coc-ultisnips'  ,
" \ 'coc-omni'       ,
" \ 'coc-vimtex'     ,
" \ 'https://github.com/andys8/vscode-jest-snippets.git#master' ,
" \ ] "}}}

" key mapping  {{{

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-implementation)

if g:is_spacevim
  let g:_spacevim_mappings.c     = {'name': '+@ Coc...'}
  let g:_spacevim_mappings.c.p   = {'name': '+CocUtil actions'}
  let g:_spacevim_mappings.c.p.i = ['call feedkeys(":CocInstall ")'  , 'coc install plugins' ]
  let g:_spacevim_mappings.c.p.u = ['call feedkeys(":CocUninstall ")', 'coc remove plugins'  ]
  let g:_spacevim_mappings.c.p.b = ['call coc#util#build()'          , 'coc build source'    ]
  call SpaceVim#mapping#def('nnoremap', '<leader>cl', ':CocList<CR>'         , 'Coc List'    , '', 'Coc List'    )
  call SpaceVim#mapping#def('nnoremap', '<leader>cs', ':CocConfig<CR>'       , 'Coc Settings', '', 'Coc Settings')
  call SpaceVim#mapping#def('nnoremap', '<leader>ce', ':CocList snippets<CR>', 'Coc Snippets', '', 'Coc Snippets')
  call SpaceVim#mapping#def('nnoremap', '<leader>cc', ':CocList commands<CR>', 'Coc Commands', '', 'Coc Commands')
  call SpaceVim#mapping#def('nnoremap', '<leader>ci', ':CocInfo<CR>'         , 'Coc Info'    , '', 'Coc Info'    )
  " call SpaceVim#mapping#def('nnoremap', '<leader>cu', ':CocList links<CR>'   , 'Coc Links'   , '', 'Coc Links'   )

  " language tools
  call SpaceVim#mapping#def('nnoremap', '<leader>lg', ":call CocActionAsync('jumpDefinition')<CR>"    , 'goto Definition'          , '', 'goto Definition'          )
  call SpaceVim#mapping#def('nnoremap', '<leader>ld', ":call CocActionAsync('jumpDeclaration')<CR>"   , 'goto Declaration'         , '', 'goto Declaration'         )
  call SpaceVim#mapping#def('nnoremap', '<leader>li', ":call CocActionAsync('jumpImplementation')<CR>", 'goto Implementation'      , '', 'goto Implementation'      )
  call SpaceVim#mapping#def('nnoremap', '<leader>lt', ":call CocActionAsync('jumpTypeDefinition')<CR>", 'goto TypeDefinition'      , '', 'goto TypeDefinition'      )
  call SpaceVim#mapping#def('nnoremap', '<leader>lr', ":call CocActionAsync('jumpReferences')<CR>"    , 'find References'          , '', 'find References'          )
  call SpaceVim#mapping#def('nnoremap', '<leader>lF', ":call CocActionAsync('format')<CR>"            , 'format code'              , '', 'format code'              )
  " call SpaceVim#mapping#def('nnoremap', '<leader>lF', ":call CocActionAsync('formatSelected')<CR>"    , 'format selected code'     , '', 'format selected code'     )
  call SpaceVim#mapping#def('nnoremap', '<leader>lh', ":call CocActionAsync('doHover')<CR>"           , 'show Documentation'       , '', 'show Documentation'       )
  call SpaceVim#mapping#def('nnoremap', '<leader>ls', ":call CocActionAsync('showSignatureHelp')<CR>" , 'show SignatureHelp'       , '', 'show SignatureHelp'       )
  call SpaceVim#mapping#def('nnoremap', '<leader>lo', ":call CocActionAsync('documentSymbols')<CR>"   , 'get Symbols of document'  , '', 'get symbols document'     )
  call SpaceVim#mapping#def('nnoremap', '<leader>lO', ":call CocActionAsync('workspaceSymbols')<CR>"  , 'get Symbols of workspace' , '', 'get symbols of workspace' )
  call SpaceVim#mapping#def('nnoremap', '<leader>le', ":call CocActionAsync('rename')<CR>"            , 'rename Symbol'            , '', 'rename Symbol'            )
  call SpaceVim#mapping#def('nnoremap', '<leader>ln', ":call CocActionAsync('diagnosticInfo')<CR>"    , 'show Diagnostic info'     , '', 'show Diagnostic info'     )
  call SpaceVim#mapping#def('nnoremap', '<leader>lN', ":call CocActionAsync('diagnosticList')<CR>"    , 'show all Diagnostic items', '', 'show all Diagnostic items')

elseif !g:is_spacevim
  nnoremap <leader>cl  :CocList<CR>
  nnoremap <leader>cpi :CocInstall 
  nnoremap <leader>cpu :CocUninstall 
  nnoremap <leader>cs  :CocConfig<CR>
  nnoremap <leader>ce  :CocList snippets<CR>
  nnoremap <leader>cc  :CocList commands<CR>
  nnoremap <leader>ci  :CocInfo<CR>

  nnoremap <leader>lg  :call CocActionAsync('jumpDefinition'    )<CR>
  nnoremap <leader>ld  :call CocActionAsync('jumpDeclaration'   )<CR>
  nnoremap <leader>li  :call CocActionAsync('jumpImplementation')<CR>
  nnoremap <leader>lt  :call CocActionAsync('jumpTypeDefinition')<CR>
  nnoremap <leader>lr  :call CocActionAsync('jumpReferences'    )<CR>
  nnoremap <leader>lF  :call CocActionAsync('format'            )<CR>
  " nnoremap <leader>lF  :call CocActionAsync('formatSelected'    )<CR>
  nnoremap <leader>lh  :call CocActionAsync('doHover'           )<CR>
  nnoremap <leader>ls  :call CocActionAsync('showSignatureHelp' )<CR>
  nnoremap <leader>lo  :call CocActionAsync('documentSymbols'   )<CR>
  nnoremap <leader>lO  :call CocActionAsync('workspaceSymbols'  )<CR>
  nnoremap <leader>le  :call CocActionAsync('rename'            )<CR>
  nnoremap <leader>ln  :call CocActionAsync('diagnosticInfo'    )<CR>
  nnoremap <leader>lN  :call CocActionAsync('diagnosticList'    )<CR>
endif "}}}
