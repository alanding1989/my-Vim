" ================================================================================
" coc.nvim seetings
" ================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1



" NOTE: set this will let <C-o> response very slow
" set updatetime=100
let g:neosnippet#enable_complete_done = 1

let g:coc_start_at_startup    = 1
let g:coc_snippet_next        = "\<Plug>(coc-snippets-jump)"
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
  autocmd User       CocDiagnosticChange  AirlineRefresh
  autocmd VimEnter * call s:g_mappings()
  if findfile(expand($HOME.'/.SpaceVim/coc-settings.json')) ==# ''
    if g:is_unix
      autocmd User CocNvimInit
            \ exec '!ln -s "'.expand($HOME.'/.SpaceVim.d/coc-settings.json')
            \ .'" "'.expand($HOME.'/.SpaceVim/coc-settings.json').'"'
    elseif g:is_win
      autocmd User CocNvimInit
            \ exec '!mklink /h "'.expand($HOME.'/.SpaceVim/coc-settings.json')
            \ .'" "'.expand($HOME.'/vimfiles/coc-settings.json').'"'
    endif
  endif
  if get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet')) ==# 'neosnippet'
    autocmd VimEnter * call coc#config('snippets.ultisnips', {
          \ 'directories' : [ ]
          \ })
  endif
augroup END


" extensions {{{
" let g:coc_global_extensions = [
" \ 'coc-diagnostic' , 
" \ 'coc-json'       ,
" \ 'coc-vimlsp'     , 
" \ 'coc-tsserver'   ,
" \ 'coc-html'       ,
" \ 'coc-css'        ,
" \ 'coc-vetur'      ,
" \ 'coc-java'       ,
" \ 'coc-rls'        ,
" \ 'coc-yaml'       ,
" \ 'coc-pyls'       ,
" \ 'coc-python'     ,
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
" \ 'coc-ccls'       ,
" \ 'coc-lbdbq'      ,
" \ 'https://github.com/andys8/vscode-jest-snippets.git#master' ,
" \ ] "}}}

" key mapping  {{{

function! s:g_mappings() abort
  vnoremap  <silent>ga  :call CocActionAsync('codeAction',     visualmode())<CR>
  nnoremap  <silent>gd  :call CocActionAsync('jumpDefinition'    )<CR>
  nnoremap  <silent>gt  :call CocActionAsync('jumpTypeDefinition')<CR>
  nnoremap  <silent>gi  :call CocActionAsync('jumpImplementation')<CR>
  nnoremap  <silent>gr  :call CocActionAsync('jumpReferences'    )<CR>
  nnoremap  <silent>ge  :call CocActionAsync('rename'            )<CR>
  nnoremap  <silent>gf  :call CocActionAsync('format'            )<CR>
  vnoremap  <silent>gf  :call CocActionAsync('formatSelected', visualmode())<CR>
  nnoremap  <silent>gs  :call CocActionAsync('documentSymbols'   )<CR>
  nnoremap  <silent>gS  :call CocActionAsync('workspaceSymbols'  )<CR>
  nnoremap  <silent>gl  :call CocActionAsync('diagnosticInfo'    )<CR>
  nmap  gp  <Plug>(coc-git-chunkinfo)
  nmap  [g  <Plug>(coc-git-prevchunk)
  nmap  ]g  <Plug>(coc-git-nextchunk)
  nmap  [d  <Plug>(coc-diagnostic-prev)
  nmap  ]d  <Plug>(coc-diagnostic-next)
