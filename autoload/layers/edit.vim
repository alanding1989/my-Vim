"=============================================================================
" edit.vim --- edit layer
" Parent Section: layers
"=============================================================================
scriptencoding utf-8



function! layers#edit#plugins() abort "{{{
  let plugins = [
        \ ['kana/vim-textobj-function'         ,                              ],
        \ ['vim-scripts/argtextobj.vim'        ,                              ],
        \ ['mattn/vim-textobj-url'             ,                              ],
        \ ['coderifous/textobj-word-column.vim',                              ],
        \ ['mg979/vim-visual-multi'            ,      {'on_event': 'BufEnter'}],
        \ ['haya14busa/vim-edgemotion'         ,    {'on_map': '<Plug>(edge'}],
        \ ['t9md/vim-quickhl'                  , {'on_map': '<plug>(quickhl-'}],
        \ ]
  if get(g:, 'spacevim_enable_cursorword', get(g:, 'enable_cursorword', 0)) == 1
    call add(plugins, ['itchyny/vim-cursorword',  {'on_event': 'BufEnter'}])
  endif
  if !g:is_spacevim
    let plugins += [
          \ ['kana/vim-textobj-user'                                                               ],
          \ ['kana/vim-textobj-indent'                                                             ],
          \ ['tpope/vim-surround'                                                                  ],
          \ ['tpope/vim-repeat'                                                                    ],
          \ ['dhruvasagar/vim-table-mode',                                            {'merged': 0}],
          \ ['junegunn/vim-emoji',                                                    {'merged': 0}],
          \ ['haya14busa/vim-easyoperator-line',                                      {'merged': 0}],
          \ ['easymotion/vim-easymotion',                                             {'merged': 0}],
          \ ['godlygeek/tabular',                                                     {'merged': 0}],
          \ ['terryma/vim-expand-region',                                           {'loadconf': 1}],
          \ ['gcmt/wildfire.vim',                                    {'on_map': '<Plug>(wildfire-'}],
          \ ['osyo-manga/vim-jplus',                                     {'on_map': '<Plug>(jplus'}],
          \ ['ntpeters/vim-better-whitespace', {'on_cmd':
                  \ ['StripWhitespace', 'ToggleWhitespace', 'DisableWhitespace', 'EnableWhitespace'],
          \ 'on': ['StripWhitespace', 'ToggleWhitespace', 'DisableWhitespace', 'EnableWhitespace']}],
          \ ['editorconfig/editorconfig-vim',  {'merged': 0, 'if': has('python') || has('python3')}],
          \ ]
    if executable('fcitx')
      call add(plugins, ['lilydjwg/fcitx.vim', { 'on_event' : 'InsertEnter'}])
    endif
  endif
  return plugins
endfunction " }}}


" mappings 
function! layers#edit#config() abort
  call s:vim_edgemotion()
  call s:vim_quickhl()
  call s:tabularize()
  call s:vim_table_mode()

  if g:is_spacevim " {{{

    " chang case
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'i', 'l'], 'silent call call('
          \ . string(s:_function('s:lowerCamelCase')) . ', [])',
          \ 'change symbol style to lowerCamelCase', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'i', 'u'], 'silent call call('
          \ . string(s:_function('s:UpperCamelCase')) . ', [])',
          \ 'change symbol style to UpperCamelCase', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'i', 's'], 'silent call call('
          \ . string(s:_function('s:under_score')) . ', [])',
          \ 'change symbol style to under_score', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'i', 'a'], 'silent call call('
          \ . string(s:_function('s:up_case')) . ', [])',
          \ 'change symbol style to UP_CACE', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'i', 'k'], 'silent call call('
          \ . string(s:_function('s:kebab_case')) . ', [])',
          \ 'change symbol style to kebab-case', 1)

    " text transient state
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'n'], 'call call('
          \ . string(s:_function('s:move_text_down_transient_state')) . ', [])',
          \ 'move text down(enter transient state)', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'p'], 'call call('
          \ . string(s:_function('s:move_text_up_transient_state')) . ', [])',
          \ 'move text up(enter transient state)', 1)

    " transpose
    let g:_spacevim_mappings_space.x.s = {'name' : '+Transpose'}
    call SpaceVim#mapping#space#def('nnoremap', ['x', 's', 'c'], 'call call('
          \ . string(s:_function('s:transpose_with_next')) . ', ["character"])',
          \ 'swap current character with next one', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 's', 'w'], 'call call('
          \ . string(s:_function('s:transpose_with_next')) . ', ["word"])',
          \ 'swap current word with next one', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 's', 'l'], 'call call('
          \ . string(s:_function('s:transpose_with_next')) . ', ["line"])',
          \ 'swap current line with next one', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 's', 'C'], 'call call('
          \ . string(s:_function('s:transpose_with_previous')) . ', ["character"])',
          \ 'swap current character with previous one', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 's', 'W'], 'call call('
          \ . string(s:_function('s:transpose_with_previous')) . ', ["word"])',
          \ 'swap current word with previous one', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 's', 'L'], 'call call('
          \ . string(s:_function('s:transpose_with_previous')) . ', ["line"])',
          \ 'swap current line with previous one', 1)

    " insert
    let g:_spacevim_mappings_space.i.e = {'name' : '+@ Insert nice box'}
    call SpaceVim#mapping#space#def('nnoremap', ['i', 'e', 'e'],
          \ 'call Insert_emptybox()',
          \ '@ empty box', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['i', 'e', 'h'],
          \ 'call Insert_headbox()',
          \ '@ file head box', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['i', 'h'],
          \ 'call SetFileHead()',
          \ '@ file head template', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['i', 'd'],
          \ 'call setline(line("."), strftime("%a %d %b %Y %H:%M"))', '@ datetime', 1)
    " }}}

  else " {{{
    " emmet {{{
    let g:user_emmet_install_global = 0
    let g:user_emmet_mode='a'
    let g:user_emmet_settings = {
          \ 'javascript': {
          \ 'extends': 'jsx',
          \ },
          \ 'jsp' : {
          \ 'extends': 'html',
          \ },
          \ }

    let g:wildfire_objects = ["i'", 'i"', 'i)', 'i]', 'i}', 'ip', 'it']
    "noremap <SPACE> <Plug>(wildfire-fuel)
    vnoremap <C-SPACE> <Plug>(wildfire-water)
    " }}}

    " osyo-manga/vim-jplus
    nmap     <silent>J       <Plug>(jplus)
    vmap     <silent>J       <Plug>(jplus)

    " split line stay/new
    nnoremap <space>jo   i<CR><esc>k$
    nnoremap <space>jn   i<CR><esc>

    " count
    nnoremap <silent>    <Plug>CountSelectionRegion :<C-u>call <SID>count_selection_region()<Cr>
    xnoremap <silent>    <Plug>CountSelectionRegion :<C-u>call <SID>count_selection_region()<Cr>
    nmap     <space>xc   <Plug>CountSelectionRegion

    " delete space
    nnoremap <silent><space>xdw       :StripWhitespace<CR>
    nnoremap <silent><space>xd<space> :call <sid>delete_extra_space()<CR>

    " chang case
    nnoremap <silent><space>xil       :call <sid>lowerCamelCase()<CR>
    nnoremap <silent><space>xiu       :call <sid>UpperCamelCase()<CR>
    nnoremap <silent><space>xis       :call <sid>under_score()<CR>
    nnoremap <silent><space>xia       :call <sid>up_case()<CR>
    nnoremap <silent><space>xik       :call <sid>kebab_case()<CR>

    " justification
    nnoremap <silent><space>xjl       :call <sid>set_justification_to('left')<CR>
    nnoremap <silent><space>xjc       :call <sid>set_justification_to('center')<CR>
    nnoremap <silent><space>xjr       :call <sid>set_justification_to('right')<CR>

    " move line
    nnoremap <silent><space>xp        :call <sid>move_text_up_transient_state()<CR>
    nnoremap <silent><space>xn        :call <sid>move_text_down_transient_state()<CR>

    " transpose
    nnoremap <silent><space>xsw       :call<sid>transpose_with_next('word')<CR>
    nnoremap <silent><space>xsc       :call<sid>transpose_with_next('character')<CR>
    nnoremap <silent><space>xsl       :call<sid>transpose_with_next('line')<CR>
    nnoremap <silent><space>xsW       :call<sid>transpose_with_previous('word')<CR>
    nnoremap <silent><space>xsC       :call<sid>transpose_with_previous('character')<CR>
    nnoremap <silent><space>xsL       :call<sid>transpose_with_previous('line')<CR>

    " insert
    nnoremap <silent><space>id        :call setline(line('.'), strftime('%a %d %b %Y %H:%M'))<CR>
    nnoremap <silent><space>iee       :call Insert_emptybox()<CR>
    nnoremap <silent><space>ieh       :call Insert_headbox()<CR>
    nnoremap <silent><space>ih        :call SetFileHead()<CR>
  endif "}}}
