"================================================================================
" ncm2 plugin settings
"================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


" NOTE: neosnippet has conflict with ncm2, the below 2 value
" will be auto changed to 0 by using ncm2.
let g:neosnippet#enable_complete_done = 0
let g:neosnippet#enable_completed_snippet = 0

let g:ncm2#match_highlight     = 'sans-serif-bold'
let g:float_preview#height     = 30
let g:float_preview#docked     = 0
let g:float_preview#auto_close = 1


augroup my_ncm2_settings
  autocmd!
  auto BufEnter     * call ncm2#enable_for_buffer()
  auto TextChangedI * call ncm2#auto_trigger()

"--------------------------------------------------------------------------------
" language setting
"--------------------------------------------------------------------------------
  auto FileType python,ipynb call <sid>python_source()
  auto FileType markdown let b:ncm2_look_enabled = 1
  auto FileType vim call ncm2#override_source('vim', {
        \ 'name'       : 'vim',
        \ 'mark'       : 'vim',
        \ 'priority'   : 9,
        \ 'scope'      : ['vim'],
        \ 'on_complete': 'ncm2_vim#on_complete',
        \ })
  auto FileType css call ncm2#register_source({
        \ 'name'            : 'css',
        \ 'priority'        : 9,
        \ 'subscope_enable' : 1,
        \ 'scope'           : ['css','scss'],
        \ 'mark'            : 'css',
        \ 'word_pattern'    : '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete'     : ['ncm2#on_complete#delay', 180,
            \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })
  auto Filetype tex call ncm2#register_source({
        \ 'name'            : 'vimtex',
        \ 'priority'        : 8,
        \ 'scope'           : ['tex'],
        \ 'mark'            : 'tex',
        \ 'word_pattern'    : '\w+',
        \ 'complete_pattern': g:vimtex#re#ncm2,
        \ 'on_complete'     : ['ncm2#on_complete#delay', 180,
            \ 'ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
        \ })
augroup END


function! s:python_source() abort
  let g:ncm2_jedi#python_version = 3
  let g:ncm2_jedi#environment = g:python3_host_prog
  let g:ncm2_jedi#settings = {
        \ 'case_insensitive_completion'      : 'True',
        \ 'add_bracket_after_function'       : 'True',
        \ 'no_completion_duplicates'         : 'True',
        \ 'use_filesystem_cache'             : 'True',
        \ 'fast_parser'                      : 'True',
        \ 'dynamic_array_additions'          : 'True',
        \ 'dynamic_params'                   : 'True',
        \ 'dynamic_params_for_other_modules' : 'True',
        \ 'auto_import_modules'              : ['hashlib', 'gi'],
        \ 'call_signatures_validity'         : 3.0,
        \ }
  let g:ncm2_jedi#source = {
        \ 'scope': ['python', 'ipynb'],
        \ }
endfunction
