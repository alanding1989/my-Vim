" ================================================================================
" util.vim
" ================================================================================
scriptencoding utf-8



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
      " Scriptease plugin
      " call feedkeys(':Verbose map ')
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


" source config/*.vim files {{{
function! util#so_file(path, ...) abort
  let gen_p  = glob(g:home.'config/'.a:path)
  let SPC_p  = glob(g:home.'config/SpaceVim/'.a:path)
  let Vim_p  = glob(g:home.'config/Vim/'.a:path)
  let arbi_p = glob(g:home.a:path)
  let g:home = glob(g:home)
  if a:1 ==# 'g' && s:filereadable(gen_p)
    exec 'so ' gen_p
  elseif a:1 ==# 'SPC' && s:filereadable(SPC_p)
    exec 'so ' SPC_p
  elseif a:1 ==# 'Vim' && s:filereadable(Vim_p)
    exec 'so ' Vim_p
  elseif s:filereadable(arbi_p)
    exec 'so ' arbi_p
  endif
endfunc
function! s:filereadable(path) abort
  if filereadable(a:path)
    return 1
  else
    echohl WarningMsg
    echo ' invalid file name, please check!'
    echohl NONE
    return 0
  endif
endfunction
"}}}


" help wrapper {{{
function! util#help_wrapper(...) abort
  if &ft !=# 'vim'
    if exists(':CocConfig')
      call CocActionAsync('doHover')
    else
      call LanguageClient_textDocument_hover()
    endif
  else
    call util#vim_help_wrapper(a:000)
  endif
endfunc 

function! util#vim_help_wrapper(...) abort
    let input = input('Help keyword/Cancel(n): ', '', 'help')
    if input ==# 'n' | return | endif
    let cword = expand('<cword>')

    if empty(input) && !empty(cword)
      exec ':vert bo help '.cword
    elseif input ==# 'f' && !empty(cword)
      exec ':help '.cword | exec ':resize'
    elseif !empty(input)
      try
        let input0 = split(input)[0]
        let input1 = split(input)[1]
        if input1 ==# 'f'
          exec ':help '.input0 | exec ':resize'
        endif
      catch
        exec ':vert bo help '.input
      endtry
    endif
endfunction
"}}}


" highlight wrapper {{{
function! util#hlight_wrapper(...) abort
  try
    exec ':highlight '.expand('<cword>')
  catch
    exec ':highlight'
  endtry
endfunction " }}}


" SpaceVim test mode {{{
function! util#test_SPC(...) abort
  if glob(g:home.'init.toml') ==# ''
    silent exec '!cp "'.expand(g:home.'backup/init.toml').'" "'.expand(g:home).'"'
    silent exec '!cd "'.expand('~/.SpaceVim').'"'
    exec '!git checkout master'
    echo ' Test environment is on!'
  else
    silent call delete(g:home.'init.toml')
    silent exec '!cd "'.expand('~/.SpaceVim').'"'
    exec '!git checkout myspacevim'
    echo ' Test environment is off'
  endif
endfunction "}}}


" Plugins related {{{
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
endfunction

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
endfunction

function! util#Show_curPlugin_log()
  if exists(':PlugSnapshot') == 2
    return
  endif
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
  call unite#start([['output/shellcmd',
        \ 'git --no-pager -C '.plugdir.'repos/github.com/'
        \ . plug
        \ . ' log -n 15 --oneline']], {'log': 1, 'wrap': 1,'start_insert':0})
  exe "nnoremap <buffer><CR> :call <SID>Opencommit('". plug ."', strpart(split(getline('.'),'[33m')[1],0,7))<CR>"
endfunction
function! s:Opencommit(repo, commit)
  exe 'OpenBrowser https://github.com/' . a:repo .'/commit/'. a:commit
endfunction "}}}


" open or search code online docs {{{
function! util#OpenlinkOrSearch(key, ...) abort
  let url = {
        \ 'scala': 'https://www.scala-lang.org/api/current/index.html?search=',
        \ 'arec' : 'https://asciinema.org/~alanding',
        \ }
  if a:0 > 0
    exec 'OpenBrowser '.url[a:key].a:1
  else
    exec 'OpenBrowser '.url[a:key]
  endif
endfunction "}}}


" function() wrapper for memo "{{{
" change relative s: to abs <SNR>
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
