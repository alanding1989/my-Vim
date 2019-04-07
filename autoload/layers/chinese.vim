"=============================================================================
" chinese.vim --- chinese layer
" Section: layers
"=============================================================================
scriptencoding utf-8


function! layers#chinese#plugins() abort
  let plugins = []
  if !g:is_spacevim
    let plugins += [
          \ ['yianwillis/vimcdoc'          , {'merged': 0}],
          \ ['wsdjeg/ChineseLinter.vim'    , {'merged': 0, 'on_cmd': 'CheckChinese',
          \ 'on' : 'CheckChinese'}],
          \ ['ianva/vim-youdao-translater' , {'on_cmd': ['Ydv' , 'Ydc', 'Yde'], 
          \ 'on' : ['Ydv' , 'Ydc', 'Yde']}],
          \ ]
  endif
  return plugins
endfunction

function! layers#chinese#config() abort
  if g:is_spacevim
    let g:_spacevim_mappings_space.x.g = {'name' : '+Translate'}
    call SpaceVim#custom#SPC('nnoremap', ['x', 'g', 't'], 'Ydc'         , 'translate cursor word'           , 1)
    call SpaceVim#custom#SPC('vnoremap', ['x', 'g', 't'], 'Ydv'         , 'translate cursor word'           , 1)
    call SpaceVim#custom#SPC('nnoremap', ['x', 'g', 'i'], 'Yde'         , 'translate input word or sentence', 1)
    call SpaceVim#custom#SPC('nnoremap', ['l', 'c']     , 'CheckChinese', 'Check with ChineseLinter', 1)
    nnoremap <silent><c-q> :<c-u>Ydc<cr>

  else
    let g:loaded_vimcdoc = 1
    nmap      <space>xgt   :Ydc<cr>
    vmap      <space>xgt   :Ydv<cr>
    nmap      <space>xgi   :Yde<cr>
    nmap      <space>lc    :CheckChinese<cr>

    nnoremap <silent><c-q> :<c-u>Ydc<cr>
    nnoremap <leader>at    :<c-u>Yde<cr>
  endif
endfunction
