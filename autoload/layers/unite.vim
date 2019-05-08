"=============================================================================
" unite.vim --- unite layer
" Section: layers
"=============================================================================
scriptencoding utf-8


function! layers#unite#plugins() abort
  let plugins = []
  if !g:is_spacevim
    let plugins += [
          \ ['Shougo/unite.vim'],
          \ ['Shougo/unite-help', {'merged': 0}],
          \ ]
    if !exists(':Denite') || g:pure_viml || !g:has_py
      call add(plugins, ['thinca/vim-unite-history' , {'merged' : 0}])
      call add(plugins, ['Shougo/neoyank.vim'       , {'merged' : 0}])
      call add(plugins, ['osyo-manga/unite-quickfix', {'merged' : 0}])
      call add(plugins, ['SpaceVim/Unite-sources'   , {'merged' : 0}])
    endif
    " outline source <Leader>fo
    if g:pure_viml || !g:has_py
      call add(plugins, ['Shougo/unite-outline', {'merged' : 0}])
      call add(plugins, ['Shougo/neomru.vim'   , {'merged' : 0}])
    endif
    " \ ['wsdjeg/unite-radio.vim', {'merged': 0}],
    " \ ['hewes/unite-gtags' ,{'merged' : 0}],

    " \ ['mileszs/ack.vim',{'on_cmd' : 'Ack'}],
    " \ ['albfan/ag.vim',{'on_cmd' : 'Ag' , 'loadconf' : 1}],
    " \ ['dyng/ctrlsf.vim',{'on_cmd' : 'CtrlSF', 'on_map' : '<Plug>CtrlSF', 'loadconf' : 1 , 'loadconf_before' : 1}],

    if g:enable_googlesuggest
      call add(plugins, ['mopp/googlesuggest-source.vim',    {'merged': 0}])
      call add(plugins, ['mattn/googlesuggest-complete-vim', {'merged': 0}])
    endif
  endif
  return plugins
endfunction


if !exists(':Denite') && !exists(':Leaderf') && !exists(':Fzf')
  function! layers#unite#config() abort
    nnoremap <C-p> :call feedkeys(':Unite file_rec/'.(has('nvim') ? 'neovim' : 'async').' -path=')<CR>
    if g:is_spacevim
      unlet g:_spacevim_mappings.f.h | unmap <leader>fh
      unlet g:_spacevim_mappings.f.p | unmap <leader>fp
      let g:_spacevim_mappings.f['[SPC]'] = ['Unite menu:CustomKeyMaps', 'fuzzy find custom key bindings']
      call SpaceVim#mapping#space#def('nnoremap', ['f', 'f'],
            \ 'Unite file_rec/' . (has('nvim') ? 'neovim' : 'async'),
            \ 'Find files in current working dir', 1)

      call SpaceVim#mapping#def('nnoremap', '<leader>fa', ':call feedkeys(":Unite")<CR>',
            \ 'fuzzy finder prefix/Unite', '', 'fuzzy finder prefix/Unite')
      call SpaceVim#mapping#def('nnoremap', '<leader>ff', ':Unite file_rec/'
            \ .(has('nvim') ? 'neovim' : 'async').'<CR>',
            \ 'fuzzy find files in current working dir', '', 'fuzzy find files in current working dir')
      call SpaceVim#mapping#def('nnoremap', '<leader>fr', ':Unite file_mru<CR>',
            \ 'fuzzy find recent file'    , '', 'fuzzy find recent file'  )
      call SpaceVim#mapping#def('nnoremap', '<leader>fe', ':Unite -buffer-name=register register<CR>',
            \ 'fuzzy find register'       , '', 'fuzzy find register'     )
      call SpaceVim#mapping#def('nnoremap', '<leader>fj', ':Unite jump<CR>',
            \ 'fuzzy find jump list'      , '', 'fuzzy find jump list'    )
      call SpaceVim#mapping#def('nnoremap', '<leader>fl', ':Unite locationlist<CR>',
            \ 'fuzzy find location list'  , '', 'fuzzy find location list')
      call SpaceVim#mapping#def('nnoremap', '<leader>fy', ':Unite history/yank<CR>',
            \ 'fuzzy find yank history'   , '', 'fuzzy find yank history')
      call SpaceVim#mapping#def('nnoremap', '<leader>fq', ':Unite quickfix<CR>',
            \ 'fuzzy find quickfix'       , '', 'fuzzy find quickfix'     )
      call SpaceVim#mapping#def('nnoremap', '<leader>fm', ':Unite output:message<CR>',
            \ 'fuzzy find message history', '', 'fuzzy find message history')
      call SpaceVim#mapping#def('nnoremap', '<leader>fc', ':Unite colorscheme<CR>',
            \ 'fuzzy find colorschemes'   , '', 'fuzzy find colorschemes')

      call SpaceVim#mapping#space#def('nmap', ['q', 'p'], 'Unite -silent -winheight=17 -start-insert -direction=rightbelow menu:AddedPlugins',
            \ '@ list all installed plugins', 1)

    else
      " for Vim
      " NOTE: Default sources:
      " file    : <Leader>ff
      " jump    : <Leader>fj
      " register: <Leader>fe
      " messages: <Leader>fm
      if has('nvim')
        let cmd = 'Unite file_rec/neovim'
      else
        let cmd = 'Unite file_rec/async'
      endif
      nnoremap <silent><space>ff        :exec 'UniteWithBufferDir file_rec/'.(has('nvim') ? 'neovim' : 'async')<CR>
      nnoremap <silent><space>fr        :Unite file_mru<CR>
      nnoremap <silent><space>zz        :call call(<sid>_function('s:run_shell_cmd'), [])<CR>
      nnoremap <silent><space>zp        :call call(<sid>_function('s:run_shell_cmd_project'), [])<CR>
      nnoremap <silent><space>qp        :Unite -silent -winheight=13 -start-insert menu:AddedPlugins<CR>

      nnoremap <silent><leader>fa       :call feedkeys(':Unite ')<CR>
      nnoremap <silent><leader>ff       :exec 'UniteWithBufferDir file_rec/'.(has('nvim') ? 'neovim' : 'async')<CR>
      nnoremap <silent><leader>fr       :Unite file_mru<CR>
      nnoremap <silent><leader>fe       :Unite -buffer-name=register register<CR>
      nnoremap <silent><leader>fj       :Unite jump<CR>
      nnoremap <silent><Leader>fl       :Unite locationlist<CR>
      nnoremap <silent><leader>fm       :Unite output:message<CR>
      nnoremap <silent><Leader>fy       :Unite history/yank<CR>
      nnoremap <silent><Leader>fq       :Unite quickfix<CR>
      nnoremap <silent><Leader>fo       :Unite outline<CR>
      " nnoremap <silent><Leader>f<Space> :Unite menu:CustomKeyMaps<CR>
    endif
  endfunction
else
  function! layers#unite#config() abort
    return
  endfunction
endif

function! s:run_shell_cmd() abort
  let cmd = input('Please input shell command:', '', 'customlist,')
  if !empty(cmd)
    call unite#start([['output/shellcmd', cmd]], {'log': 1, 'wrap': 1,'start_insert':0})
  endif
endfunction

function! s:run_shell_cmd_project() abort
  let cmd = input('Please input shell command:', '', 'customlist,SpaceVim#plugins#bashcomplete#complete')
  if !empty(cmd)
    call unite#start([['output/shellcmd', cmd]], {
          \ 'log': 1,
          \ 'wrap': 1,
          \ 'start_insert':0,
          \ 'path' : SpaceVim#plugins#projectmanager#current_root(),
          \ })
  endif
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
