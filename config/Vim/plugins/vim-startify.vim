" ================================================================================
" startify settings
" ================================================================================
scriptencoding  utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1



let g:startify_session_dir  = expand($HOME.'/.cache/'.'startify/'.( has('nvim') ? 'nvim' : 'vim' ).'/session')
let g:startify_files_number = 6
let g:startify_list_order   = [
      \ ['    My most recently used files in the current directory:'],
      \ 'dir',
      \ ['    My most recently used files:'],
      \ 'files',
      \ ['    These are my sessions:'],
      \ 'sessions',
      \ ['    These are my bookmarks:'],
      \ 'bookmarks',
      \ ]

let g:startify_bookmarks              = [ {'z': (!g:is_win ? expand('~/.zshrc') : '')} ]
let g:startify_update_oldfiles        = 1
let g:startify_disable_at_vimenter    = 0
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 1
let g:startify_session_delete_buffers = 0
let g:startify_change_to_dir          = 0
let g:startify_change_to_vcs_root     = 0  " vim-rooter has same feature

let g:startify_skiplist               = [
      \ 'COMMIT_EDITMSG',
      \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
      \ 'bundle/.*/doc',
      \ ]
