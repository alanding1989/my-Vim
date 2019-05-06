"=============================================================================
" tools.vim --- tools layer
" Section: layers
"=============================================================================


function! layers#tools#plugins() abort
  let plugins = []
  if !g:is_spacevim
    let plugins += [
          \ ['lymslive/vimloo'                 , {'merged' : 0}],
          \ ['lymslive/vnote'                  , {'depends': 'vimloo',
          \ 'on_cmd': ['NoteBook', 'NoteNew', 'NoteEdit', 'NoteList', 'NoteConfig', 'NoteIndex', 'NoteImport'],
          \ 'on'    : ['NoteBook', 'NoteNew', 'NoteEdit', 'NoteList', 'NoteConfig', 'NoteIndex', 'NoteImport']}],
          \ ['mbbill/fencview'                 , {'on_cmd': 'FencAutoDetect'    , 'on': 'FencAutoDetect'}]    ,
          \ ['simnalamburt/vim-mundo'          , {'on_cmd': 'MundoToggle'       , 'on': 'MundoToggle'}]       ,
          \ ['wsdjeg/vim-cheat'                , {'on_cmd': 'Cheat'             , 'on': 'Cheat'}]             ,
          \ ['wsdjeg/Mysql.vim'                , {'on_cmd': 'SQLGetConnection'  , 'on': 'SQLGetConnection'}]  ,
          \ ['wsdjeg/SourceCounter.vim'        , {'on_cmd': 'SourceCounter'     , 'on': 'SourceCounter'}]     ,
          \ ['itchyny/calendar.vim'            , {'on_cmd': 'Calendar'          , 'on': 'Calendar'}]          ,
          \ ['junegunn/limelight.vim'          , {'on_cmd': 'Limelight'         , 'on': 'Limelight'}]         ,
          \ ['junegunn/goyo.vim'               , {'on_cmd': 'Goyo'              , 'on': 'Goyo'                , 'loadconf': 1}],
          \ ['MattesGroeger/vim-bookmarks'     , {'on_cmd': 'BookmarkShowAll'   , 'on': ['BookmarkShowAll', '<Plug>Bookmark'],
          \ 'on_map': '<Plug>Bookmark', 'loadconf_before': 1}],
          \ ]
    " call add(plugins, ['tpope/vim-scriptease', {'merged' : 0}])
    if executable('python3')
      call add(plugins, ['fedorenchik/VimCalc3', {'on_cmd': 'Calc', 'on': 'Calc'}])
    elseif executable('python')
      call add(plugins, ['gregsexton/VimCalc'  , {'on_cmd': 'Calc', 'on': 'Calc'}])
    endif
  endi
  return plugins
endfunction


function! layers#tools#config() abort
  nnoremap <silent><F6> :MundoToggle<CR>

  if !g:is_spacevim
    call s:vimcalc()
    nmap mm <Plug>BookmarkToggle
    nmap mi <Plug>BookmarkAnnotate
    nmap ma <Plug>BookmarkShowAll
    nmap mn <Plug>BookmarkNext
    nmap mp <Plug>BookmarkPrev
  endif
endfunction


function! s:vimcalc() abort
  augroup my_rainbow
    autocmd!
    autocmd FileType vimcalc setlocal nonu nornu nofoldenable
          \ | inoremap <silent><buffer><c-d> <esc>:q<cr>
          \ | nnoremap <silent> <buffer> q :bdelete<cr>
  augroup END
endfunction



" call SpaceVim#mapping#space#def('nnoremap', ['a', 'l'], 'Calendar', 'vim calendar', 1)
" call SpaceVim#mapping#space#def('nnoremap', ['e', 'a'], 'FencAutoDetect',
" \ 'Auto detect the file encoding', 1)
" call SpaceVim#mapping#space#def('nnoremap', ['a', 'c'], 'Calc', 'vim calculator', 1)
" call SpaceVim#mapping#space#def('nnoremap', ['w', 'c'],
" \ 'Goyo', 'centered-buffer-mode', 1)
" call SpaceVim#mapping#space#def('nnoremap', ['w', 'C'],
" \ 'ChooseWin | Goyo', 'centered-buffer-mode(other windows)', 1)

" vim:set et sw=2 cc=80:
