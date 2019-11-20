"=============================================================================
" tools.vim --- tools layer
" Section: layers
"=============================================================================


function! layers#tools#plugins() abort
  let plugins = []
  if !g:is_spacevim
    let plugins += [
          \ ['lymslive/vimloo'              , {'merged' : 0}],
          \ ['lymslive/vnote'               , {'depends': 'vimloo',
          \ 'on_cmd': ['NoteBook', 'NoteNew', 'NoteEdit', 'NoteList', 'NoteConfig', 'NoteIndex', 'NoteImport'],
          \ 'on'    : ['NoteBook', 'NoteNew', 'NoteEdit', 'NoteList', 'NoteConfig', 'NoteIndex', 'NoteImport']}],
          \ ['mbbill/fencview'              , {'on_cmd' : 'FencAutoDetect'  , 'on': 'FencAutoDetect'          }],
          \ ['simnalamburt/vim-mundo'       , {'on_cmd' : 'MundoToggle'     , 'on': 'MundoToggle'             }],
          \ ['wsdjeg/vim-cheat'             , {'on_cmd' : 'Cheat'           , 'on': 'Cheat'                   }],
          \ ['wsdjeg/Mysql.vim'             , {'on_cmd' : 'SQLGetConnection', 'on': 'SQLGetConnection'        }],
          \ ['wsdjeg/SourceCounter.vim'     , {'on_cmd' : 'SourceCounter'   , 'on': 'SourceCounter'           }],
          \ ['itchyny/calendar.vim'         , {'on_cmd' : 'Calendar'        , 'on': 'Calendar'                }],
          \ ['junegunn/limelight.vim'       , {'on_cmd' : 'Limelight'       , 'on': 'Limelight'               }],
          \ ['junegunn/goyo.vim'            , {'on_cmd' : 'Goyo'            , 'on': 'Goyo'                    }],
          \ ['MattesGroeger/vim-bookmarks'  , {'on_cmd' : 'BookmarkShowAll' , 'on': 'BookmarkShowAll', 'on_map': '<Plug>Bookmark'}]
          \ ]
    " vimloo        : VimL object orient programming frame and tools
    " vnote         : A dairy note edit and manage tool in vim
    " fencview      : Auto detect CJK and Unicode file encodings
    " vim-scriptease: A vim plugin for writing vim plugins
    " vim-mundo     : Vim undo tree visualizer
    " vim-cheat     : view cheatsheets via vim
    " Mysql         : vim plugin support use mysql via vim
    " goyo/limelight: ZenMode
    "
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
  call <sid>vnote()
  call <sid>vim_cheat()

  if !g:is_spacevim
    nnoremap <silent> <Space>al  :Calendar<CR>
    nnoremap <silent> <Space>ac  :Calc<CR>
    nnoremap <silent> <Space>ea  :FencAutoDetect<CR>
    nnoremap <silent> <Space>wc  :Goyo<CR>
    nnoremap <silent> <Space>wC  :ChooseWin\|Goyo<CR>
    call <sid>vimcalc()
    call <sid>vim_bookmarks()
  endif
endfunction

function! s:vim_cheat() abort
  let g:Cheat_EnableDefaultMappings = 0
  if g:is_spacevim
    let g:_spacevim_mappings.s = {'name': '+@ CheatSheet'}
    call SpaceVim#mapping#def('nnoremap', '<leader>so', ':Cheat<CR>',
          \ 'open CheatSheet'           , '', 'open CheatSheet')
    call SpaceVim#mapping#def('nnoremap', '<leader>sa', ':Cheat -add ',
          \ 'add new CheatSheet'        , '', 'add new CheatSheet')
    call SpaceVim#mapping#def('nnoremap', '<leader>su', ':Cheat -update ',
          \ 'update specific CheatSheet', '', 'update specific CheatSheet')
    call SpaceVim#mapping#def('nnoremap', '<leader>sc', ':CheatCurrent<CR>',
          \ 'open cursor CheatSheet'    , '', 'open cursor CheatSheet')
  else
    nnoremap <silent><leader>Co   :Cheat<CR>
    nnoremap <silent><leader>Ca   :call feedkeys(":Cheat -add ")<CR>
    nnoremap <silent><leader>Cu   :call feedkeys(":Cheat -update ")<CR>
    nnoremap <silent><leader>Cc   :CheatCurrent<CR>
  endif
endfunction

function! s:vnote() abort
  if g:is_spacevim
    let g:_spacevim_mappings.n = {'name': '+@ NoteBook'}
    call SpaceVim#mapping#def('nnoremap', '<leader>no', ':NoteBook<CR>'  ,
          \ 'open NoteBook'    , '', 'open NoteBook')
    call SpaceVim#mapping#def('nnoremap', '<leader>nn', ':NoteNew<CR>'   ,
          \ 'creat new Note'   , '', 'creat new Note')
    call SpaceVim#mapping#def('nnoremap', '<leader>ne', ':NoteEdit<CR>'  ,
          \ 'edit today`s Note', '', 'edit today`s Note')
    call SpaceVim#mapping#def('nnoremap', '<leader>nl', ':NoteList<CR>'  ,
          \ 'check Notelist'   , '', 'check Note list')
    call SpaceVim#mapping#def('nnoremap', '<leader>nc', ':NoteConfig<CR>',
          \ 'change NoteConfig', '', 'change NoteConfig')
    call SpaceVim#mapping#def('nnoremap', '<leader>ni', ':NoteImport<CR>',
          \ 'import Notes'     , '', 'import Notes')
    call SpaceVim#mapping#def('nnoremap', '<leader>ns', ':NoteList<CR>'  ,
          \ 'check Noteindex'  , '', 'check Noteindex')
  else
    nnoremap <silent><leader>no  :NoteBook<CR>
    nnoremap <silent><leader>nn  :NoteNew<CR>
    nnoremap <silent><leader>ne  :NoteEdit<CR>
    nnoremap <silent><leader>nl  :NoteList<CR>
    nnoremap <silent><leader>nc  :NoteConfig<CR>
    nnoremap <silent><leader>ni  :NoteImport<CR>
    nnoremap <silent><leader>ns  :NoteList<CR>
  endif
endfunction

function! s:vimcalc() abort
  augroup my_rainbow
    autocmd!
    autocmd FileType vimcalc setlocal nonu nornu nofoldenable
          \ | inoremap <silent><buffer> <c-d> <esc>:q<cr>
          \ | nnoremap <silent><buffer> q     :bdelete<cr>
  augroup END
endfunction

function! s:vim_bookmarks() abort
  nnoremap <silent> mm :<C-u>BookmarkToggle<Cr>
  nnoremap <silent> mi :<C-u>BookmarkAnnotate<Cr>
  nnoremap <silent> ma :<C-u>BookmarkShowAll<Cr>
  nnoremap <silent> mn :<C-u>BookmarkNext<Cr>
  nnoremap <silent> mp :<C-u>BookmarkPrev<Cr>
endfunction


" vim:set et sw=2 cc=80:
