" ================================================================================
" util.vim
" ================================================================================
scriptencoding utf-8



" Help/Echo Related {{{
" echo mapping rhs {{{
function! util#maparg_wrapper(...) abort
  if a:0 == 1 && a:1 ==# 'vn'
    call feedkeys(':verbose nmap ')
  elseif a:0 == 1 && a:1 ==# 'vi'
    call feedkeys(':verbose imap ')
  elseif a:0 == 1 && a:1 ==# 'vv'
    call feedkeys(':verbose vmap ')
  elseif a:0 == 1 && a:1 ==# 'vx'
    call feedkeys(':verbose xmap ')
    " try
    "   " Scriptease plugin
    "   call feedkeys(':Verbose map ')
    " catch
    " endtry
  elseif a:0 == 1
    " n mode
    " c-..., m-... mappings
    " gd, gg ... mappings
    if !empty(maparg('<'.a:1.'>'))
      exec "echo maparg('<".a:1.">')"
    else
      exec "echo maparg('".a:1."')"
    endif
  elseif a:0 == 2 && a:1 !=# 'leader' && a:2 !=# 'spc'
    " support specify mode
    " <c- >..., <m- >... mappings
    " gd, gg ... mappings
    if !empty(maparg('<'.a:1.'>', a:2))
      exec "echo maparg('<".a:1.">', '".a:2."')"
    elseif !empty(maparg(a:1, a:2))
      exec "echo maparg('".a:1."', '".a:2."')"
    endif
  elseif a:0 == 2 && a:1 ==# 'leader'
    " n mode
    " <leader> mappings
    exec "echo maparg('<".a:1.'>'.a:2."', 'n')"
  elseif a:0 == 2 && a:2 ==# 'spc'
    " n mode
    " [SPC] mappings
    exec "echo maparg('[SPC]".a:1."', 'n')"
  elseif a:0 == 3 && a:3 ==# 'spc'
    " support specify mode
    " [SPC] mappings
    exec "echo maparg('[SPC]".a:1."', '".a:2."')"
  elseif a:0 == 3
    " need to specify mode
    " <c- >.., <m- >.., <space>.., <leader>.. mappings
    exec "echo maparg('<".a:1.'>'.a:2."', '".a:3."')"
  endif
endfunc "}}}

" help wrapper {{{
function! util#help_wrapper(...) abort
  if &ft !=# 'vim'
    if exists(':CocConfig')
      call CocActionAsync('doHover')
    else
      call LanguageClient_textDocument_hover()
    endif
  else
    call feedkeys(':EchoHelp ')
  endif
endfun

function! util#vim_help_wrapper(...) abort
  if a:0 > 0 && a:1 ==# 'fl'
    exec 'help function-list@cn' | exec ':resize'
    return
  endif

  let cword = expand('<cword>')
  if a:0 == 0 && !empty(cword)
    exec 'vert bo help '.cword.'@cn'
  elseif a:0 > 0
    exec 'vert bo help '.a:1.'@cn'
  endif
endfunction
"}}}

" highlight wrapper {{{
function! util#hlight_wrapper(...) abort
  
  exec (a:0 > 0 && a:1 ==# 'v' ? 'verbose ' : '') . 'highlight ' .
        \ (!empty(expand('<cword>')) ? expand('<cword>') :
        \ (a:0 == 0 ? '' : (a:1 !=# 'v' ? a:1 : a:2)))
endfunction " }}}
"}}}


" File Manipulate {{{
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
    echohl WarningMsg
    echo ' invalid file name, please check!'
    echohl NONE
    return 0
  endif
endfunction "}}}

" globpath "{{{
function! util#globpath(path, expr) abort
  return globpath(a:path, a:expr, 1, 1)
endfunction "}}}
"}}}


" Easy Operation {{{
" open or search websites {{{
function! util#OpenlinkOrSearch(key, ...) abort
  let url = {
        \ 'scala': 'https://www.scala-lang.org/api/current/index.html?search=',
        \ 'arec' : 'https://asciinema.org/~alanding',
        \ 'spc'  : 'https://spacevim.org/cn/layers',
        \ }
  if a:0 > 0
    exec 'OpenBrowser '.url[a:key].a:1
  else
    exec 'OpenBrowser '.url[a:key]
  endif
endfunction "}}}
"}}}


" Plugins Manipulate {{{
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


" Plug Enhancement {{{
function! util#coc_editsnips(...) abort
  let ultisnips_dirpath = (g:is_win ? 
        \ expand('D:/.cache/vimfiles/repos/github.com/alanding1989/my-vim-snippets/UltiSnips/') :
        \ expand('~/.cache/vimfiles-alan/repos/github.com/alanding1989/my-vim-snippets/UltiSnips/')) 
  let ft  = a:0 > 0 ? a:1 : expand('%:e')
  let ext = '.snippets'
  let onelpath = ultisnips_dirpath. ft. ext
  if glob(onelpath) !=# ''
    exec 'topleft vsplit '. onelpath
    return
  else
    let seclpath = ultisnips_dirpath. ext.'/'. ft. ext
    if glob(seclpath) !=# ''
      exec 'topleft vsplit '. seclpath
      return
    endif
  endif
  exec 'topleft vsplit '. onelpath
endfunction "}}}


" function() wrapper for memo "{{{
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
