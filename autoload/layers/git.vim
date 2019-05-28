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

let s:gitgutter_plugin = get(g:, 'spacevim_gitgutter_plugin', 
      \ get(g:, 'gitgutter_plugin', 'vim-gitgutter'))



function! layers#git#plugins() abort
  let plugins = []
  call add(plugins, ['sodapopcan/vim-twiggy', {'on_cmd': 'Twiggy', 'on': 'Twiggy'}])
  if g:is_spacevim && s:gitgutter_plugin ==# 'coc'
    auto VimEnter * call coc#config('git', {"enableGutters": "true"})
  elseif !g:is_spacevim
    "{{{
    call add(plugins, ['junegunn/gv.vim'       , {'on_cmd': 'GV', 'on': 'GV'}])
    call add(plugins, ['tpope/vim-fugitive'    , {'merged': 0}])
    if !My_Vim#layer#isLoaded('VersionControl') && s:gitgutter_plugin ==# 'vim-gitgutter'
      " show vcs info in sign column, only support git
      call add(plugins, ['airblade/vim-gitgutter', {'merged': 0}])
    elseif s:gitgutter_plugin ==# 'coc'
      auto VimEnter * call coc#config('git', {"enableGutters": "true"})
    endif
    if s:git_plugin ==# 'gina'
      call add(plugins, ['lambdalisue/gina.vim', {'on_cmd': 'Gina'}])
    elseif s:git_plugin ==# 'gita'
      call add(plugins, ['lambdalisue/vim-gita', {'on_cmd': 'Gita'}])
    elseif s:git_plugin ==# 'fugitive'
      call add(plugins, ['tpope/vim-dispatch'  , { 'merged' : 0}])
    endif
    if g:filemanager ==# 'nerdtree'
      call add(plugins, ['Xuyuanp/nerdtree-git-plugin', {'merged': 0}])
    endif
    "}}}
  endif
  return plugins
endfunction


