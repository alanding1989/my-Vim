" =============================================================================
" keymap.vim --- define which key
" Section config/Vim
" =============================================================================
scriptencoding utf-8



" ================================================================================
" leader mappings
" ================================================================================


" nnoremap <leader>aa        ggVG
" nnoremap <silent><leader>am  :call util#statusline#pureline()<CR>

" echo value
nnoremap <leader>ec        :echo ' '.g:autocomplete_method<CR>
" nnoremap <leader>ee        :echo
" nnoremap <leader>eh        :call feedkeys(':EchoHlight ')<CR>
nnoremap <leader>es        :echo ' '.g:snippet_engine<CR>
nnoremap <leader>el        :call layers#checkers#showlinter()<CR>
" nnoremap <leader>em        :EchoMap
" nnoremap <leader>ev        :version<CR>
if get(g:, 'snippet_engine', 'neosnippet') ==# 'neosnippet'
  noremap <leader>en       :call feedkeys(':NeoSnippetEdit -split -vertical ')<CR>
elseif get(g:, 'snippet_engine') ==# 'ultisnips'
  noremap <leader>en       :call feedkeys(':UltiSnipsEdit ')<CR>
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
" nnoremap <space>hh  :EchoHelp 

nnoremap <space>qu  :call util#update_plugin()<CR>

" recache_runtimepath when plugin list changed
if g:plugmanager ==# 'dein'
  nnoremap <space>qn  :call dein#recache_runtimepath()<CR>
elseif g:plugmanager ==# 'vim-plug'
  nnoremap <space>qs  :PlugSnapshot ~/.SpaceVim.d/backup/plugsnapshot.vim<CR>
endif

if has('nvim')
  if g:plugmanager ==# 'dein'
    nnoremap <space>qm  :call dein#remote_plugins()<CR>
  else
    nnoremap <space>qm  :UpdateRemotePlugins<CR>
  endif
  " nnoremap <space>qh  :checkhealth<CR>
endif

auto FileType vim nnoremap <leader>ql  :call util#Show_curPlugin_log()<CR>

call mapping#leader#init()