endfunction


function! s:tabularize() abort "{{{
  if g:is_spacevim
    " align
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', '&'], 'Tabularize /&', 'align-region-at-&', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', '('], 'Tabularize /(', 'align-region-at-(', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', ')'], 'Tabularize /)/l1l0', 'align-region-at-)', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', '['], 'Tabularize /[', 'align-region-at-[', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', ']'], 'Tabularize /]/l1l0', 'align-region-at-]', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', '{'], 'Tabularize /{', 'align-region-at-{', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', '}'], 'Tabularize /}/l1l0', 'align-region-at-}', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', '.'], 'Tabularize /.', 'align-region-at-.', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', ':'], 'Tabularize /:', 'align-region-at-:', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', ','], 'Tabularize /,/l0l1', 'align-region-at-,', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', ';'], 'Tabularize /;/l0l1', 'align-region-at-;', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', '='], 'Tabularize /===\|<=>\|\(&&\|||\|<<\|>>\|\/\/\)=\|=\~[#?]\?\|=>\|[:+/*!%^=><&|.?-]\?=[#?]\?/l1r1', 'align-region-at-=', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', 'o'], 'Tabularize /&&\|||\|\.\.\|\*\*\|<<\|>>\|\/\/\|[-+*/.%^><&|?]/l1r1', 'align-region-at-operator, such as +,-,*,/,%,^,etc', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', '¦'], 'Tabularize /¦', 'align-region-at-¦', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', '<Bar>'], 'Tabularize /|', 'align-region-at-|', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', '[SPC]'], 'Tabularize /\s\ze\S/l0', 'align-region-at-space', 1, 1)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'a', 'r'], 'call call('
          \ . string(s:_function('s:align_at_regular_expression')) . ', [])',
          \ 'align-region-at-user-specified-regexp', 1)
  else
    " align
    noremap <silent><space>xa&       :Tabularize /&<CR>
    noremap <silent><space>xa(       :Tabularize /(<CR>
    noremap <silent><space>xa)       :Tabularize /)/l1l0<CR>
    noremap <silent><space>xa[       :Tabularize /[<CR>
    noremap <silent><space>xa]       :Tabularize /]/l1l0<CR>
    noremap <silent><space>xa{       :Tabularize /{<CR>
    noremap <silent><space>xa}       :Tabularize /}/l1l0<CR>
    noremap <silent><space>xa.       :Tabularize /.<CR>
    noremap <silent><space>xa:       :Tabularize /:<CR>
    noremap <silent><space>xa,       :Tabularize /,/l0l1<CR>
    noremap <silent><space>xa;       :Tabularize /;/l0l1<CR>
    noremap <silent><space>xa¦       :Tabularize /¦<CR>
    noremap <silent><space>xa\       :Tabularize /\<CR>
    noremap <silent><space>xa=       :Tabularize /=/l1r1<CR>
    noremap <silent><space>xa<Bar>   :Tabularize /\|<CR>
    noremap <silent><space>xa<space> :Tabularize /\s\ze\S/l0<CR>
    noremap <silent><space>xar       :call <sid>align_at_regular_expression<CR>
  endif
endfunction


