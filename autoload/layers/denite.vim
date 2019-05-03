"=============================================================================
" denite.vim --- denite layer
" Section: layers
"=============================================================================

function! layers#denite#plugins() abort
  let plugins = []
  if !g:is_spacevim
    let plugins += [
          \ ['Shougo/denite.nvim'     , {'merged' : 0}],
          \ ['pocari/vim-denite-emoji', {'merged' : 0}],
          \ ['Shougo/neoyank.vim'     , {'merged' : 0}],
          \ ['chemzqm/unite-location' , {'merged' : 0}],
          \ ['Shougo/unite-outline'   , {'merged' : 0}],
          \ ['Shougo/neomru.vim'      , {'merged' : 0}],
          \ ]
    " call add(plugins, ['ozelentok/denite-gtags', {'merged' : 0}])
  endif
  return plugins
endfunction


function! layers#denite#config() abort
  if g:is_spacevim
    unmap <leader>fh
    unmap <leader>fp

    nnoremap         <C-p>      :call <sid>warp_denite('Denite file/rec -path=')<left><left>
    nnoremap <silent><C-y>      :call <sid>warp_denite('DeniteCursorWord outline')<CR>

    call SpaceVim#mapping#space#def('nnoremap', ['q', 'p'], 'Denite menu:AddedPlugins',
          \ '@ list all installed plugins', 1)

    let g:_spacevim_mappings.f          = {'name' : '+@ Fuzzy Finder'}
    let g:_spacevim_mappings.f['[SPC]'] = ['Denite menu:CustomKeyMaps', 'fuzzy find custom key bindings']
    call SpaceVim#mapping#def('nnoremap', '<leader>fe', ':Denite register<CR>',
          \ 'fuzzy find registers'      , '', 'fuzzy find registers')
    call SpaceVim#mapping#def('nnoremap', '<leader>fj', ':Denite jump<CR>',
          \ 'fuzzy find jump list'      , '', 'fuzzy find jump list')
    call SpaceVim#mapping#def('nnoremap', '<leader>fl', ':Denite location_list<CR>',
          \ 'fuzzy find location list'  , '', 'fuzzy find location list')
    call SpaceVim#mapping#def('nnoremap', '<leader>fm' , ':Denite output:message<CR>',
          \ 'fuzzy find message history', '', 'fuzzy find message history')
    call SpaceVim#mapping#def('nnoremap', '<leader>fq' , ':Denite quickfix<CR>',
          \ 'fuzzy find quickfix'       , '', 'fuzzy find quickfix'     )
    call SpaceVim#mapping#def('nnoremap', '<leader>fd', ':call feedkeys(":Denite")<CR>',
          \ 'fuzzy finder prefix/Denite', '', 'fuzzy finder prefix/Denite')

    call SpaceVim#mapping#def('nnoremap', '<leader>fa', ':call feedkeys(":Denite")<CR>',
          \ 'fuzzy finder prefix/Denite', '', 'fuzzy finder prefix/Denite')
    call SpaceVim#mapping#def('nnoremap', '<leader>fr', ':Denite file_mru<CR>',
          \ 'fuzzy find recent files'   , '', 'fuzzy find recent files')
    call SpaceVim#mapping#def('nnoremap', '<leader>fb', ':Denite buffer<CR>',
          \ 'fuzzy find buffer list'    , '', 'fuzzy find buffer list')
    call SpaceVim#mapping#def('nnoremap', '<leader>ff', ':DeniteProjectDir file/rec<CR>',
          \ 'fuzzy files in current working dir', '', 'fuzzy find files in current working dir')
    call SpaceVim#mapping#def('nnoremap', '<leader>fs', ':Denite grep<CR>',
          \ 'fuzzy grep'                , '', 'fuzzy grep')
    call SpaceVim#mapping#def('nnoremap', '<leader>fc', ':Denite colorscheme<CR>',
          \ 'fuzzy find colorscheme'    , '', 'fuzzy find colorscheme')
    call SpaceVim#mapping#def('nnoremap', '<leader>fy', ':Denite neoyank<CR>',
          \ 'fuzzy find yank history'   , '', 'fuzzy find yank history')
    call SpaceVim#mapping#def('nnoremap', '<leader>fo', ':Denite outline<CR>',
          \ 'fuzzy find outline'        , '', 'fuzzy find outline')
    call SpaceVim#mapping#space#def('nnoremap', ['f', 'f'], 'call call('
          \ . string(s:_function('s:warp_denite')).', ["DeniteProjectDir file/rec"])',
          \ 'Find files in the directory of the current buffer',
          \ 1)

  else
    nnoremap <silent> <space>qp   :Denite menu:AddedPlugins<CR>

    " leader mapping
    nnoremap <silent> <Leader>fe  :<C-u>Denite register<CR>
    nnoremap <silent> <Leader>fj  :<C-u>Denite jump<CR>
    nnoremap <silent> <Leader>fl  :<C-u>Denite location_list<CR>
    nnoremap <silent> <Leader>fm  :<C-u>Denite output:message<CR>
    nnoremap <silent> <Leader>fy  :<C-u>Denite neoyank<CR>
    nnoremap <silent> <Leader>fq  :<C-u>Denite quickfix<CR>
    if !exists(':Leaderf')
      nnoremap <silent><c-p>        :call <sid>warp_denite('Denite file/rec')<CR>
      nnoremap <silent><c-y>        :call <sid>warp_denite('DeniteCursorWord outline')<CR>
      " space mapping
      nnoremap <silent><space>ff    :call <sid>warp_denite('DeniteProjectDir file/rec')<CR>
      nnoremap <silent><space>bb    :call <sid>warp_denite('Denite buffer')<CR>
      nnoremap <silent><space>fr    :call <sid>warp_denite('Denite file_mru')<CR>
      nnoremap <silent><space>ji    :call <sid><sid>warp_d('Denite outline')<CR>
      nnoremap <silent><space>hi    :call <sid>warp_denite('DeniteCursorWord help')<CR>
      " leader mapping
      nnoremap          <Leader>fa  :<C-u>Denite
      nnoremap <silent> <Leader>fr  :<C-u>Denite file_mru<CR>
      nnoremap <silent> <Leader>fb  :<C-u>Denite buffer<CR>
      nnoremap <silent> <Leader>ff  :<C-u>DeniteProjectDir file/rec<CR>
      nnoremap <silent> <Leader>fs  :<C-u>Denite grep<CR>
      nnoremap <silent> <leader>fc  :<C-u>Denite colorscheme<CR>
      nnoremap <silent> <Leader>fo  :<C-u>Denite outline<CR>
    endif
  endif
endfunction


function! s:warp_denite(cmd) abort
  exe a:cmd
  doautocmd WinEnter
endfunction

" function() wrapper
if v:version > 703 || v:version == 703 && has('patch1170')
  function! s:_function(fstr) abort
    return function(a:fstr)
  endfunction
else
  function! s:_SID() abort
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze__SID$')
  endfunction
  let s:_s = '<SNR>' . s:_SID() . '_'
  function! s:_function(fstr) abort
    return function(substitute(a:fstr, 's:', s:_s, 'g'))
  endfunction
endif
" vim:set et sw=2 cc=80:
