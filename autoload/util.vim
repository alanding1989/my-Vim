" ================================================================================
" util.vim
" ================================================================================
scriptencoding utf-8



" Help/Echo Related {{{
" echo mapping rhs {{{
function! util#maparg_wrapper(...) abort
  if a:0 == 1 " {{{
    " n mode c-..., m-..., gd, gg ... mappings
    echo len( maparg('<'.a:1.'>'))
          \ ? maparg('<'.a:1.'>')
          \ : maparg(a:1)
  endif
  " }}}

  if a:0 == 2 " {{{
    if a:1 =~# 'v\w'
      exec 'verbose '.a:1[1].'map '.a:2

    elseif a:1 !=# 'leader' && a:2 !=# 'spc'
      " support specified mode
      " <c- >..., <m- >..., gd, gg ... mappings
      echo len(maparg('<'.a:1.'>', a:2))
            \ ? maparg('<'.a:1.'>', a:2)
            \ : maparg(a:1, a:2) 
    else
      " n mode <leader>, [SPC] mappings
      echo    a:1 ==# 'leader' ? maparg('<'.a:1.'>'.a:2, 'n') : 
            \ a:2 ==# 'spc'    ? maparg('[SPC]'.a:1, 'n') : ''
    endif
  endif
  " }}}

  if a:0 == 3 " {{{
    " support specify mode
    " <c- >.., <m- >.., <space>.., <leader>.. mappings
    echo a:3 ==# 'spc' 
          \ ? maparg('[SPC]'.a:1, a:2)
          \ : maparg('<'.a:1.'>'.a:2, a:3)
  endif
  " }}}
endfunc "}}}

" help wrapper {{{
function! util#help_wrapper(...) abort
  try
    if exists(':CocConfig')
      call CocActionAsync('doHover')
    elseif exists(':LanguageClientStart')
      call LanguageClient_textDocument_hover()
    else
      LspHover
    endif
  catch
    call feedkeys(':EchoHelp ')
  endtry
endfun

function! util#vim_help_wrapper(...) abort
  if a:0 > 0 && a:1 ==# 'fl'
    exec 'help function-list@cn' | exec ':resize'
    return
  endif

  let cword = expand('<cword>')
  if a:0 == 0 && !empty(cword)
    try
      exec 'vert bo help '.cword.'@cn'
    catch /^Vim\%((\a\+)\)\=:E661/
      exec 'vert bo help '.cword
    endtry
  elseif a:0 > 0
    try
      exec 'vert bo help '.a:1.'@cn'
    catch /^Vim\%((\a\+)\)\=:E661/
      exec 'vert bo help '.a:1
    endtry
  endif
endfunction
"}}}

