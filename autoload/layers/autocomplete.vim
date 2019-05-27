"=============================================================================
" autocomplete.vim --- autocomplete layer
" Section: layers
"=============================================================================
scriptencoding utf-8



let s:snippet_engine      = get(g:, 'spacevim_snippet_engine',
      \ get(g:, 'snippet_engine', 'neosnippet'))
let s:autocomplete_method = get(g:, 'spacevim_autocomplete_method',
      \ get(g:, 'autocomplete_method', 'deoplete'))


function! layers#autocomplete#plugins() abort
  let plugins = [
        \ ['alanding1989/my-vim-snippets',        {'merged': 0}],
        \ ['alanding1989/my-neosnippet-snippets', {'merged': 0}],
        \ ]
  " tmux complete {{{
  if $TMUX !=# ''
    call add(plugins, ['wellle/tmux-complete.vim', {'on_event' : 'InsertEnter'}])
  endif " }}}

  " coc {{{
  if s:autocomplete_method ==# 'coc'
    call add(plugins, ['jsfaint/coc-neoinclude', {'on_event': 'InsertEnter'}])
    "}}}

  " deoplete-tabnine {{{
  elseif s:autocomplete_method ==# 'deoplete' && g:enable_deotabline
    if g:is_win
      call add(plugins, ['tbodt/deoplete-tabnine', {'on_event': 'InsertEnter',
            \ 'build': 'powershell.exe .\install.psps1', 'do': 'powershell.exe .\install.psps1'}])
    else
      call add(plugins, ['tbodt/deoplete-tabnine', {'on_event': 'InsertEnter',
            \ 'build': './install.sh', 'do': './install.sh'}])
    endif 
    "}}}

  " ncm2 {{{
  elseif s:autocomplete_method ==# 'ncm2'
    let plugins += [
          \ ['ncm2/ncm2'                 , {'merged': 0}],
          \ ['ncm2/ncm2-neoinclude'      , {'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-path'            , {'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-bufword'         , {'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-syntax'          , {'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-tagprefix'       , {'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-gtags'           , {'on_event': 'InsertEnter'}],
          \ ['yuki-ycino/ncm2-dictionary', {'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-highprio-pop'    , {'on_event': 'InsertEnter'}],
          \ ['fgrsnau/ncm2-otherbuf'     , {'on_event': 'InsertEnter'}],
          \ ['ncm2/ncm2-tern'            , {'on_event': 'InsertEnter', 'build': 'npm install', 'do': 'npm install'}],
          \ ]
    if !g:is_win
      call add(plugins, ['ncm2/ncm2-match-highlight'  , {'on_event': 'InsertEnter'}])
    endif
    if g:is_nvim
      call add(plugins, ['ncm2/float-preview.nvim'    , {'on_event': 'InsertEnter'}])
    endif
    if s:snippet_engine ==# 'neosnippet'
      call add(plugins, ['ncm2/ncm2-neosnippet'       , {'on_event': 'InsertEnter'}])
    elseif s:snippet_engine ==# 'ultisnips'
      call add(plugins, ['ncm2/ncm2-ultisnips'        , {'on_event': 'InsertEnter'}])
    endif
    if g:is_spacevim
      call add(plugins, ['SpaceVim/nvim-yarp'         , {'merged': 0}])
      call add(plugins, ['SpaceVim/vim-hug-neovim-rpc', {'merged': 0}])
    endif
    "}}}

  " asyncomplete {{{
  elseif s:autocomplete_method ==# 'asyncomplete'
    call add(plugins,   ['prabirshrestha/asyncomplete-file.vim'       , {'on_event': 'InsertEnter'}])
    call add(plugins,   ['prabirshrestha/asyncomplete-tags.vim'       , {'on_event': 'InsertEnter'}])
    call add(plugins,   ['kyouryuukunn/asyncomplete-neoinclude.vim'   , {'on_event': 'InsertEnter'}])
    call add(plugins,   ['prabirshrestha/asyncomplete-necosyntax.vim' , {'on_event': 'InsertEnter'}])
    if s:snippet_engine ==# 'neosnippet'
      call add(plugins, ['prabirshrestha/asyncomplete-neosnippet.vim' , {'on_event': 'InsertEnter'}])
    elseif s:snippet_engine ==# 'ultisnips'
      call add(plugins, ['prabirshrestha/asyncomplete-ultisnips.vim'  , {'on_event': 'InsertEnter'}])
    endif
  endif
  "}}}

  if !g:is_spacevim " {{{
    let plugins += [
          \ ['Shougo/neco-syntax'              , {'on_event': 'InsertEnter'}],
          \ ['Shougo/neoinclude.vim'           , {'on_event': 'InsertEnter'}],
          \ ['Shougo/context_filetype.vim'     , {'on_event': 'InsertEnter'}],
          \ ['Shougo/echodoc.vim', {'on_event' : 'CompleteDone'}]
          \ ]
          " \ ['Raimondi/delimitMate'            , {'merged'  : 0}],
    if g:snippet_engine ==# 'neosnippet'
      call add(plugins, ['Shougo/neosnippet.vim', {'on_event': 'InsertEnter',
            \ 'on_ft': 'neosnippet', 'on_cmd': 'NeoSnippetEdit'}])
      call add(plugins, ['Shougo/neopairs.vim'  , {'on_event': 'InsertEnter'}])
    elseif g:snippet_engine ==# 'ultisnips'
      call add(plugins, ['SirVer/ultisnips'     , {'merged'  : 0}])
    endif

    if g:autocomplete_method ==# 'coc'
      call add(plugins, ['neoclide/coc.nvim'     , {'merged': 0, 'build': 'yarn install --frozen-lockfile',
            \ 'do': { -> coc#util#install() }}])
    elseif g:autocomplete_method ==# 'deoplete'
      call add(plugins, ['Shougo/deoplete.nvim'          , {'merged'  : 0}])
      call add(plugins, ['ujihisa/neco-look'             , {'on_event': 'InsertEnter'}])
      call add(plugins, ['SevereOverfl0w/deoplete-github', {'on_event': 'InsertEnter', 'for_ft': 'gitcommit'}])
    elseif g:autocomplete_method ==# 'ycm'
      call add(plugins, ['Valloric/YouCompleteMe', {'merged': 0, 'build': './install.py --clang-completer'}])
    elseif g:autocomplete_method ==# 'asyncomplete'
      call add(plugins, ['prabirshrestha/asyncomplete.vim'       , {'merged': 0, }])
      call add(plugins, ['prabirshrestha/asyncomplete-buffer.vim', {'merged': 0, }])
      call add(plugins, ['yami-beta/asyncomplete-omni.vim'       , {'merged': 0, }])
    endif
  endif "}}}
  return plugins
endfunction


function! layers#autocomplete#config() abort
  imap     <silent><expr><Tab>   mapping#tab#Super_Tab()
  imap     <silent><expr><CR>    mapping#enter#Super_Enter()
  call mapping#tab#S_Tab()
  call mapping#space#C_Space()
  inoremap <expr><Space>         ExpandEmptyPair()
  inoremap <silent><expr><C-h>   pumvisible() ? "\<C-e>\<C-r>=DelEmptyPair()\<CR>" :
        \ CurChar(0, '\s') && CurChar(0, '\S', -3) && CurChar(0, '\s', -4)
        \ ? "\<BS>\<left>\<BS>\<right>" : DelEmptyPair()

  call s:editsnippet()
  augroup layer_autocmplete
    autocmd!
    auto InsertLeave,CompleteDone * silent! pclose
  augroup END
endfunction


" edit snippets {{{
if g:is_spacevim
  function! s:editsnippet() abort
    let g:_spacevim_mappings.e = {'name':  '+@ Echo value/Edit snippets' }
    if s:snippet_engine ==# 'neosnippet'
      let g:_spacevim_mappings.e.n = ['call feedkeys(":NeoSnippetEdit -split -vertical ")', 'edit NeoSnippet snippets']

    elseif s:snippet_engine ==# 'ultisnips'
      let g:_spacevim_mappings.e.n = ['call feedkeys(":UltiSnipsEdit ")' , 'edit UltiSnips snippets']

    elseif s:snippet_engine ==# 'coc'
      let g:_spacevim_mappings.e.n = ['call feedkeys(":MyCocSnipsEdit ")', 'edit Coc-UltiSnips snippets']
    endif
  endfunction
else
  function! s:editsnippet() abort
    if s:snippet_engine ==# 'neosnippet'
      noremap <leader>en   :call feedkeys(':NeoSnippetEdit -split -vertical ')<CR>
    elseif s:snippet_engine ==# 'ultisnips'
      nnoremap <leader>en  :call feedkeys(':UltiSnipsEdit ')<CR>
    elseif s:snippet_engine ==# 'coc'
      nnoremap <leader>en  :call feedkeys(':MyCocSnipsEdit ')<CR>
    endif
  endfunction
endif
"}}}

" Plug functionality enhancement {{{
function! layers#autocomplete#coc_editsnips(...) abort 
  let ultisnips_dirpath = (g:is_win ?
        \ expand('D:/.cache/vimfiles/repos/github.com/alanding1989/my-vim-snippets/UltiSnips/') :
        \ expand('~/.cache/vimfiles-alan/repos/github.com/alanding1989/my-vim-snippets/UltiSnips/'))
  let ft  = a:0 > 0 ? a:1 : expand('%:e')
  let ext = '.snippets'
  let onelooppath = ultisnips_dirpath. ft. ext
  if glob(onelooppath) !=# ''
    exec 'topleft vsplit '. onelooppath
    return
  else
    let seclooppath = ultisnips_dirpath. ext.'/'. ft. ext
    if glob(seclooppath) !=# ''
      exec 'topleft vsplit '. seclooppath
      return
    endif
  endif
  exec 'topleft vsplit '. onelooppath
endfunction "}}}

