" ================================================================================
" util.vim
" ================================================================================
scriptencoding utf-8



" Help/Echo Related {{{
" echo mapping rhs {{{
" TODO: refactor
function! util#maparg_wrapper(...) abort
  if a:0 == 1 " {{{
    " Normal Mode: <C-...>, <A-...>, gd, gg ... mappings
    " Usage: :EchoMap so
    "        :EchoMap C-j
    echo len( maparg('<'.a:1.'>'))
          \ ? maparg('<'.a:1.'>')
          \ : maparg(a:1)
  endif
  " }}}

  if a:0 == 2 " {{{
    if a:1 =~# '^v\w'
      " Support Specific Mode:
      " Param: a:1 vi vn vv, verbose + which mode
      "        a:2 specific mapping
      if a:2 =~? '.*spc.*'
        " Usage: :EchoMap vn spc-so, will seach verbose nmap [SPC]so
        exec 'verbose '.a:1[1].'map [SPC]'.matchstr(a:2, 'spc\W\ze\w\+')
      else
        " Usage: :EchoMap vn rhs, rhs must be the format of maparg()
        "        :EchoMap vn <C-j>
        exec 'verbose '.a:1[1].'map <'.a:2.'>'
      endif
    elseif a:1 !=# 'leader' && a:1 !=# 'spc'
      " Support Specific Mode:
      " <C-...>, <A-...>, <space>..., gd, gg ... mappings
      if a:1 ==# 'space'
        " Usage: :EchoMap space so
        exec "verbose nmap \<space>".a:2
        return
      elseif a:1 =~# '^g\|^z'
        " Usage: :EchoMap i gg, will show rhs of gg in insert mode
        exec 'verbose '.a:2.'map '.a:1
      else
        " Usage: :EchoMap leader so
        echo  len(maparg('<'.a:1.'>', a:2))
              \ ? maparg('<'.a:1.'>', a:2)
              \ : maparg(a:1, a:2)
      endif
    else
      " Normal Mode: <leader>, [SPC] mappings
      echo    a:1 ==# 'leader' ? maparg('<'.a:1.'>'.a:2, 'n') : 
            \ a:1 ==# 'spc'    ? maparg('[SPC]'.a:2, 'n') : ''
    endif
  endif
  " }}}

  if a:0 == 3 " {{{
    " Support Specific Mode:
    " <c-..>, <m-..>, <space>.., <leader>..
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
  if a:0 && a:1 !=# 'map'
    if a:0 == 1 && a:1 ==# 'n'
      exec 'echo "\n '.a:str.'"'
    else
      if a:000[-1] ==# 'n'
        exec 'echo "\n '.a:str. join(a:000[:-2], ' ').'"'
      else
        echo a:str join(a:000, ' - ')
      endif
    endif
  elseif a:0 && a:1 ==# 'map'
    call feedkeys('":'.escape(a:str, '<').'"')
  else
    if type(a:str) ==# type('')
      echo ' '.a:str
    elseif type(a:str) ==# type([])
      echo join(a:str, ' ')
    endif
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
  " regenerate the g:home path
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
    throw 'invalid file name, please check '. a:path. '!'
  endif
endfunction "}}}