" highlight wrapper {{{
function! util#hlight_wrapper(...) abort
  try
    exec    ( a:0 > 0 && a:1 ==# 'v' ? 'verbose ' : '' )
          \ . 'highlight ' . (
          \ !empty(expand('<cword>')) ? expand('<cword>') :
          \ !a:0 ? '' : 
          \  a:1 !=# 'v' ? a:1 : a:0 == 2 ? string(a:2) : ''
          \ )
  catch
    exec    ( a:0 > 0 && a:1 ==# 'v' ? 'verbose ' : '' )
          \ . 'highlight ' . (
          \ a:0 ? a:1 !=# 'v' ? a:1 : a:0 == 2 ? string(a:2) : ''
          \ : ''
          \ )
  endtry
endfunction " }}}

" echohl wrapper {{{
function! util#echohl(str, ...) abort
  echohl WarningMsg
  if a:0
    if a:0 == 1 && a:1 ==# 'n'
      exec 'echo "\n '.a:str.'"'
    else
      if a:000[-1] ==# 'n'
        exec 'echo "\n '.a:str. join(a:000[:-2], ' ').'"'
      else
        echo a:str join(a:000, ' ')
      endif
    endif
  else
    echo a:str
  endif
  echohl NONE
endfunction " }}}

" confirm {{{
function! util#confirm(msg) abort
  if confirm(a:msg, "&Yes\n&No\n&Cancel") == 1
    return 1
  endif
endfunction " }}}
"}}}


" File/Path Manipulate {{{
" so_file {{{
function! util#so_file(path, ...) abort
  let gen_p  = glob(g:home.'config/'.a:path)
  let SPC_p  = glob(g:home.'config/SpaceVim/'.a:path)
  let Vim_p  = glob(g:home.'config/Vim/'.a:path)
  let arbi_p = glob(g:home.a:path)
  let g:home = glob(g:home)
  if a:1 ==# 'g' && util#filereadable(gen_p)
    exec 'so ' gen_p
  elseif a:1 ==# 'SPC' && util#filereadable(SPC_p)
    exec 'so ' SPC_p
  elseif a:1 ==# 'Vim' && util#filereadable(Vim_p)
    exec 'so ' Vim_p
  elseif util#filereadable(arbi_p)
    exec 'so ' arbi_p
  endif
endfunc "}}}

" filereadable {{{
function! util#filereadable(path) abort
  if filereadable(expand(a:path))
    return 1
  else
    call util#echohl(' invalid file name, please check !')
    return 0
  endif
endfunction "}}}

" globpath "{{{
function! util#globpath(path, expr) abort
  return globpath(a:path, a:expr, 1, 1)
endfunction "}}}
"}}}


" Manipulate Vim Plugins {{{
" update plugin {{{
function! util#update_plugin() abort
  try
    let a_save = @a
    let @a=''
    normal! mx"ayi'
    normal! `x
    let plug_name = match(@a, '/') >= 0 ? split(@a, '/')[1] : @a
  finally
    let @a = a_save
  endtry
  if g:is_spacevim
    call feedkeys(':SPUpdate '.plug_name)
  else
    call feedkeys(':PlugUpdate '.plug_name)
  endif
endfunction "}}}

" show plugin commit log {{{
function! util#Show_curPlugin_log()
  try
    let a_save = @a
    let @a=''
    normal! mx"ayi'
    normal! `x
    let plug = match(@a, '/') >= 0 ? @a : 'vim-scripts/'.@a
  finally
    let @a = a_save
  endtry
  let plugdir = g:is_spacevim ? g:spacevim_plugin_bundle_dir : g:My_Vim_plug_dir
  if !exists(':PlugSnapshot')
    let plugdir = plugdir.'repos/github.com/'
  else
    let plug = split(plug, '/')[1]
  endif
  call unite#start([['output/shellcmd',
        \ 'git --no-pager -C ' 
        \ . plugdir . plug
        \ . ' log -n 15 --oneline']], {'log': 1, 'wrap': 1,'start_insert':0})
  exec 'Denite output:!git\ --no-pager\ -C\ '
        \ . plugdir . plug
        \ . '\ log\ -n\ 15\ --oneline'
  exe "nnoremap <buffer><CR> :call <SID>Opencommit('". plug ."', strpart(split(getline('.'),'[33m')[1],0,7))<CR>"
endfunction
function! s:Opencommit(repo, commit)
  exe 'OpenBrowser https://github.com/' . a:repo .'/commit/'. a:commit
endfunction "}}}

" open cursor plugin github repo {{{
function! util#Open_curPlugin_repo()
  try
    let a_save = @a
    let @a=''
    normal! mx"ayi'
    if empty(@a)
      normal! mx"ayi"
    endif
    normal! `x
    exec 'OpenBrowser https://github.com/'.@a
  catch
    echohl WarningMsg | echomsg 'can not open the web of current plugin' | echohl None
  finally
    let @a = a_save
  endtry
endfunction "}}}

" view my starred github repos {{{
function! util#vg_starred_repos() abort
  if empty(g:unite_source_menu_menus.MyStarredrepos.command_candidates)
    if s:UpdateStarredRepos()
      Unite -silent -ignorecase -winheight=17 -start-insert menu:MyStarredrepos
    endif
  else
    Unite -silent -ignorecase -winheight=17 -start-insert menu:MyStarredrepos
  endif
endfunction
function! s:UpdateStarredRepos()
  if empty(g:github_username)
    echohl WarningMsg
    echo 'You need to set g:github_username'
    echohl NONE
    return 0
  endif
  let cache_file = expand('~/.cache/github' . g:github_username)
  if filereadable(cache_file)
    let repos = json_encode(readfile(cache_file, '')[0])
  else
    let repos = github#api#users#GetStarred(g:github_username)
    echom writefile([json_decode(repos)], cache_file, '')
  endif

  for repo in repos
    let description = repo.full_name . repeat(' ', 40 - len(repo.full_name)) . repo.description
    let cmd = 'OpenBrowser ' . repo.html_url
    call add(g:unite_source_menu_menus.MyStarredrepos.command_candidates, [description, cmd])
  endfor
  return 1
endfunction "}}}
"}}}


" SpaceVim Related {{{
" SpaceVim test mode {{{
function! util#test_SPC() abort
  call system('sh '.g:home.'extools/spacevim/test-SpaceVim.sh')
  if empty(v:shell_error) && glob(g:home.'init.toml') !=# ''
    echohl WarningMsg
    echo ' Test environment is on'
    echohl NONE
  elseif empty(v:shell_error) && glob(g:home.'init.toml') ==# ''
    echohl WarningMsg
    echo ' test environment is off'
    echohl NONE
  endif
endfunction "}}}

" SpaceVim new PR {{{
function! util#SPC_PR(...) abort
  " a:i git branch name
  if a:0 == 1
    call system('sh '.g:home.'extools/spacevim/SPC-pr.sh '.a:1)
  else
    call system('sh '.g:home.'extools/spacevim/SPC-pr.sh')
  endif
  if empty(v:shell_error) && glob('/tmp/SpaceVim') !=# '' && glob('~/.SpaceVim_origin') ==# ''
    echohl WarningMsg
    echo ' PR preparation ready'
    echohl NONE
  elseif empty(v:shell_error) && glob('/tmp/SpaceVim') !=# '' && glob('~/.SpaceVim_origin') !=# ''
    echohl WarningMsg
    echo ' PR test environment is ready'
    echohl NONE
  elseif empty(v:shell_error) && glob('/tmp/SpaceVim') ==# '' && glob('~/.SpaceVim_origin') ==# ''
    echohl WarningMsg
    echo ' PR Environment recovery done'
    echohl NONE
  else
    echohl WarningMsg
    echo v:shell_error
    echohl NONE
  endif
endfunction "}}}
"}}}


" function() wrapper "{{{
function! util#valid(type, ...) abort
  return util#{a:type}#valid(a:000)
endfunction

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
endif "}}}
