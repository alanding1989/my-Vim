" =============================================================================
" keymap.vim --- define which key
" Section config/Vim
" =============================================================================
scriptencoding utf-8



" ================================================================================
" leader mappings
" ================================================================================
augroup MyVim_which_key
  autocmd! FileType which_key
  autocmd  FileType which_key set laststatus=2 noshowmode noruler
        \| autocmd BufLeave <buffer> set laststatus=2 ruler
augroup END

let g:which_key_map = {}
call which_key#register('<Space>', 'g:which_key_map')
nnoremap <silent><leader>       :WhichKey get(g:, 'mapleader', ';')<CR>
vnoremap <silent><leader>       :WhichKeyVisual get(g:, 'mapleader', ';')<CR>
nnoremap <silent><localleader>  :WhichKey get(g:, 'localleader', '<Space>')<CR>
vnoremap <silent><localleader>  :WhichKeyVisual get(g:, 'localleader', '<Space>')<CR>

" nnoremap <leader>aa        ggVG

" echo value
nnoremap <leader>ec        :echo ' '.g:autocomplete_method<CR>
" nnoremap <leader>ee        :echo
nnoremap <leader>eh        :EchoHlight 
nnoremap <leader>es        :echo ' '.g:snippet_engine<CR>
nnoremap <leader>el        :call layers#checkers#showlinter()<CR>
" nnoremap <leader>em        :EchoMap
" nnoremap <leader>ev        :version<CR>
if get(g:, 'snippet_engine', 'neosnippet') ==# 'neosnippet'
  noremap <leader>en       :NeoSnippetEdit -split -vertical 
elseif get(g:, 'snippet_engine') ==# 'ultisnips'
  noremap <leader>en       :UltiSnipsEdit 
endif

" " directory operatios
" nnoremap <leader>db        :lcd %:p:h<CR>
" nnoremap <leader>dd        :lcd
" nnoremap <leader>dw        :lcd<CR>
" nnoremap <leader>dp        :pwd<CR>


" ================================================================================
" Space mapping
" ================================================================================

" help
" nnoremap <space>hh  :call utile#help()<CR>

" recache_runtimepath when plugin list changed
nnoremap <space>qn  :call dein#recache_runtimepath()<CR>

nnoremap <space>qu  :PlugUpdate 

if g:plugmanager ==# 'vim-plug'
  nnoremap <space>qs :PlugSnapshot ~/.SpaceVim.d/backup/plugsnapshot.vim<CR>
endif

if has('nvim')
  if g:plugmanager ==# 'dein'
    nnoremap <space>qm  :call dein#remote_plugins()<CR>
  else
    nnoremap <space>qm  :UpdateRemotePlugins<CR>
  endif
  " nnoremap <space>qh  :checkhealth<CR>
endif
