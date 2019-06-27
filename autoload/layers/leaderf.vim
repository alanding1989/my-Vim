"=============================================================================
" leaderf.vim --- leaderf layer
" Section: layers
"=============================================================================
scriptencoding utf-8


function! layers#leaderf#plugins() abort
  let plugins = [
        \ ['Yggdroot/LeaderF-marks', {'on_cmd' : 'LeaderfMarks'}]
        \ ]
  if !g:is_spacevim
    if !g:is_win
      call add(plugins , ['Yggdroot/LeaderF', {'merged': 0, 'build': './install.sh', 'do': './install.sh'}])
    else
      call add(plugins , ['Yggdroot/LeaderF', {'merged': 0, 'build': '.\install.bat', 'do': '.\install.bat'}])
    endif
  endif
  return plugins
endfunction


function! layers#leaderf#config() abort
  if g:is_spacevim
    nnoremap <silent><c-p> :call feedkeys(':LeaderfFile ')<CR>
    nnoremap <silent><c-y> :LeaderfBufTagAllCword<cr>

    " space mapping
    let g:_spacevim_mappings_space_custom += [
          \ ['nnoremap', ['h', 'i'], 'LeaderfHelpCword'  , '@ get help with cursor word/fuzzy find', 1],
          \ ['nnoremap', ['b', 'b'], 'LeaderfBuffer'     , 'buffer list'                           , 1],
          \ ['nnoremap', ['f', 'f'], 'LeaderfFile'       , 'find files in current working dir'     , 1],
          \ ['nnoremap', ['f', 'r'], 'LeaderfMru'        , 'open-recent-file'                      , 1],
          \ ['nnoremap', ['T', 'c'], 'LeaderfColorscheme', 'fuzzy find colorschemes'               , 1],
          \ ['nnoremap', ['j', 'i'], 'LeaderfFunction'   , 'jump to a definition in buffer'        , 1],
          \ ['nnoremap', ['f', 'b'], 'LeaderfMarks'      , 'check bookmarks'                       , 1],
          \ ]
    " leader mapping
    " NOTE: jump location quickfix register message use Denite/Unite
    let g:_spacevim_mappings.f     = get(g:_spacevim_mappings, 'f', {'name': '+@ Fuzzy Finder'})
    let g:_spacevim_mappings.f.h   = {'name' : '+Fuzzy find history'}
    let g:_spacevim_mappings.f.h.c = ['LeaderfHistoryCmd'   , 'fuzzy find cmd history'   ]
    let g:_spacevim_mappings.f.h.s = ['LeaderfHistorySearch', 'fuzzy find search history']

    noremap <silent><leader>fhc   :LeaderfHistoryCmd<cr>
    noremap <silent><leader>fhs   :LeaderfHistorySearch<cr>
    call SpaceVim#mapping#def('nnoremap', '<leader>fa', ':call feedkeys(":Leaderf ")<CR>',
          \ 'fuzzy finder prefix/Leaderf', '', 'fuzzy finder prefix/Leaderf')
    call SpaceVim#mapping#def('nnoremap', '<leader>fr', ':LeaderfMru<cr>',
          \ 'fuzzy find recent files'   , '', 'fuzzy find recent files')
    call SpaceVim#mapping#def('nnoremap', '<leader>fb', ':LeaderfBuffer<cr>',
          \ 'fuzzy find buffer list'    , '', 'fuzzy find buffer list')
    call SpaceVim#mapping#def('nnoremap', '<leader>ff', ':LeaderfFile<cr>',
          \ 'fuzzy find files in current working dir'   , '', 'fuzzy find files in current working dir'   )
    call SpaceVim#mapping#def('nnoremap', '<leader>fs', ':Leaderf rg --cword<cr>',
          \ 'fuzzy grep cursor word in project dir'     , '', 'fuzzy grep')
    call SpaceVim#mapping#def('nnoremap', '<leader>fc', ':LeaderfColorscheme<cr>',
          \ 'fuzzy find colorscheme'    , '', 'fuzzy find colorscheme')
    call SpaceVim#mapping#def('nnoremap', '<leader>fo', ':LeaderfFunction<cr>',
          \ 'fuzzy find function list in current buffer', '', 'fuzzy find function list in current buffer')
    call SpaceVim#mapping#def('nnoremap', '<leader>fO', ':LeaderfFunctionAll<cr>',
          \ 'fuzzy find function list in all buffer'    , '', 'fuzzy find function list in all buffer'    )
    call SpaceVim#mapping#def('nnoremap', '<leader>ft', ':LeaderfTag<cr>',
          \ 'fuzzy find tags'           , '', 'fuzzy find tags')
    call SpaceVim#mapping#def('nnoremap', '<leader>fT', ':LeaderfTagCword<cr>',
          \ 'fuzzy find tag cursor word in all buffer'  , '', 'fuzzy find tag cursor word in all buffer'  )
    call SpaceVim#mapping#def('nnoremap', '<leader>fi', ':Leaderf self<cr>',
          \ 'fuzzy finder interactive'  , '', 'fuzzy finder interactive')
    call SpaceVim#mapping#def('nnoremap', '<leader>fg', ':Leaderf gtags<cr>',
          \ 'fuzzy find gtags'          , '', 'fuzzy find gtags')

  else
    nnoremap <silent><c-p>       :call feedkeys(':LeaderfFile ')<CR>
    nnoremap <silent><c-y>       :LeaderfBufTagAllCword<cr>
    " space mapping
    nnoremap <silent><space>ff   :LeaderfFile<cr>
    nnoremap <silent><space>bb   :LeaderfBuffer<cr>
    nnoremap <silent><space>fr   :LeaderfMru<cr>
    nnoremap <silent><space>ji   :LeaderfFunction<cr>
    nnoremap <silent><space>hi   :LeaderfHelp<cr>
    nnoremap <silent><space>fb   :LeaderfMarks<cr>
    " leader mapping
    nnoremap <silent><leader>fa  :call feedkeys(':Leaderf ')<CR>
    nnoremap <silent><leader>fr  :LeaderfMru<cr>
    nnoremap <silent><leader>fb  :LeaderfBuffer<cr>
    nnoremap <silent><leader>ff  :LeaderfFile<cr>
    nnoremap <silent><leader>fs  :Leaderf rg --cword<cr>
    nnoremap <silent><leader>fc  :LeaderfColorscheme<cr>
    nnoremap <silent><leader>fo  :LeaderfFunction<cr>
    nnoremap <silent><leader>fO  :LeaderfFunctionAll<cr>
    nnoremap <silent><leader>ft  :LeaderfTag<cr>
    nnoremap <silent><leader>fT  :LeaderfTagCword<cr>
    nnoremap <silent><leader>fhc :LeaderfHistoryCmd<cr>
    nnoremap <silent><leader>fhs :LeaderfHistorySearch<cr>
    nnoremap <silent><leader>fg  :Leaderf gtags<cr>
    nnoremap <silent><leader>fi  :Leaderf self<cr>
  endif
endfunction