endfunction

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

  " language tools
  call SpaceVim#mapping#def('vnoremap', '<leader>la', ":call CocActionAsync('codeAction'    , visualmode())<CR>", 'code actions'   , '', 'code actions'             )
  call SpaceVim#mapping#def('nnoremap', '<leader>lg', ":call CocActionAsync('jumpDefinition')<CR>"    , 'goto Definition'          , '', 'goto Definition'          )
  call SpaceVim#mapping#def('nnoremap', '<leader>lt', ":call CocActionAsync('jumpTypeDefinition')<CR>", 'goto TypeDefinition'      , '', 'goto TypeDefinition'      )
  call SpaceVim#mapping#def('nnoremap', '<leader>li', ":call CocActionAsync('jumpImplementation')<CR>", 'goto Implementation'      , '', 'goto Implementation'      )
  call SpaceVim#mapping#def('nnoremap', '<leader>lr', ":call CocActionAsync('jumpReferences')<CR>"    , 'find References'          , '', 'find References'          )
  call SpaceVim#mapping#def('nnoremap', '<leader>lf', ":call CocActionAsync('format')<CR>"            , 'format code'              , '', 'format code'              )
  call SpaceVim#mapping#def('vnoremap', '<leader>lf', ":call CocActionAsync('formatSelected', visualmode())<CR>", 'format code'    , '', 'format code'              )
  call SpaceVim#mapping#def('nnoremap', '<leader>le', ":call CocActionAsync('rename')<CR>"            , 'rename Symbol'            , '', 'rename Symbol'            )
  call SpaceVim#mapping#def('nnoremap', '<leader>lh', ":call CocActionAsync('doHover')<CR>"           , 'show Documentation'       , '', 'show Documentation'       )
  call SpaceVim#mapping#def('nnoremap', '<leader>ls', ":call CocActionAsync('documentSymbols')<CR>"   , 'get Symbols of document'  , '', 'get symbols document'     )
  call SpaceVim#mapping#def('nnoremap', '<leader>lS', ":call CocActionAsync('workspaceSymbols')<CR>"  , 'get Symbols of workspace' , '', 'get symbols of workspace' )
  call SpaceVim#mapping#def('nnoremap', '<leader>ld', ":call CocActionAsync('diagnosticInfo')<CR>"    , 'show Diagnostic info'     , '', 'show Diagnostic info'     )
  call SpaceVim#mapping#def('nnoremap', '<leader>ll', ":call CocActionAsync('diagnosticList')<CR>"    , 'show Diagnostic list'     , '', 'show Diagnostic list'     )

elseif !g:is_spacevim
  nnoremap <leader>cl  :CocList<CR>
  nnoremap <leader>cpi :call feedkeys(':CocInstall ')<CR>
  nnoremap <leader>cpu :call feedkeys(':CocUninstall ')<CR>
  nnoremap <leader>cpb :call coc#util#build()<CR>
  nnoremap <leader>cs  :CocConfig<CR>
  nnoremap <leader>ce  :CocList snippets<CR>
  nnoremap <leader>cc  :CocList commands<CR>
  nnoremap <leader>ci  :CocInfo<CR>

  vnoremap <leader>la  :call CocActionAsync('codeAction',     visualmode())<CR>
  nnoremap <leader>lg  :call CocActionAsync('jumpDefinition'    )<CR>
  nnoremap <leader>lt  :call CocActionAsync('jumpTypeDefinition')<CR>
  nnoremap <leader>li  :call CocActionAsync('jumpImplementation')<CR>
  nnoremap <leader>lr  :call CocActionAsync('jumpReferences'    )<CR>
  nnoremap <leader>le  :call CocActionAsync('rename'            )<CR>
  nnoremap <leader>lf  :call CocActionAsync('format'            )<CR>
  vnoremap <leader>lf  :call CocActionAsync('formatSelected', visualmode())<CR>
  nnoremap <leader>lh  :call CocActionAsync('doHover'           )<CR>
  nnoremap <leader>ls  :call CocActionAsync('documentSymbols'   )<CR>
  nnoremap <leader>lS  :call CocActionAsync('workspaceSymbols'  )<CR>
  nnoremap <leader>ld  :call CocActionAsync('diagnosticInfo'    )<CR>
  nnoremap <leader>ll  :call CocActionAsync('diagnosticList'    )<CR>
endif "}}}
