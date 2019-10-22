" ================================================================================
" commands.vim
" ================================================================================
scriptencoding utf-8



command! -nargs=*  EchoMap          call util#maparg_wrapper(<f-args>)

command! -nargs=1  SpcPRBranch      call util#SPC_PR(<f-args>)

command! -nargs=?  -complete=filetype
                 \ MyCocSnipsEdit   call layers#autocomplete#coc_editsnips()(<f-args>)

command! -nargs=?  -complete=highlight
                 \ EchoHlight       call util#hlight_wrapper(<f-args>)

command! -nargs=?  -complete=help
                 \ EchoHelp         call util#vim_help_wrapper(<f-args>)


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.  Only define it when not
" defined already.
command! DiffOrig  vert new | set bt=nofile | r ++edit# | 0d_ | diffthis
      \ | wincmd p | diffthis



" Manipulate Plugin {{{
if g:is_spacevim
  command! -nargs=?
        \ -complete=custom,SpaceVim#commands#complete_plugin
        \ CheckInstall  call util#CheckInstall(<f-args>)
else
  if get(g:, 'plugmanager', 'vim-plug') ==# 'vim-plug'
    " update vim-plug itself
      " PlugUpgrade
    " update all plugins
      " PlugUpdate
    command! -nargs=?
          \ -complete=custom,g:plugs
          \ CheckInstall  call util#CheckInstall(<f-args>)

  elseif get(g:, 'plugmanager') ==# 'dein'
    let g:spacevim_plugin_manager_processes = 1000
    let g:spacevim_plugin_manager           = 'dein'
    command! -nargs=*
          \ PlugInstall   call SpaceVim#commands#install_plugin(<f-args>)

    command! -nargs=*
          \ -complete=custom,SpaceVim#commands#complete_plugin
          \ PlugUpdate    call SpaceVim#commands#update_plugin(<f-args>)

    command! -nargs=+
          \ -complete=custom,SpaceVim#commands#complete_plugin
          \ PlugReinstall call SpaceVim#commands#reinstall_plugin(<f-args>)

    command! -nargs=?
          \ -complete=custom,SpaceVim#commands#complete_plugin
          \ CheckInstall  call util#CheckInstall(<f-args>)
  endif
endif  " }}}

