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
