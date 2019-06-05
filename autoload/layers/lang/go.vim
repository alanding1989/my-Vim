"=============================================================================
" go.vim --- lang#go layer
"=============================================================================

""
" @section lang#go, layer-lang-go
" @parentsection layers
" This layer includes code completion and syntax checking for Go development.
"
" @subsection Mappings
" >
"   Mode            Key             Function
"   ---------------------------------------------
"   normal          SPC l a         go alternate
"   normal          SPC l b         go build
"   normal          SPC l c         go coverage
"   normal          SPC l d         go doc
"   normal          SPC l D         go doc vertical
"   normal          SPC l e         go rename
"   normal          SPC l g         go definition
"   normal          SPC l j         go generate
"   normal          SPC l h         go info
"   normal          SPC l i         go implements
"   normal          SPC l I         implement stubs
"   normal          SPC l k         add tags
"   normal          SPC l K         remove tags
"   normal          SPC l l         list declarations in file
"   normal          SPC l L         list declarations in dir
"   normal          SPC l o         format improts
"   normal          SPC l O         add import
"   normal          SPC l u         go referrers
"   normal          SPC l s         fill struct
"   normal          SPC l t         go test
"   normal          SPC l T         go test function
"   normal          SPC l v         freevars
"   normal          SPC l r         go run
" <


function! layers#lang#go#plugins() abort
  let plugins = [ 
        \ ['fatih/vim-go', {'on_ft': 'go', 'for': 'go'}]
        \ ]

  if has('nvim') && g:autocomplete_method ==# 'deoplete'
    call add(plugins, ['zchee/deoplete-go', {'on_ft': 'go', 'for': 'go',
          \ 'build': 'make', 'do': 'make'}])
  endif
  return plugins
endfunction


function! layers#lang#go#config() abort
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_function_parameters = 1
  let g:go_highlight_variable_declarations = 1
  let g:go_highlight_extra_types = 1
  " let g:go_highlight_variable_assignments = 1
  if g:is_spacevim
    call SpaceVim#custom#Reg_langSPC('go', function('s:language_specified_mappings'))
  else

    let g:go_highlight_functions = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_command = 'goimports'
    let g:syntastic_go_checkers = ['golint', 'govet']
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
    let g:neomake_go_gometalinter_args = ['--disable-all']
    if g:snippet_engine ==# 'neosnippet'
      let g:go_snippet_engine = 'neosnippet'
    else
      let g:go_snippet_engine = 'ultisnips'
    endif
    augroup layers_lang_go
      autocmd!
      auto FileType go   call <sid>language_specified_mappings() 
    augroup END
  endif
endfunction


function! s:language_specified_mappings() abort
  nnoremap <silent><buffer> gd    :call <sid>go_to_def()<CR>
  nnoremap <silent><buffer> gj    :GoGenerate<CR>
  nnoremap <silent><buffer> gk    :GoAddTags<CR>
  nnoremap <silent><buffer> gK    :GoRemoveTags<CR>
  nnoremap <silent><buffer> go    :GoImports<CR>
  nnoremap <silent><buffer> gO    :GoImport<CR>

  if g:is_spacevim
    call SpaceVim#mapping#space#langSPC('nmap', ['l','j'],
          \ 'GoGenerate',
          \ 'go generate', 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','o'],
          \ 'GoImports',
          \ 'format imports', 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','O'],
          \ 'GoImport ',
          \ 'add import', 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','u'],
          \ 'GoReferrers',
          \ 'go referrers', 1)
  else
    nnoremap  <silent><buffer> <Space>la    :GoAlternate<CR><CR>
    nmap      <silent><buffer> <Space>lb    <Plug>(go-build)
    nnoremap  <silent><buffer> <Space>lc    GoCoverageToggle<CR>
    nmap      <silent><buffer> <Space>ld    <Plug>(go-doc)
    nmap      <silent><buffer> <Space>lD    <Plug>(go-doc-vertical)
    nmap      <silent><buffer> <Space>le    <Plug>(go-rename)
    nmap      <silent><buffer> <Space>lg    <Plug>(go-def)
    nmap      <silent><buffer> <Space>lh    <Plug>(go-info)
    nmap      <silent><buffer> <Space>li    <Plug>(go-implements)
    nnoremap  <silent><buffer> <Space>lI    :GoImpl<CR>
    nnoremap  <silent><buffer> <Space>lk    :GoAddTags<CR>
    nnoremap  <silent><buffer> <Space>lK    :GoRemoveTags<CR>
    nnoremap  <silent><buffer> <Space>ll    :GoDecls<CR>
    nnoremap  <silent><buffer> <Space>lL    :GoDeclsDir<CR>
    nnoremap  <silent><buffer> <Space>lo    :GoImports<CR>
    nnoremap  <silent><buffer> <Space>lO    :GoImport<CR>
    nnoremap  <silent><buffer> <Space>lu    :GoReferrers<CR>
    nnoremap  <silent><buffer> <Space>ls    :GoFillStruct<CR>
    nnoremap  <silent><buffer> <Space>lt    :GoTest<CR>
    nnoremap  <silent><buffer> <Space>lT    :GoTestFunc<CR>
    nnoremap  <silent><buffer> <Space>lv    :GoFreevars<CR>
  endif
endfunction

function! s:go_to_def() abort
  if layers#lsp#check_ft('go')
    call layers#lsp#go_to_def()
  else
    call go#def#Jump('')
  endif
endfunction


