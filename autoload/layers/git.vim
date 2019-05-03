"=============================================================================
" git.vim --- git layer
" Section: layers
"=============================================================================
scriptencoding utf-8



if has('patch-8.0.0027') || has('nvim')
  let s:git_plugin = 'gina'
else
  let s:git_plugin = 'gita'
endif


function! layers#git#plugins() abort
  let plugins = []
  " if g:is_nvim
    " call add(plugins, ['iamcco/sran.nvim' , {'build': 'yarn', 'do': 'yarn'}])
    " call add(plugins, ['iamcco/git-p.nvim', {'merged': 0}])
  " endif
  if g:is_spacevim && g:spacevim_filemanager ==# 'defx'
    call add(plugins, ['kristijanhusak/defx-git', {'merged': 0}])
  elseif !g:is_spacevim
    call add(plugins, ['junegunn/gv.vim'       , {'on_cmd': 'GV', 'on': 'GV'}])
    call add(plugins, ['tpope/vim-fugitive'    , {'merged': 0}])
    " show info of vcs in sign column, only support git
    if !My_Vim#layer#isLoaded('VersionControl')
      call add(plugins, ['airblade/vim-gitgutter', {'merged': 0}])
    endif
    if s:git_plugin ==# 'gina'
      call add(plugins, ['lambdalisue/gina.vim', {'on_cmd': 'Gina'}])
    elseif s:git_plugin ==# 'gita'
      call add(plugins, ['lambdalisue/vim-gita', {'on_cmd': 'Gita'}])
    elseif s:git_plugin ==# 'fugitive'
      call add(plugins, ['tpope/vim-dispatch'  , { 'merged' : 0}])
    endif
    if g:filemanager ==# 'defx'
      call add(plugins, ['kristijanhusak/defx-git', {'merged': 0}])
    elseif g:filemanager ==# 'nerdtree'
      call add(plugins, ['Xuyuanp/nerdtree-git-plugin', {'merged': 0}])
    endif
  endif
  return plugins
endfunction


function! layers#git#config() abort
  if g:is_spacevim
    " let g:_spacevim_mappings_space.g = get(g:_spacevim_mappings_space, 'g',  {'name' : '+VersionControl/git'})
    if s:git_plugin ==# 'gina'
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 's'], 'Gina status --opener=10split', 'git status', 1)
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'a'], 'Gina add %', 'stage current file', 1)
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'u'], 'Gina reset -q %', 'unstage current file', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'c'], 'Gina commit', 'edit git commit', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'p'], 'Gina push', 'git push', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'd'], 'Gina diff', 'view git diff', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'A'], 'Gina add .', 'stage all files', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'b'], 'Gina blame', 'view git blame', 1)
    elseif s:git_plugin ==# 'fugitive'
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 's'], 'Gstatus', 'git status', 1)
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'a'], 'Git add %', 'stage current file', 1)
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'u'], 'Git reset -q %', 'unstage current file', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'c'], 'Git commit', 'edit git commit', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'p'], 'Gpush', 'git push', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'd'], 'Gdiff', 'view git diff', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'A'], 'Git add .', 'stage all files', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'b'], 'Git blame', 'view git blame', 1)
    else
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 's'], 'Gita status', 'git status', 1)
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'a'], 'Gita add %', 'stage current file', 1)
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'u'], 'Gita reset %', 'unstage current file', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'c'], 'Gita commit', 'edit git commit', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'p'], 'Gita push', 'git push', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'd'], 'Gita diff', 'view git diff', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'A'], 'Gita add .', 'stage all files', 1)
      " call SpaceVim#mapping#space#def('nnoremap', ['g', 'b'], 'Gina blame', 'view git blame', 1)
    endif
    " augroup spacevim_layer_git
    "   autocmd!
    "   autocmd FileType diff nnoremap <buffer><silent> q :bd!<CR>
    "   autocmd FileType gitcommit setl omnifunc=SpaceVim#plugins#gitcommit#complete
    "   autocmd User GitGutter let &l:statusline = SpaceVim#layers#core#statusline#get(1)
    "   " Instead of reverting the cursor to the last position in the buffer, we
    "   " set it to the first line when editing a git commit message
    "   au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    " augroup END
    " call SpaceVim#mapping#space#def('nnoremap', ['g', 'M'], 'call call('
    "       \ . string(function('s:display_last_commit_of_current_line')) . ', [])',
    "       \ 'display the last commit message of the current line', 1)
    " call SpaceVim#mapping#space#def('nnoremap', ['g', 'V'], 'GV!', 'View git log of current file', 1)
    " call SpaceVim#mapping#space#def('nnoremap', ['g', 'v'], 'GV', 'View git log of current repo', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['g', 'f'], 'GitGutterFold', '@ toggle folding unchanged lines', 1)
    " let g:_spacevim_mappings_space.g.h = {'name' : '+Hunks'}
    " call SpaceVim#mapping#space#def('nmap', ['g', 'h', 'a'], '<Plug>GitGutterStageHunk', 'stage current hunk', 0)
    " call SpaceVim#mapping#space#def('nmap', ['g', 'h', 'r'], '<Plug>GitGutterUndoHunk' , 'undo cursor hunk', 0)
    " call SpaceVim#mapping#space#def('nmap', ['g', 'h', 'v'], '<Plug>GitGutterPreviewHunk', 'preview cursor hunk', 0)
    call SpaceVim#mapping#space#def('nmap', ['g', 'D'], '<Plug>(git-p-diff-preview)', '@ view git diff virtual', 0)
  else
    nnoremap <space>gf   :GitGutterFold<CR>
    nmap     <space>gD   <Plug>(git-p-diff-preview)
  endif
endfunction

" function! SpaceVim#layers#git#set_variable(var) abort
"
" let s:git_plugin = get(a:var,
" \ 'git-plugin',
" \ s:git_plugin)
"
" endfunction

" function! s:display_last_commit_of_current_line() abort
" let line = line('.')
" let file = expand('%')
" let cmd = 'git log -L ' . line . ',' . line . ':' . file
" let cmd .= ' --pretty=format:"%s" -1'
" let title = systemlist(cmd)[0]
" if v:shell_error == 0
" echo 'Last commit of current line is: ' . title
" endif
" endfunction

" vim:set et sw=2 cc=80:
