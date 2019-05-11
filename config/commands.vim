" ================================================================================
" commands.vim
" ================================================================================
scriptencoding utf-8




command! -nargs=*  EchoMap          call util#maparg_wrapper(<f-args>)
command! -nargs=*  EchoHlight       call util#hlight_wrapper(<f-args>)
command! -nargs=+  OpenlinkOrSearch call util#OpenlinkOrSearch(<f-args>)
command! -nargs=?  SpcPR            call util#SPC_PR(<f-args>)


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.  Only define it when not
" defined already.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis



"================================================================================
" Vim
"================================================================================
if !g:is_spacevim
  if get(g:, 'plugmanager', 'dein') ==# 'vim-plug'
    " update vim-plug itself
      " PlugUpgrade
    " update all plugins
      " PlugUpdate
  elseif get(g:, 'plugmanager') ==# 'dein'
    let g:spacevim_plugin_manager_processes = 1000
    let g:spacevim_plugin_manager = 'dein'
    command! -nargs=*
          \ PlugInstall call SpaceVim#commands#install_plugin(<f-args>)

    command! -nargs=*
          \ -complete=custom,SpaceVim#commands#complete_plugin
          \ PlugUpdate call SpaceVim#commands#update_plugin(<f-args>)

    command! -nargs=+
          \ -complete=custom,SpaceVim#commands#complete_plugin
          \ PlugReinstall call SpaceVim#commands#reinstall_plugin(<f-args>)
  endif
endif
