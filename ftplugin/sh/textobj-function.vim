
" ================================================================================
" Vim additional ftplugin: vim/textobj-function
" ================================================================================


let b:textobj_function_select = function('textobj#function#sh#select')



if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|'
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= 'unlet b:textobj_function_select'

" __END__
" vim: foldmethod=marker
