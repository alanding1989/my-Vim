"=============================================================================
" Scala.vim --- lang#scala layer
" Parent Section: layers/lang
"=============================================================================
scriptencoding utf-8


""
" @section lang#scala, layer-lang-scala
" @parentsection layers
" This layer is for Scala development.
"
" @subsection Mappings
" >
"   Import key bindings:
"
"   Mode      Key           Function
"   -------------------------------------------------------------
"   normal    <F4>          show candidates for importing of cursor symbol
"   insert    <F4>          show candidates for importing of cursor symbol
"   normal    SPC l i c     show candidates for importing of cursor symbol
"   normal    SPC l i q     prompt for a qualified import
"   normal    SPC l i o     organize imports of current file
"   normal    SPC l i s     sort imports of current file
"   insert    <c-j>i        prompt for a qualified import
"   insert    <c-j>o        organize imports of current file
"   insert    <c-j>s        sort imports of current file
"
"   Debug key bindings:
"
"   Mode      Key           Function
"   -------------------------------------------------------------
"   normal    SPC l d t     show debug stack trace of current frame
"   normal    SPC l d c     continue the execution
"   normal    SPC l d b     set a breakpoint for the current line
"   normal    SPC l d B     clear all breakpoints
"   normal    SPC l d l     launching debugger
"   normal    SPC l d i     step into next statement
"   normal    SPC l d o     step over next statement
"   normal    SPC l d O     step out of current function
"
"   Sbt key bindings:
"
"   Mode      Key           Function
"   -------------------------------------------------------------
"   normal    SPC l b c     sbt clean compile
"   normal    SPC l b r     sbt run
"   normal    SPC l b t     sbt test
"   normal    SPC l b p     sbt package
"   normal    SPC l b d     sbt show project dependencies tree
"   normal    SPC l b l     sbt reload project build definition
"   normal    SPC l b u     sbt update external dependencies
"   normal    SPC l b e     run sbt to generate .ensime config file
"
"   Execute key bindings:
"
"   Mode      Key           Function
"   -------------------------------------------------------------
"   normal    SPC l r m     run main class
"
"   REPL key bindings:
"
"   Mode      Key           Function
"   -------------------------------------------------------------
"   normal    SPC l s i     start a scala inferior REPL process
"   normal    SPC l s b     send buffer and keep code buffer focused
"   normal    SPC l s l     send line and keep code buffer focused
"   normal    SPC l s s     send selection text and keep code buffer focused
"
"   Other key bindings:
"
"   Mode      Key           Function
"   -------------------------------------------------------------
"   normal    SPC l Q       bootstrap server when first-time-use
"   normal    SPC l h       show Documentation of cursor symbol
"   normal    SPC l R       inline local refactoring of cursor symbol
"   normal    SPC l e       rename cursor symbol
"   normal    SPC l g       find Definition of cursor symbol
"   normal    SPC l t       show Type of expression of cursor symbol
"   normal    SPC l p       show Hierarchical view of a package
"   normal    SPC l r       find Usages of cursor symbol
"
" <
" @subsection Code formatting
" To make neoformat support scala file, you should install scalariform.
" [`scalariform`](https://github.com/scala-ide/scalariform)
" and set 'g:spacevim_layer_lang_scala_formatter' to the path of the jar.
"
" @subsection Ensime-vim setup steps
" The following is quick install steps, if you want to see complete details,
" please see: [`ensime`](http://ensime.github.io/editors/vim/install/)
"
" 1. Install vim`s plugin and its dependencies as following.
"      `pip install websocket-client sexpdata`,
"      `pip install pynvim` (neovim only).
" 2. Integration ENSIME with your build tools, here we use sbt.
"    > add (sbt-ensime) as global plugin for sbt:
"      Put code `addSbtPlugin("org.ensime" % "sbt-ensime" % "2.6.1")` in file 
"      '~/.sbt/plugins/plugins.sbt' (create if not exists).
"    > Armed with your build tool plugin, generate the `.ensime` config file from
"      your project directory in command line, e.g. for sbt use `sbt ensimeConfig`,
"      or `./gradlew ensime` for Gradle. the first time will take several minutes.
" 3. The first time you use ensime-vim (per Scala version), it will `bootstrap` the
"    ENSIME server installation when opening a Scala file you will be prompted to
"    run |:EnInstall|. Do that and give it a minute or two to run.
"    After this, you should see reports in Vim's message area that ENSIME is coming
"    up, and the indexer and analyzer are ready.
"    Going forward, ensime-vim will automatically start the ENSIME server when you
"    edit Scala files in a project with an `.ensime` config present.

let s:autocomplete_method = get(g:, 'spacevim_autocomplete_method',
      \ get(g:, 'autocomplete_method', 'deoplete'))


function! layers#lang#scala#plugins() abort
  let plugins = []
  if !g:is_spacevim
    if has('python3') || has('python')
      call add(plugins, ['ensime/ensime-vim' , {'on_ft': 'scala', 'for': 'scala'}])
    endif
    call add(plugins, ['derekwyatt/vim-scala', {'on_ft': 'scala', 'for': 'scala'}])
  endif
  return plugins
endfunction


function! layers#lang#scala#config() abort
  if s:autocomplete_method ==# 'coc'
    let $PATH .= ':/opt/lang-tools/scala/coc/'
  elseif My_Vim#layer#isLoaded('lsp') || SpaceVim#layers#isLoaded('lsp')
    let $PATH .= ':/opt/lang-tools/scala/languageclient/'
  endif
  if g:is_spacevim
    call SpaceVim#mapping#gd#add('scala', function('s:go_to_def'))

  else
    let g:scala_use_default_keymappings = 0
    call add(g:project_rooter_mark, 'build.sbt')
    augroup layer_lang#scala
      autocmd!
      autocmd FileType scala silent call s:language_specified_mappings() 
      autocmd BufWritePost *.scala silent :EnTypeCheck
    augroup END
  endif
endfunction


function! s:language_specified_mappings() abort
  " ensime-vim {{{
  " nnoremap <silent><buffer> gd :EnDeclarationSplit v<CR>
  nmap <silent><buffer> <F4>   :EnSuggestImport<CR>
  imap <silent><buffer> <F4>   <esc>:EnSuggestImport<CR>
  imap <silent><buffer> <c-j>i <esc>:EnAddImport<CR>
  imap <silent><buffer> <c-j>o <esc>:EnOrganizeImports<CR>
  imap <silent><buffer> <c-j>s <esc>:SortScalaImports<CR>
  nmap <silent><buffer> K      :EnDocBrowse<CR>
  " }}}
  if g:is_spacevim

  else
    nnoremap <silent><buffer> <space>lis  :SortScalaImports<cr>
    nnoremap <silent><buffer> <space>lt   :EnType<cr>
    nnoremap <silent><buffer> <space>lh   :EnDocBrowse<cr>
    nnoremap <silent><buffer> gd          :call <sid>go_to_def()<CR>
  endif
endfunction

function! s:go_to_def() abort
  if layers#lsp#checkft('scala')
    call SpaceVim#lsp#go_to_def()
  else
    EnDeclarationSplit v
  endif
endfunction

function! s:execCMD(cmd) abort
  try
    call unite#start([['output/shellcmd', a:cmd]], {'log': 1, 'wrap': 1,'start_insert':0})
  catch
    exec '!'.a:cmd
  endtry
endfunction

" vim:set et sw=2 cc=80:
