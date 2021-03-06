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
let g:coc_snippet_prev        = '<C-o>'
let g:vim_node_rpc_folder     = exepath('vim-node-rpc')
let g:coc_filetype_map        = {
      \ 'html.swig': 'html',
      \ 'wxss'     : 'css',
      \ 'ipynb'    : 'python',
      \ 'sbt.scala': 'scala',
      \ }

" extensions {{{
let g:coc_global_extensions = [
      \ 'coc-git'               ,
      \ 'coc-github'            ,
      \ 'coc-docker'            ,
      \ 'coc-diagnostic'        ,
      \ 'coc-sql'               ,
      \ 'coc-post'              ,
      \ 'coc-marketplace'       ,
      \
      \ 'coc-ccls'              ,
      \ 'coc-rust-analyzer'     ,
      \ 'coc-java'              ,
      \ 'coc-gocode'            ,
      \ 'coc-python'            ,
      \ 'coc-pyright'           ,
      \ 'coc-sh'                ,
      \ 'coc-powershell'        ,
      \ 'coc-powershell-patched',
      \
      \ 'coc-tsserver'          ,
      \ 'coc-eslint'            ,
      \ 'coc-prettier'          ,
      \ 'coc-stylelint'         ,
      \ 'coc-stylelintplus'     ,
      \ 'coc-html'              ,
      \ 'coc-css'               ,
      \ 'coc-emmet'             ,
      \ 'coc-vetur'             ,
      \ 'coc-angular'           ,
      \ 'coc-jest'              ,
      \ 'coc-webpack'           ,
      \ 'coc-import-cost'       ,
      \ 'coc-tslint'            ,
      \ 'coc-tslint-plugin'     ,
      \
      \ 'coc-json'              ,
      \ 'coc-svg'               ,
      \ 'coc-yaml'              ,
      \ 'coc-vimlsp'            ,
      \ 'coc-vimtex'            ,
      \ 'coc-omnisharp'         ,
      \ 'coc-lua'               ,
      \
      \ 'coc-bookmark'          ,
      \ 'coc-snippets'          ,
      \ 'coc-dictionary'        ,
      \ 'coc-tag'               ,
      \ 'coc-syntax'            ,
      \ 'coc-word'              ,
      \ 'coc-emoji'             ,
      \
      \ 'coc-pyls'              ,
      \ 'coc-calc'              ,
      \ ] "}}}
      " \ 'coc-tabnine'         ,
      " \ 'coc-rls'             ,
      " \ 'coc-lbdbq'           ,
      " \ 'coc-neosnippet'      ,
      " \ 'coc-ultisnips'       ,
      " \ 'coc-imselect'        , " only for mac

" autocmds {{{
augroup my_coc_settings
  autocmd!
  " show func signature after jump code placehold
  auto CursorHoldI,CursorMovedI * silent call CocActionAsync('showSignatureHelp')
  auto CursorHold               * if getline('.')[col('.')-1] =~? '\w' | silent call CocActionAsync('highlight') | endif

  auto VimEnter                 * call <sid>g_mappings()
  " auto VimEnter               * call <sid>g_mappings() | call coc#add_extension(g:coc_global_extensions)

  if (g:is_spacevim && !SpaceVim#layers#isLoaded('core#statusline')) || get(g:, 'statusline', '') =~# 'airline'
    auto User     CocDiagnosticChange  AirlineRefresh
  endif

  " auto copy coc-settings to .SpaceVim dir " {{{
  if findfile(expand($HOME.'/.SpaceVim/coc-settings.json')) ==# ''
    if g:is_unix
      auto User CocNvimInit
            \ exec '!ln -s "'.expand($HOME.'/.SpaceVim.d/coc-settings.json')
            \ .'" "'.expand($HOME.'/.SpaceVim/coc-settings.json').'"'
    elseif g:is_win
      auto User CocNvimInit
            \ exec '!mklink /h "'.expand($HOME.'/.SpaceVim/coc-settings.json')
            \ .'" "'.expand($HOME.'/vimfiles/coc-settings.json').'"'
    endif
  endif " }}}

  if get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet')) ==# 'neosnippet'
    auto VimEnter * call coc#config('snippets.ultisnips', {
          \ 'directories' : [ ]
          \ })
  endif
augroup END "}}}


" if !hasmapto('<Plug>(coc-funcobj-i)', 'v') && empty(maparg('if', 'x'))
  " xmap if <Plug>(coc-funcobj-i)
" endif
" if !hasmapto('<Plug>(coc-funcobj-a)', 'v') && empty(maparg('af', 'x'))
  " xmap af <Plug>(coc-funcobj-a)
" endif
" if !hasmapto('<Plug>(coc-funcobj-i)', 'o') && empty(maparg('if', 'o'))
  " omap if <Plug>(coc-funcobj-i)
" endif
" if !hasmapto('<Plug>(coc-funcobj-a)', 'o') && empty(maparg('af', 'o'))
  " omap af <Plug>(coc-funcobj-a)
" endif

" key mapping  {{{
  nmap  <silent>gd  <Plug>(coc-definition)
  nmap  <C-CR>      <Plug>(coc-codeaction)
function! s:g_mappings() abort
  nmap  gc  <Plug>(coc-codeaction)
  vmap  gc  <Plug>(coc-codeaction-selected)
  nmap  gt  <Plug>(coc-type-definition)
  nmap  gi  <Plug>(coc-implementation)
  nmap  gr  <Plug>(coc-references)
  nmap  ge  <Plug>(coc-rename)
  nmap  gf  <Plug>(coc-format)
  vmap  gf  <Plug>(coc-format-selected)
  nmap  gn  <Plug>(coc-refactor)
  nmap  gl  <Plug>(coc-diagnostic-info)
  nmap  [d  <Plug>(coc-diagnostic-prev)
  nmap  ]d  <Plug>(coc-diagnostic-next)
  nmap  gm  <Plug>(coc-fix-current)
  nmap  g.  <Plug>(coc-codelens-action)
  nmap  gp  <Plug>(coc-git-chunkinfo)
  nmap  [g  <Plug>(coc-git-prevchunk)
  nmap  ]g  <Plug>(coc-git-nextchunk)
  nmap  <silent>gh  :call CocActionAsync('doHover')<CR>
  nmap  <silent>gs  :call CocActionAsync('documentSymbols')<CR>
  nmap  <silent>gS  :call CocActionAsync('workspaceSymbols')<CR>
endfunction

if g:is_spacevim
  let g:_spacevim_mappings.c     = {'name': '+@ Coc ...'}
  let g:_spacevim_mappings.c.p   = {'name': '+CocUtil actions'}
  let g:_spacevim_mappings.c.p.i = ['call feedkeys(":CocInstall ")'  , 'coc install plugins' ]
  let g:_spacevim_mappings.c.p.u = ['call feedkeys(":CocUninstall ")', 'coc remove plugins'  ]
  let g:_spacevim_mappings.c.p.b = ['call coc#util#install({})'          , 'coc build source'    ]
  call SpaceVim#mapping#def('nnoremap', '<leader>cc', ':CocList commands<CR>', 'Coc Commands', '', 'Coc Commands')
  call SpaceVim#mapping#def('nnoremap', '<leader>ce', ':CocList snippets<CR>', 'Coc Snippets', '', 'Coc Snippets')
  call SpaceVim#mapping#def('nnoremap', '<leader>cl', ':CocList<CR>'         , 'Coc List'    , '', 'Coc List'    )
  call SpaceVim#mapping#def('nnoremap', '<leader>cs', ':CocConfig<CR>'       , 'Coc Settings', '', 'Coc Settings')
  call SpaceVim#mapping#def('nnoremap', '<leader>ci', ':CocInfo<CR>'         , 'Coc Info'    , '', 'Coc Info'    )
  call SpaceVim#mapping#def('nnoremap', '<leader>cr', ':CocRestart<CR>'      , 'Coc Restart' , '', 'Coc Restart' )

  " coc-post
  let g:_spacevim_mappings.w     = {'name': '+@ Web ...'}
  call SpaceVim#mapping#def('nnoremap', '<leader>wn', ':CocCommand post.new<CR>',
        \ 'create a post file' , '', 'create a post file' )
  call SpaceVim#mapping#def('nnoremap', '<leader>wp', ':CocCommand post.do<CR>',
        \ 'do request for current file' , '', 'do request for current file' )

else
  nnoremap <leader>cpi :call feedkeys(':CocInstall ')<CR>
  nnoremap <leader>cpu :call feedkeys(':CocUninstall ')<CR>
  nnoremap <leader>cpb :call coc#util#build()<CR>
  nnoremap <leader>cl  :CocList<CR>
  nnoremap <leader>cs  :CocConfig<CR>
  nnoremap <leader>ce  :CocList snippets<CR>
  nnoremap <leader>cc  :CocList commands<CR>
  nnoremap <leader>ci  :CocInfo<CR>
endif "}}}
