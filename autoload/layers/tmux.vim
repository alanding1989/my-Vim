"=============================================================================
" tmux.vim --- tmux layer
" Section: layer
"=============================================================================




function! layers#tmux#plugins() abort
  let plugins = [
        \ ['christoomey/vim-tmux-navigator', { 'on_cmd': [
        \ 'TmuxNavigateLeft', 'TmuxNavigateDown', 'TmuxNavigateUp',
        \ 'TmuxNavigateRight'] }],
        \ ]
  call add(plugins, ['tmux-plugins/vim-tmux', {'on_ft' : 'tmux'}])
  call add(plugins, ['edkolev/tmuxline.vim', {'merged' : 0}])
  return plugins
endfunction

function! layers#tmux#config() abort
  let g:tmux_navigator_no_mappings = 1

  augroup layer_tmux
    autocmd!
    autocmd FocusGained * set cursorline
    autocmd FocusLost * set nocursorline | redraw!
  augroup END

  if s:tmux_navigator_modifier ==# 'alt'
    nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
    nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
    nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
    nnoremap <silent> <M-l> :TmuxNavigateRight<CR>
  else
    nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
    nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
    nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
    nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
  endif
  let g:neomake_tmux_enabled_makers = ['tmux']
  let g:neomake_tmux_tmux_maker = {
        \ 'exe': 'tmux',
        \ 'args': ['source-file', '-q'],
        \ 'errorformat': '%f:%l:%m,%+Gunknown command: %s',
        \ }
  let g:tmuxline_separators = {
        \ 'left' : s:separators[s:tmuxline_separators][0],
        \ 'left_alt': s:i_separators[s:tmuxline_separators_alt][0],
        \ 'right' : s:separators[s:tmuxline_separators][1],
        \ 'right_alt' : s:i_separators[s:tmuxline_separators_alt][1],
        \ 'space' : ' '}
  let g:tmuxline_preset = {
        \'a'    : '#S',
        \'b'    : '#W',
        \'win'  : ['#I', '#W'],
        \'cwin' : ['#I', '#W'],
        \'x'    : '%a',
        \'y'    : '%R',
        \'z'    : '#H'}
endfunction

" init
let s:separators = {
      \ 'arrow' : ["\ue0b0", "\ue0b2"],
      \ 'curve' : ["\ue0b4", "\ue0b6"],
      \ 'slant' : ["\ue0b8", "\ue0ba"],
      \ 'brace' : ["\ue0d2", "\ue0d4"],
      \ 'fire' : ["\ue0c0", "\ue0c2"],
      \ 'nil' : ['', ''],
      \ }

let s:i_separators = {
      \ 'arrow' : ["\ue0b1", "\ue0b3"],
      \ 'bar' : ['|', '|'],
      \ 'nil' : ['', ''],
      \ }

let s:tmuxline_separators = g:spacevim_statusline_separator
let s:tmuxline_separators_alt = g:spacevim_statusline_inactive_separator
let s:tmux_navigator_modifier = 'ctrl'

function! layers#tmux#set_variable(var) abort

  let s:tmuxline_separators = get(a:var,
        \ 'tmuxline_separators',
        \ g:spacevim_statusline_separator)

  let s:tmuxline_separators_alt = get(a:var,
        \ 'tmuxline_separators_alt',
        \ g:spacevim_statusline_inactive_separator)

  let s:tmux_navigator_modifier = get(a:var,
        \ 'tmux_navigator_modifier',
        \ s:tmux_navigator_modifier)

endfunction


function! layers#tmux#get_options() abort

  return ['tmuxline_separators', 'tmuxline_separators_alt', 'tmux_navigator_modifier']

endfunction