function! s:vim_edgemotion() abort
  nmap <c-j> <Plug>(edgemotion-j)
  nmap <c-k> <Plug>(edgemotion-k)
endfunction " }}}


function! s:vim_quickhl() abort "{{{
  if g:is_spacevim
    let g:_spacevim_mappings_space.x.h = {'name': '+@ quick highlight'}
    let g:_spacevim_mappings_space_custom += [
          \ ['nmap' , ['x' , 'h' , 'h'] , '<plug>(quickhl-manual-this)'   , 'highlight cursor word toggle'      , 0] ,
          \ ['xmap' , ['x' , 'h' , 'h'] , '<plug>(quickhl-manual-this)'   , 'hightight cursor word toggle'      , 0] ,
          \ ['nmap' , ['x' , 'h' , 'r'] , '<plug>(quickhl-manual-reset)'  , 'clear all highlight'               , 0] ,
          \ ['xmap' , ['x' , 'h' , 'r'] , '<plug>(quickhl-manual-reset)'  , 'clear all highlight'               , 0] ,
          \ ['nmap' , ['x' , 'h' , 'c'] , '<plug>(quickhl-manual-clear)'  , 'clear hightight of cursor word'    , 0] ,
          \ ['xmap' , ['x' , 'h' , 'c'] , '<plug>(quickhl-manual-clear)'  , 'clear hightight of cursor word'    , 0] ,
          \ ['nmap' , ['x' , 'h' , 't'] , '<plug>(quickhl-manual-toggle)' , 'toggle en/disable quichk highlight', 0] ,
          \ ['xmap' , ['x' , 'h' , 't'] , '<plug>(quickhl-manual-toggle)' , 'toggle en/disable quichk highlight', 0] ,
          \ ['nmap' , ['x' , 'h' , 'w'] , '<plug>(quickhl-cword-toggle)'  , 'toggle cursor word highlight'      , 0] ,
          \ ['nmap' , ['x' , 'h' , 'o'] , '<plug>(quickhl-tag-toggle)'    , 'toggle tag cursor word highlight'  , 0] ,
          \ ]
  else
    nmap <space>xhh <Plug>(quickhl-manual-this)
    xmap <space>xhh <Plug>(quickhl-manual-this)
    nmap <space>xhr <Plug>(quickhl-manual-reset)
    xmap <space>xhr <Plug>(quickhl-manual-reset)
    nmap <space>xhc <Plug>(quickhl-manual-clear)
    xmap <space>xhc <Plug>(quickhl-manual-clear)
    nmap <space>xht <Plug>(quickhl-manual-toggle)
    xmap <space>xht <Plug>(quickhl-manual-toggle)
    nmap <space>xhw <Plug>(quickhl-cword-toggle)
    nmap <space>xho <Plug>(quickhl-tag-toggle)
  endif
endfunction " }}}


function! s:vim_table_mode() abort "{{{
  if g:is_spacevim
    let g:_spacevim_mappings.t   = {'name': '+@ Table mode'}
    let g:_spacevim_mappings.t.d = {'name': 'Delete cells'}
    let g:_spacevim_mappings.t.m = ['TableModeToggle'                    , 'toggle tablemode']
    let g:_spacevim_mappings.t.t = ['Tableize'                           , 'convert current/select line to table']
    let g:_spacevim_mappings.t.r = ['TableModeRealign'                   , 'realign table columns']
    let g:_spacevim_mappings.t.a = ['TableAddFormula'                    , 'define a formula']
    let g:_spacevim_mappings.t.e = ['TableEvalFormulaLine'               , 'eval formula and update table']
    let g:_spacevim_mappings.t.s = ['TableSort'                          , 'sort cursor column']
    let g:_spacevim_mappings.t.d.d = ['<Plug>(table-mode-delete-row)'    , 'delete cursor/select row']
    let g:_spacevim_mappings.t.d.c = ['<Plug>(table-mode-delete-column)' , 'delete cursor/select column']
    let g:_spacevim_mappings.t['?'] = ['<Plug>(table-mode-echo-cell)'    , 'echo formula result']
  else
    nnoremap <silent><leader>tm   :TableModeToggle<CR>
    nnoremap <silent><leader>tt   :Tableize<CR>
    nnoremap <silent><leader>tr   :TableModeRealign<CR>
    nnoremap <silent><leader>ta   :TableAddFormula<CR>
    nnoremap <silent><leader>te   :TableEvalFormulaLine<CR>
    nnoremap <silent><leader>ts   :TableSort<CR>
    nnoremap <silent><leader>tdd  <Plug>(table-mode-delete-row)
    nnoremap <silent><leader>tdc  <Plug>(table-mode-delete-column)
    nnoremap <silent><leader>t?   <Plug>(table-mode-echo-cell)
  endif
