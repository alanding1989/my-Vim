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
          \ ['voldikss/vim-translate-me' , {'merged': 0, 'on_cmd': ['TranslateW', 'TranslateR'],
          \  'on_map': ['<Plug>Trans'],'on': ['Translate', 'TranslateW', 'TranslateR']}],
          \ ['wsdjeg/ChineseLinter.vim', {'merged': 0, 'on_cmd': 'CheckChinese', 'on' : 'CheckChinese',
          \ 'on_ft': ['markdown', 'text'], 'for': ['markdown', 'text']}],
          \ ]
  endif
  return plugins
endfunction

function! layers#chinese#config() abort
  let g:vtm_default_api     = 'youdao'
  let g:vtm_default_mapping = 0
  if g:is_spacevim
    let g:_spacevim_mappings_space.x.g = {'name' : '+Translate'}
    call SpaceVim#custom#SPC('nmap', ['l', 'c']     , 'CheckChinese'                 , 'Check with ChineseLinter', 1)
    call SpaceVim#custom#SPC('nmap', ['x', 'g', 'i'], 'call feedkeys(":TranslateW ")', 'translate inputted word or sentence', 1)
    call SpaceVim#custom#SPC('nmap', ['x', 'g', 't'], 'TranslateW'                   , 'translate cursor word'              , 1)
    call SpaceVim#custom#SPC('vmap', ['x', 'g', 't'], '<Plug>TranslateWV'            , 'translate cursor word'              , 0)
    call SpaceVim#custom#SPC('nmap', ['x', 'g', 'r'], 'TranslateR'                   , 'replace cursor word with translate one', 1)
    call SpaceVim#custom#SPC('vmap', ['x', 'g', 'r'], '<Plug>TranslateRV'            , 'replace cursor word with translate one', 0)
    nmap <c-q>        :TranslateW<CR>
    vmap <c-q>        <Plug>TranslateWV

  else
    let g:loaded_vimcdoc = 1
    nmap <space>lc    :CheckChinese<CR>
    nmap <space>xgi   :call feedkeys(':TranslateW ')<CR>
    nmap <space>xgt   :TranslateW<CR>
    vmap <space>xgt   <Plug>TranslateWV
    nmap <space>xgr   :TranslateR<CR>
    vmap <space>xgr   <Plug>TranslateRV
    nmap <c-q>        <Plug>TranslateW
    vmap <c-q>        <Plug>TranslateWV
  endif
endfunction