" globpath "{{{
" return: a list of files under the `path` match `pattern`
function! util#globpath(path, pattern) abort
  return globpath(a:path, a:pattern, 1, 1)
endfunction "}}}

" find file or dir in parent path {{{
function! util#findDirInParent(what, where) abort
  let old_suffixesadd = &suffixesadd
  let &suffixesadd = ''
  let dir = finddir(a:what, escape(a:where, ' ') . ';')
  let &suffixesadd = old_suffixesadd
  return dir
endfunction " }}}
"}}}


" Manipulate Vim Plugins {{{
" show plugin whether installed {{{
function! util#CheckInstall(...) abort
  if !a:0
    " check cword
    try
      let a_save = @a
      let @a=''
      normal! mx"ayi'
      normal! `x
      let plug_name = match(@a, '/') >= 0 ? split(@a, '/')[1] : @a
    finally
      let @a = a_save
    endtry
  endif
  if g:is_spacevim
    if index(g:_spacevim_plugins, a:0 ? a:1 : plug_name) >= 0
      call util#echohl('Already Installed')
    else
      call util#echohl('Not Installed')
    endif
  else
    let plugins = MyVim#plugin#enabled_plugins_get()
    if index(plugins, a:0 ? a:1 : plug_name) >= 0
      call util#echohl('Already Installed')
    else
      call util#echohl('Not Installed')
    endif
  endif
endfunction  " }}}

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
  let plugdir = g:is_spacevim ? g:spacevim_plugin_bundle_dir : g:MyVim_plug_dir
  if !exists(':PlugSnapshot')
    let plugdir = plugdir.'repos/github.com/'
  else
    let plug = split(plug, '/')[1]
  endif
  call unite#start([['output/shellcmd',
        \ 'git --no-pager -C ' 
        \ . plugdir . plug
        \ . ' log -n 15 --oneline']], {'log': 1, 'wrap': 1,'start_insert':0})
  " exec 'Denite output:!git\ --no-pager\ -C\ '
        " \ . plugdir . plug
        " \ . '\ log\ -n\ 15\ --oneline'
  exe "nnoremap <buffer><CR> :call layers#core#OpenGithub('". plug ."', 
        \ strpart(split(getline('.'),'[33m')[1],0,7))<CR>"
endfunction
" }}}

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
    " exec 'OpenBrowser https://github.com/'.@a
    call layers#core#OpenGithub(@a)
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
" Check SpaceVim merge diff after pushing to github " {{{
function! util#CheckSPCMergeDiff() abort 
  let commit = util#git#cache_commits('~/.SpaceVim')[0]
  if match(commit, 'merge\sSPC')
    let commit = split(commit, ' ')[0]
    call layers#core#OpenGithub('alanding1989/SpaceVim', commit)
  else
    call util#echohl('haven`t merged upstream')
    if &ft ==# 'gitcommit'
      call append('.', 'merge SPC')
    endif
  endif
endfunction " }}}

" SpaceVim test mode {{{
function! util#test_SPC() abort
  let cmd = 'sh '.g:home.'lib/SpaceVim/test-SpaceVim.sh'
  call system(cmd)
  if !v:shell_error && len(glob(g:home.'init.toml'))
    call util#echohl('Test environment is on')
  elseif !v:shell_error && !len(glob(g:home.'init.toml'))
    call util#echohl('Test environment is off')
  else
    call util#echohl('shell_error')
  endif
endfunction "}}}

" SpaceVim new PR {{{
let s:JOB = SpaceVim#api#import('job')

function! util#SPC_PR(branch) abort
  " a:branch: creat new git branch name
  let cmd = 'sh '. g:home.'lib/SpaceVim/new-SPC-pr.sh ' . a:branch
  call util#simple_job(cmd, 'PR preparation ready!')
endfunction 
"}}}
"}}}


" function() wrapper "{{{
function! util#valid(type, ...) abort
  return util#{a:type}#valid(a:000)
endfunction

let s:self = {}
let s:self.message = {"default": "Run success!"}
function! util#simple_job(cmd, ...) abort
  if a:0 > 0 && type(a:1) ==# type('')
    let s:self.message.on_success = a:1
  else
    call util#echohl(' Message should be string!')
    return
  endif
  let job_id = s:JOB.start(a:cmd, { 
        \ 'on_stderr' : function('s:on_stderr'),
        \ 'on_exit' : function('s:on_exit')
        \ })
endfunction
function! s:self.on_exit(job_id, data, event) abort
  if len(s:self.message) > 1
    call util#echohl(s:self.message['on_success'])
    call remove(s:self.message, 'on_success')
  endif
endfunction
function! s:self.on_stderr(job_id, data, event) abort
    call util#echohl(a:data)
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