endfunction "}}}


" local func {{{
function! s:transpose_with_previous(type) abort
  if a:type ==# 'line'
    if line('.') > 1
      let l:save_register = @"
      normal! kddp
      let @" = l:save_register
    endif
  elseif a:type ==# 'word'
    let save_register = @k
    normal! "kyiw
    let cw = @k
    normal! ge"kyiw
    let tw = @k
    if cw !=# tw
      let @k = cw
      normal! viw"kp
      let @k = tw
      normal! eviw"kp
    endif
    let @k = save_register
  elseif a:type ==# 'character'
    if col('.') > 1
      let l:save_register = @"
      normal! hxp
      let @" = l:save_register
    endif
  endif
endfunction

function! s:transpose_with_next(type) abort
  let l:save_register = @"
  if a:type ==# 'line'
    if line('.') < line('$')
      normal! ddp
    endif
  elseif a:type ==# 'word'
    normal! yiw
    let l:cw = @"
    normal! wyiw
    let l:nw = @"
    if l:cw !=# l:nw
      let @" = l:cw
      normal! viwp
      let @" = l:nw
      normal! geviwp
    endif
  elseif a:type ==# 'character'
    if col('.') < col('$')-1
      normal! xp
    endif
  endif
  let @" = l:save_register
endfunction

function! s:move_text_down_transient_state() abort
  if line('.') == line('$')
  else
    let l:save_register = @"
    normal! ddp
    let @" = l:save_register
  endif
  call s:text_transient_state()
endfunction

function! s:move_text_up_transient_state() abort
  if line('.') > 1
    let l:save_register = @"
    normal! ddkP
    let @" = l:save_register
  endif
  call s:text_transient_state()
endfunction

function! s:text_transient_state() abort
  let state = SpaceVim#api#import('transient_state')
  call state.set_title('Move Text Transient State')
  call state.defind_keys(
        \ {
        \ 'layout' : 'vertical split',
        \ 'left' : [
        \ {
        \ 'key' : 'j',
        \ 'desc' : 'move text down',
        \ 'func' : '',
        \ 'cmd' : 'noautocmd silent! m .+1',
        \ 'exit' : 0,
        \ },
        \ ],
        \ 'right' : [
        \ {
        \ 'key' : 'k',
        \ 'func' : '',
        \ 'desc' : 'move text up',
        \ 'cmd' : 'noautocmd silent! m .-2',
        \ 'exit' : 0,
        \ },
        \ ],
        \ }
        \ )
  call state.open()
endfunction

function! s:lowerCamelCase() abort
  " fooFzz
  let cword = s:parse_symbol(expand('<cword>'))
  if !empty(cword)
    let rst = [cword[0]]
    if len(cword) > 1
      let rst += map(cword[1:], "substitute(v:val, '^.', '\\u&', 'g')")
    endif
    let save_register = @k
    let save_cursor = getcurpos()
    let @k = join(rst, '')
    normal! viw"kp
    call setpos('.', save_cursor)
    let @k = save_register
  endif
endfunction

function! s:UpperCamelCase() abort
  " FooFzz
  let cword = s:parse_symbol(expand('<cword>'))
  if !empty(cword)
    let rst = map(cword, "substitute(v:val, '^.', '\\u&', 'g')")
    let save_register = @k
    let save_cursor = getcurpos()
    let @k = join(rst, '')
    normal! viw"kp
    call setpos('.', save_cursor)
    let @k = save_register
  endif
endfunction

