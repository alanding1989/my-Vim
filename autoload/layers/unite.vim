"=============================================================================
" unite.vim --- unite layer
" Section: layers
"=============================================================================
scriptencoding utf-8


function! layers#unite#plugins() abort
  let plugins = [
        \ ]
  if !g:is_spacevim
    let plugins += [
          \ ['Shougo/unite.vim' ],
          \ ]
    if !exists(':Denite') || g:pure_viml
      call add(plugins, ['thinca/vim-unite-history' , {'merged' : 0}])
      call add(plugins, ['Shougo/neoyank.vim'       , {'merged' : 0}])
      call add(plugins, ['osyo-manga/unite-quickfix', {'merged' : 0}])
      call add(plugins, ['SpaceVim/Unite-sources'   , {'merged' : 0}])
    endif
    " outline source <Leader>fo
    if g:pure_viml
      call add(plugins, ['Shougo/unite-outline', {'merged' : 0}])
      call add(plugins, ['Shougo/neomru.vim'   , {'merged' : 0}])
    endif
    " \ ['wsdjeg/unite-radio.vim', {'loadconf' : 1, 'merged' : 0}],
    " \ ['Shougo/unite-help', {'merged' : 0}],
    " \ ['hewes/unite-gtags' ,{'loadconf' : 1, 'merged' : 0}],

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


function! layers#unite#config() abort
  if g:is_spacevim
    unmap <leader>fh
    let g:_spacevim_mappings.f['[SPC]'] = ['Unite menu:CustomKeyMaps', 'fuzzy find custom key bindings']
    call SpaceVim#mapping#def('nnoremap', '<leader>fe' , ':Unite -buffer-name=register register<cr>',
          \ 'fuzzy find register'       , '', 'fuzzy find register'     )
    call SpaceVim#mapping#def('nnoremap', '<leader>fj' , ':Unite jump<cr>', 
          \ 'fuzzy find jump list'      , '', 'fuzzy find jump list'    )
    call SpaceVim#mapping#def('nnoremap', '<leader>fl' , ':Unite locationlist<cr>',
          \ 'fuzzy find location list'  , '', 'fuzzy find location list')
    call SpaceVim#mapping#def('nnoremap', '<leader>fy' , ':Unite history/yank',
          \ 'fuzzy find yank history'   , '', 'fuzzy find yank history')
    call SpaceVim#mapping#def('nnoremap', '<leader>fq' , ':Unite quickfix<cr>',
          \ 'fuzzy find quickfix'       , '', 'fuzzy find quickfix'     )
    call SpaceVim#mapping#space#def('nmap', ['q', 'p'], 'Unite -silent -winheight=17 -start-insert -direction=rightbelow menu:AddedPlugins',
          \ '@ list all installed plugins', 1) 


    call SpaceVim#mapping#def('nnoremap', '<leader>fm' , ':Unite output:message<cr>',
          \ 'fuzzy find message history', '', 'fuzzy find message history')
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
    nnoremap <silent><space>zz  :call call(<sid>_function('s:run_shell_cmd'), [])<cr>
    nnoremap <silent><space>zp  :call call(<sid>_function('s:run_shell_cmd_project'), [])<cr>
    nnoremap <silent><space>qp  :Unite -silent -winheight=13 -start-insert menu:AddedPlugins<cr>

    nnoremap <silent><leader>fe       :Unite -buffer-name=register register<cr>
    nnoremap <silent><leader>fj       :Unite jump<cr>
    nnoremap <silent><Leader>fl       :Unite locationlist<cr>
    nnoremap <silent><leader>fm       :Unite output:message<cr>
    nnoremap <silent><Leader>fy       :Unite history/yank<cr>
    nnoremap <silent><Leader>fq       :Unite quickfix<cr>
    " nnoremap <silent><Leader>fo       :Unite outline<cr>
    " nnoremap <silent><Leader>f<Space> :Unite menu:CustomKeyMaps<cr>
  endif
endfunction


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
