"=============================================================================
" chinese.vim --- chinese layer
" Section: layers
"=============================================================================
scriptencoding utf-8


function! layers#chinese#plugins() abort
  let plugins = []
  if !g:is_spacevim
    let plugins += [
          \ ['yianwillis/vimcdoc'      , {'merged': 0}],
          \ ['wsdjeg/vim-translate-me' , {'merged': 0, 'on_cmd': 'TranslateW', 'on': 'TranslateW',
          \ 'on_map': ['<Plug>Trans']}],
          \ ['wsdjeg/ChineseLinter.vim', {'merged': 0, 'on_cmd': 'CheckChinese', 'on' : 'CheckChinese',
          \ 'on_ft': ['markdown', 'text'], 'for': ['markdown', 'text']}],
          \ ]
  endif
  return plugins
endfunction

function! layers#chinese#config() abort
  if g:is_spacevim
    let g:_spacevim_mappings_space.x.g = {'name' : '+Translate'}
    call SpaceVim#custom#SPC('nmap', ['l', 'c']     , 'CheckChinese'                 , 'Check with ChineseLinter', 1)
    call SpaceVim#custom#SPC('nmap', ['x', 'g', 'i'], 'call feedkeys(":TranslateW ")', 'translate input word or sentence', 1)
    call SpaceVim#custom#SPC('nmap', ['x', 'g', 't'], '<Plug>TranslateW'             , 'translate cursor word'           , 0)
    call SpaceVim#custom#SPC('vmap', ['x', 'g', 't'], '<Plug>TranslateWV'            , 'translate cursor word'           , 0)
    call SpaceVim#custom#SPC('nmap', ['x', 'g', 'r'], '<Plug>TranslateR'             , 'replace cursor word with translate one', 0)
    call SpaceVim#custom#SPC('vmap', ['x', 'g', 'r'], '<Plug>TranslateRV'            , 'replace cursor word with translate one', 0)
    nmap <c-q>        <Plug>TranslateW
    vmap <c-q>        <Plug>TranslateWV

  else
    let g:loaded_vimcdoc = 1
    nmap <space>lc    :CheckChinese<cr>
    nmap <space>xgi   :TranslateW
    nmap <space>xgt   <Plug>TranslateW
    vmap <space>xgt   <Plug>TranslateWV
    nmap <space>xgr   <Plug>TranslateR
    vmap <space>xgr   <Plug>TranslateRV
    nmap <c-q>        <Plug>TranslateW
    vmap <c-q>        <Plug>TranslateWV
  endif
endfunction