function! s:kebab_case() abort
  " foo-fzz
  let cword = s:parse_symbol(expand('<cword>'))
  if !empty(cword)
    let save_register = @k
    let save_cursor = getcurpos()
    let @k = join(cword, '-')
    normal! viw"kp
    call setpos('.', save_cursor)
    let @k = save_register
  endif
endfunction

function! s:under_score() abort
  " foo_fzz
  let cword = s:parse_symbol(expand('<cword>'))
  if !empty(cword)
    let save_register = @k
    let save_cursor = getcurpos()
    let @k = join(cword, '_')
    normal! viw"kp
    call setpos('.', save_cursor)
    let @k = save_register
  endif
endfunction

function! s:up_case() abort
  " FOO_FZZ
  let cword =map(s:parse_symbol(expand('<cword>')), 'toupper(v:val)')
  if !empty(cword)
    let save_register = @k
    let save_cursor = getcurpos()
    let @k = join(cword, '_')
    normal! viw"kp
    call setpos('.', save_cursor)
    let @k = save_register
  endif
endfunction

let s:STRING = SpaceVim#api#import('data#string')
function! s:parse_symbol(symbol) abort
  if a:symbol =~# '^[a-z]\+\(-[a-zA-Z]\+\)*$'
    return split(a:symbol, '-')
  elseif a:symbol =~# '^[a-z]\+\(_[a-zA-Z]\+\)*$'
    return split(a:symbol, '_')
  elseif a:symbol =~# '^[a-z]\+\([A-Z][a-z]\+\)*$'
    let chars = s:STRING.string2chars(a:symbol)
    let rst = []
    let word = ''
    for char in chars
      if char =~# '[a-z]'
        let word .= char
      else
        call add(rst, tolower(word))
        let word = char
      endif
    endfor
    call add(rst, tolower(word))
    return rst
  elseif a:symbol =~# '^[A-Z][a-z]\+\([A-Z][a-z]\+\)*$'
    let chars = s:STRING.string2chars(a:symbol)
    let rst = []
    let word = ''
    for char in chars
      if char =~# '[a-z]'
        let word .= char
      else
        if !empty(word)
          call add(rst, tolower(word))
        endif
        let word = char
      endif
    endfor
    call add(rst, tolower(word))
    return rst
  else
    return [a:symbol]
  endif
endfunction

function! s:count_selection_region() abort
  call feedkeys("gvg\<c-g>\<Esc>", 'ti')
endfunction


function! s:delete_extra_space() abort
  if !empty(getline('.'))
    if getline('.')[col('.')-1] ==# ' '
      execute "normal! \"_ciw\<Space>\<Esc>"
    endif
  endif
endfunction

function! s:set_justification_to(align) abort
  let l:startlinenr = line("'{")
  let l:endlinenr = line("'}")
  if getline(l:startlinenr) ==# ''
    let l:startlinenr += 1
  endif
  if getline(l:endlinenr) ==# ''
    let l:endlinenr -= 1
  endif
  let l:lineList = map(getline(l:startlinenr, l:endlinenr), 'trim(v:val)')
  let l:maxlength = 0
  for l:line in l:lineList
    let l:length = strdisplaywidth(l:line)
    if l:length > l:maxlength
      let l:maxlength = l:length
    endif
  endfor

  if a:align ==# 'left'
    execute l:startlinenr . ',' . l:endlinenr . ":left\<CR>"
  elseif a:align ==# 'center'
    execute l:startlinenr . ',' . l:endlinenr . ':center ' . l:maxlength . "\<CR>"
  elseif a:align ==# 'right'
    execute l:startlinenr . ',' . l:endlinenr . ':right  ' . l:maxlength . "\<CR>"
  endif

  unlet l:startlinenr
  unlet l:endlinenr
  unlet l:lineList
  unlet l:maxlength
endfunction

function! s:align_at_regular_expression() abort
  let re = input(':Tabularize /')
  if !empty(re)
    exe 'Tabularize /' . re
  else
    normal! :
    echo 'empty input, canceled!'
  endif
endfunction

" function() wrapper "{{{
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
endif "}}} "}}}
