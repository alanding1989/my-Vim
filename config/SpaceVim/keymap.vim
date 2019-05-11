" =============================================================================
" keymap.vim --- VimEnter keymap for SpaceVim
" Section config/SpaceVim
" =============================================================================
scriptencoding utf-8




" ================================================================================
" Leader mapping --- define personal leader key for SpaceVim
" ================================================================================
" NOTE: if lrh has three keys no need to call func , rhs cmd need to add : and <CR>
" need to define after vim enter
let g:_spacevim_mappings[';'] = ['', 'easyMotion prefix']

let g:_spacevim_mappings.a['name'] = get(g:_spacevim_mappings.a, 'name', '+@ Session/Setting/Select')
let g:_spacevim_mappings.a.c       = get(g:_spacevim_mappings.a, 'c', {'name': '+Open config file'})
" select
call SpaceVim#mapping#def('nnoremap', '<leader>aa',
      \ 'ggVG', 'select whole buffer', '', 'select whole buffer')
call SpaceVim#mapping#def('nnoremap', '<leader>ae',
      \ 'VG', 'select to the end', '', 'select to the end')
call SpaceVim#mapping#def('nnoremap', '<leader>az',
      \ ':call mapping#basic#zzmode()<CR>', 'toggle zzmode', '', 'toggle zzmode')
call SpaceVim#mapping#def('nnoremap <expr>', '<leader>az',
      \ "'`['.strpart(getregtype(), 0, 1).'`]'", 'toggle zzmode', '', 'toggle zzmode')
" call SpaceVim#mapping#def('nnoremap', '<leader>am',
      " \ ':call util#statusline#pureline()', 'set statusline', '', 'set statusline')
" call SpaceVim#mapping#def('xnoremap', '<leader>y',
      " \ '"+y', 'copy selection to system clipboard', '', 'copy selection to system clipboard')


" echo value/edit snippets
let g:_spacevim_mappings.e   = {'name':  '+@ Echo value/Edit snippets' }
let g:_spacevim_mappings.e.c = ["echo '  '.g:spacevim_autocomplete_method", 'show autocomplete method']
let g:_spacevim_mappings.e.e = ['call feedkeys(":echo ")'                 , 'echo prefix'             ]
let g:_spacevim_mappings.e.f = ['call feedkeys(":call ")'                 , 'call prefix'             ]
let g:_spacevim_mappings.e.h = ['call feedkeys(":EchoHlight ")'           , 'echo highlight'          ]
let g:_spacevim_mappings.e.l = ['call layers#checkers#showlinter()'       , 'show syntax linter '     ]
let g:_spacevim_mappings.e.m = ['call feedkeys(":EchoMap ")'              , 'show specific keymap'    ]
let g:_spacevim_mappings.e.o = ['call feedkeys(":set ")'                  , 'echo options'            ]
let g:_spacevim_mappings.e.s = ["echo '  '.g:spacevim_snippet_engine"     , 'show snippet engine'     ]
let g:_spacevim_mappings.e.v = ['version'                                 , 'show neovim/vim version' ]
if get(g:, 'spacevim_snippet_engine', 'neosnippet') ==# 'neosnippet'
  let g:_spacevim_mappings.e.n = ['call feedkeys(":NeoSnippetEdit -split -vertical ")', 'edit neosnippet snippets']
elseif get(g:, 'spacevim_snippet_engine') ==# 'ultisnips'
  let g:_spacevim_mappings.e.n = ['call feedkeys(":UltiSnipsEdit ")', 'edit ultisnips snippets']
endif


" Directory operatios
let g:_spacevim_mappings.d   = {'name': '+@ Directory operatios' }
let g:_spacevim_mappings.d.d = ['call feedkeys(":lcd ")'                   , 'specify a dir to switch']
let g:_spacevim_mappings.d.b = ['call feedkeys(":lcd %:p:h\<CR>:pwd\<CR>")', 'swich to buffer dir'    ]
let g:_spacevim_mappings.d.w = ['call feedkeys(":lcd\<CR>:pwd\<CR>")'      , 'swich to shell dir'     ]
let g:_spacevim_mappings.d.p = ['call feedkeys(":pwd\<CR>")'               , 'print current dir'      ]


" tab jump
let g:_spacevim_mappings.1   = ['call Tabjump(1)', 'Window 1']
let g:_spacevim_mappings.2   = ['call Tabjump(2)', 'Window 2']
let g:_spacevim_mappings.3   = ['call Tabjump(3)', 'Window 3']
let g:_spacevim_mappings.4   = ['call Tabjump(4)', 'Window 4']
let g:_spacevim_mappings.5   = ['call Tabjump(5)', 'Window 5']
let g:_spacevim_mappings.6   = ['call Tabjump(6)', 'Window 6']
let g:_spacevim_mappings.7   = ['call Tabjump(7)', 'Window 7']
let g:_spacevim_mappings.8   = ['call Tabjump(8)', 'Window 8']
let g:_spacevim_mappings.9   = ['call Tabjump(9)', 'Window 9']

" win jump
let g:_spacevim_mappings_space.1 = ['call Winjump(1)', 'Window 1']
let g:_spacevim_mappings_space.2 = ['call Winjump(2)', 'Window 2']
let g:_spacevim_mappings_space.3 = ['call Winjump(3)', 'Window 3']
let g:_spacevim_mappings_space.4 = ['call Winjump(4)', 'Window 4']
let g:_spacevim_mappings_space.5 = ['call Winjump(5)', 'Window 5']
let g:_spacevim_mappings_space.6 = ['call Winjump(6)', 'Window 6']
let g:_spacevim_mappings_space.7 = ['call Winjump(7)', 'Window 7']
let g:_spacevim_mappings_space.8 = ['call Winjump(8)', 'Window 8']


let g:_spacevim_mappings['<C-I>']  = [':b#<CR>', '@ last buffer' ]
nnoremap <silent><leader><tab> :b#<CR>


" ================================================================================
" Space mapping --- define personal space key for SpaceVim
" ================================================================================
" NOTE: if rhs is a cmd, need to add 5th "arg=1"
" define key group, e.g: let g:_spacevim_mappings_space.x = {'name': 'xx'}
" space_custom key can define mapping in a list, no need to call func
" define before VimEnter or after
let g:_spacevim_mappings_space_custom += [
      \ ['nmap', ['h', 't'], 'call util#test_SPC()'           , '@ toggle test env of SpaceVim'       , 1],
      \ ['nmap', ['h', 'h'], 'call util#help_wrapper()'       , '@ get help docs of input/cursor word', 1],
      \ ['nmap', ['q', 'n'], 'call dein#recache_runtimepath()', '@ recache runtime path for plugins'  , 1],
      \ ['nmap', ['q', 'u'], 'call util#update_plugin()'      , '@ update all/input plugins'          , 1],
      \ ['nmap', ['q', 'd'], 'SPDebugInfo!'                   , '@ check SpaceVim debug info'         , 1],
      \ ]

if g:is_nvim
  let g:_spacevim_mappings_space_custom += [
        \ ['nmap', ['q', 'm'], 'call dein#remote_plugins()'   , '@ update remote plugins'             , 1],
        \ ['nmap', ['q', 'h'], 'checkhealth'                  , '@ Neovim checkhealth'                , 1],
        \ ]
endif

auto FileType vim call SpaceVim#mapping#space#def('nmap', ['q', 'l'],
      \ 'call util#Show_curPlugin_log()', '@ show cursor plugin`s commit log', 1)