function! layers#git#config() abort
  if g:is_spacevim "{{{
    if s:git_plugin ==# 'gina'
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'a'], 'Gina add %'     , 'stage current file'  , 1)
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'u'], 'Gina reset -q %', 'unstage current file', 1)
    elseif s:git_plugin ==# 'fugitive'
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'a'], 'Git add %'      , 'stage current file'  , 1)
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'u'], 'Git reset -q %' , 'unstage current file', 1)
    else
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'a'], 'Gita add %'     , 'stage current file'  , 1)
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'u'], 'Gita reset %'   , 'unstage current file', 1)
    endif
    if s:gitgutter_plugin ==# 'vim-gitgutter'
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'f'], 'GitGutterFold', '@ toggle folding unchanged lines', 1)
      call SpaceVim#mapping#space#def('nmap',['g', 'h', 'u'], '<Plug>GitGutterUndoHunk'   , 'undo cursor hunk'   , 0)
      call SpaceVim#mapping#space#def('nmap',['g', 'h', 'p'], '<Plug>GitGutterPreviewHunk', 'preview cursor hunk', 0)
    elseif s:gitgutter_plugin ==# 'coc'
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'f'],      'CocCommand git.foldUnchanged', '@ toggle folding unchanged lines', 1)
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'h', 'a'], 'CocCommand git.chunkStage'   , 'stage current hunk'              , 1)
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'h', 'u'], 'CocCommand git.chunkUndo'    , 'undo cursor hunk'                , 1)
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'h', 'p'], 'CocCommand git.chunkInfo'    , 'preview cursor hunk'             , 1)
      let g:_spacevim_mappings_space.g.i = {'name': '+GitHub'}
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'i', 'f'], 'CocCommand git.browserOpen'  , 'show current line in browser'    , 1)
    else
      call SpaceVim#mapping#space#def('nnoremap', ['g', 'f'], 'SignifyFold', '@ toggle folding unchanged lines', 1)
      unlet g:_spacevim_mappings_space.g.h | nunmap [SPC]gh
    endif
    try
      unlet g:_spacevim_mappings_space.g.h.r | nunmap [SPC]ghr
      unlet g:_spacevim_mappings_space.g.h.v | nunmap [SPC]ghv
    catch
    endtry
    call SpaceVim#mapping#space#def('nnoremap'  , ['g', 'j']     , 'Twiggy'                   , 'open git branch manager'     , 1)
    call SpaceVim#mapping#space#def('nmap'      , ['g', 'i', 'y'], '<Plug>(CopyCursorCodeUrl)',
          \ 'Copy current/selected line of github url to clipboard', 0)
    xmap [SPC]giy  <Plug>(CopySelectCodeUrls)
    "}}}
  else
    "{{{
    if s:git_plugin ==# 'gina'
      nnoremap <Space>gs   :Gina status --opener=10split<CR>
      nnoremap <Space>ga   :Gina add %<CR>
      nnoremap <Space>gu   :Gina reset -q %<CR>
      nnoremap <Space>gc   :Gina commit<CR>
      nnoremap <Space>gp   :Gina push<CR>
      nnoremap <Space>gd   :Gina diff<CR>
      nnoremap <Space>gA   :Gina add .<CR>
      nnoremap <Space>gb   :Gina blame<CR>
    elseif s:git_plugin ==# 'fugitive'
      nnoremap <Space>gs   :Gstatus<CR>
      nnoremap <Space>ga   :Git add %<CR>
      nnoremap <Space>gu   :Git reset -q %<CR>
      nnoremap <Space>gc   :Git commit<CR>
      nnoremap <Space>gp   :Gpush<CR>
      nnoremap <Space>gd   :Gdiff<CR>
      nnoremap <Space>gA   :Git add .<CR>
      nnoremap <Space>gb   :Git blame<CR>
    else
      nnoremap <Space>gs   :Gita status<CR>
      nnoremap <Space>ga   :Gita add %<CR>
      nnoremap <Space>gu   :Gita reset %<CR>
      nnoremap <Space>gc   :Gita commit<CR>
      nnoremap <Space>gp   :Gita push<CR>
      nnoremap <Space>gd   :Gita diff<CR>
      nnoremap <Space>gA   :Gita add .<CR>
      nnoremap <Space>gb   :Gina blame<CR>
    endif
      nnoremap <Space>gM   :call <sid>display_last_commit_of_current_line<CR>
      nnoremap <Space>gV   :GV!<CR>
      nnoremap <Space>gv   :GV<CR>
    if !My_Vim#layer#isLoaded('VersionControl') && s:gitgutter_plugin ==# 'vim-gitgutter'
      nnoremap <Space>gf   :GitGutterFold<CR>
      nmap     <Space>gha  <Plug>GitGutterStageHunk
      nmap     <Space>ghu  <Plug>GitGutterUndoHunk
      nmap     <Space>ghp  <Plug>GitGutterPreviewHunk
    elseif s:gitgutter_plugin ==# 'coc'
      nnoremap <Space>gf   :CocCommand git.foldUnchanged<CR>
      nnoremap <Space>gha  :CocCommand git.chunkStage<CR>
      nnoremap <Space>ghu  :CocCommand git.chunkUndo<CR>
      nnoremap <Space>ghp  :CocCommand git.chunkInfo<CR>
      nnoremap <Space>gif  :CocCommand git.browserOpen<CR>
    else
      nnoremap <Space>gf   :SignifyFold<CR>
    endif
    nmap       <Space>giy  <Plug>(CopyCursorCodeUrl)
    xmap       <Space>giy  <Plug>(CopySelectCodeUrls)
    augroup layer_git
      autocmd!
      auto FileType diff nnoremap <buffer><silent> q :bd!<CR>
      auto FileType gitcommit auto! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    augroup END
  endif "}}}
endfunction


function! s:display_last_commit_of_current_line() abort
  let line = line('.')
  let file = expand('%')
  let cmd = 'git log -L ' . line . ',' . line . ':' . file
  let cmd .= ' --pretty=format:"%s" -1'
  let title = systemlist(cmd)[0]
  if v:shell_error == 0
    echo 'Last commit of current line is: ' . title
  endif
endfunction

" vim:set et sw=2 cc=80:
