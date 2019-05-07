"=============================================================================
" autocomplete.vim --- autocomplete layer
" Section: layers
"=============================================================================
scriptencoding utf-8



function! layers#autocomplete#plugins() abort
  let plugins = [
        \ ['alanding1989/my-vim-snippets',        {'merged': 0}],
        \ ['alanding1989/my-neosnippet-snippets', {'merged': 0}],
        \ ]
  if $TMUX !=# ''
    call add(plugins, ['wellle/tmux-complete.vim', {'on_event' : 'InsertEnter'}])
  endif
  " coc {{{
  if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'coc'
    call add(plugins, ['jsfaint/coc-neoinclude', {'on_event': 'InsertEnter'}])
    "}}}

  " deoplete-tabnine {{{
  elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'deoplete'
        \ && g:enable_deotabline
    if g:is_win
      call add(plugins, ['tbodt/deoplete-tabnine', {'on_event': 'InsertEnter',
            \ 'build': 'powershell.exe .\install.psps1', 'do': 'powershell.exe .\install.psps1'}])
    else
      call add(plugins, ['tbodt/deoplete-tabnine', {'on_event': 'InsertEnter',
            \ 'build': './install.sh', 'do': './install.sh'}])
    endif "}}}

  " ncm2 {{{
  elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'ncm2'
    let plugins += [
          \ ['ncm2/ncm2'                 , {'merged': 0}],
          \ ['roxma/nvim-yarp'           , {'merged': 0}],
          \ ['ncm2/ncm2-neoinclude'      , {'merged': 0, 'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-syntax'          , {'merged': 0, 'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-bufword'         , {'merged': 0, 'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-path'            , {'merged': 0, 'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-github'          , {'merged': 0, 'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-tagprefix'       , {'merged': 0, 'on_event': 'InsertEnter'}],
          \ ['filipekiss/ncm2-look.vim'  , {'merged': 0, 'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-gtags'           , {'merged': 0, 'on_event': 'InsertEnter'}],
          \ ['yuki-ycino/ncm2-dictionary', {'merged': 0, 'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-highprio-pop'    , {'merged': 0, 'on_event': 'InsertEnter'}],
          \ ['fgrsnau/ncm2-otherbuf'     , {'on_event': ['InsertEnter', 'CursorHold', 'CursorHoldI']}],
          \ ['ncm2/ncm2-tern'            , {'on_event': 'InsertEnter',
          \ 'build': 'npm install', 'do': 'npm install'}],
          \ ]
    if !g:is_win
      call add(plugins, ['ncm2/ncm2-match-highlight' , {'merged': 0, 'on_event': 'InsertEnter'}])
    endif
    if has('nvim')
      " call add(plugins, ['ncm2/float-preview.nvim', {'merged': 0}])
    endif
    if get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet')) ==# 'neosnippet'
      call add(plugins, ['ncm2/ncm2-neosnippet', {'merged': 0, 'on_event': 'InsertEnter'}])
    elseif get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet')) ==# 'ultisnips'
      call add(plugins, ['ncm2/ncm2-ultisnips' , {'merged': 0, 'on_event': 'InsertEnter'}])
    endif
    "}}}

  " asyncomplete {{{
  elseif get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'asyncomplete'
    call add(plugins, ['prabirshrestha/asyncomplete-file.vim'         , {'merged': 0, 'on_event': 'InsertEnter'}])
    call add(plugins, ['prabirshrestha/asyncomplete-tags.vim'         , {'merged': 0, 'on_event': 'InsertEnter'}])
    call add(plugins, ['kyouryuukunn/asyncomplete-neoinclude.vim'     , {'merged': 0, 'on_event': 'InsertEnter'}])
    call add(plugins, ['prabirshrestha/asyncomplete-necosyntax.vim'   , {'merged': 0, 'on_event': 'InsertEnter'}])
    if get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet')) ==# 'neosnippet'
      call add(plugins, ['prabirshrestha/asyncomplete-neosnippet.vim' , {'merged': 0, 'on_event': 'InsertEnter'}])
    elseif get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet')) ==# 'ultisnips'
      call add(plugins, ['prabirshrestha/asyncomplete-ultisnips.vim'  , {'merged': 0, 'on_event': 'InsertEnter'}])
    endif
  endif
  "}}}

  if !g:is_spacevim " {{{
    let plugins += [
          \ ['Shougo/neco-syntax'              , { 'on_event': 'InsertEnter'}],
          \ ['Shougo/neoinclude.vim'           , { 'on_event': 'InsertEnter'}],
          \ ['Shougo/context_filetype.vim'     , { 'on_event': 'InsertEnter'}],
          \ ['Raimondi/delimitMate'            , { 'merged'  : 0}],
          \ ['Shougo/echodoc.vim', {'on_event' : 'CompleteDone'}]
          \ ]
    if g:snippet_engine ==# 'neosnippet'
      call add(plugins, ['Shougo/neosnippet.vim', {'on_event': 'InsertEnter',
            \ 'on_ft': 'neosnippet', 'on_cmd': 'NeoSnippetEdit'}])
      call add(plugins, ['Shougo/neopairs.vim' , {'on_event': 'InsertEnter'}])
    elseif g:snippet_engine ==# 'ultisnips'
      call add(plugins, ['SirVer/ultisnips'   , {'merged'  : 0}])
    endif

    if g:autocomplete_method ==# 'coc'
      call add(plugins, ['neoclide/coc.nvim',  {'merged': 0, 'build': 'yarn install --frozen-lockfile',
            \ 'do': { -> coc#util#install() }}])
    elseif g:autocomplete_method ==# 'deoplete'
      call add(plugins, ['Shougo/deoplete.nvim', {'merged'  : 0}])
      call add(plugins, ['ujihisa/neco-look'   , {'on_event': 'InsertEnter'}])
    elseif g:autocomplete_method ==# 'asyncomplete'
      call add(plugins, ['prabirshrestha/asyncomplete.vim'       , {'merged': 0, }])
      call add(plugins, ['prabirshrestha/asyncomplete-buffer.vim', {'merged': 0, }])
      call add(plugins, ['yami-beta/asyncomplete-omni.vim'       , {'merged': 0, }])
    endif
  endif "}}}
  return plugins
endfunction


function! layers#autocomplete#config() abort
  auto InsertLeave * if pumvisible() ==# 0 | pclose | endif

  imap <silent><expr><Tab>   mapping#tab#super_tab()
  imap <silent><expr><CR>    mapping#enter#super_enter()
  call mapping#tab#S_tab()
  call mapping#space#c_space()
  call s:snip_source()

  " delimitMate
  imap <expr> <C-h> pumvisible() ? "\<C-e><BS>" : "\<Plug>delimitMateBS"
  imap <expr> >     match(getline('.'), '\v^\s*\zs(if\|wh)') > -1 ? '> ' : "\<Plug>delimitMate\>"
  imap <expr> <     match(getline('.'), '\v^\s*\zs(if\|wh)') > -1 ? '< ' : "\<Plug>delimitMate\<"
  imap <expr> (     "\<Plug>delimitMate("
endfunction

function! s:snip_source() abort " {{{
  if get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine', 'neosnippet')) ==# 'neosnippet'
    if g:is_spacevim
      if SpaceVim#layers#isLoaded('denite')
        call SpaceVim#custom#SPC('nnoremap', ['i', 's'], 'Denite neosnippet', 'neosnippet', 1)
      elseif SpaceVim#layers#isLoaded('unite')
        call SpaceVim#custom#SPC('nnoremap', ['i', 's'], 'Unite neosnippet' , 'neosnippet', 1)
      endif
    else
      if My_Vim#layer#isLoaded('denite')
        nnoremap <space>is :Denite neosnippet<CR>
      elseif My_Vim#layer#isLoaded('unite')
        nnoremap <space>is :Unite neosnippet<CR>
      endif
      noremap <leader>ae   :NeoSnippetEdit -split -vertical<CR>
    endif

  elseif get(g:, 'spacevim_snippet_engine', get(g:, 'snippet_engine')) ==# 'ultisnips'
    if g:is_spacevim
      if SpaceVim#layers#isLoaded('denite')
        call SpaceVim#custom#SPC('nnoremap', ['i', 's'], 'Denite ultisnips', 'ultisnips', 1)
      elseif SpaceVim#layers#isLoaded('unite')
        call SpaceVim#custom#SPC('nnoremap', ['i', 's'], 'Unite ultisnips' , 'ultisnips', 1)
      endif
    else
      if My_Vim#layer#isLoaded('denite')
        nnoremap <space>is :Denite ultisnips<CR>
      elseif My_Vim#layer#isLoaded('unite')
        nnoremap <space>is :Unite ultisnips<CR>
      endif
      nnoremap <leader>ae  :UltiSnipsEdit<CR>
    endif
  endif
endfunction "}}}
