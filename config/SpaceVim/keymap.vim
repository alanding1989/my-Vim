" =============================================================================
" keymap.vim --- VimEnter keymap for SpaceVim
" Section config/SpaceVim
" =============================================================================
scriptencoding utf-8


" ================================================================================
" Leader mapping --- define personal leader key for SpaceVim
" ================================================================================
" NOTE: if use command no need to call func, use <Plug> need to call func.
"       rhs cmd need to add : and <CR>

" echo value/edit snippets
let g:_spacevim_mappings.e         = get(g:_spacevim_mappings, 'e'   , {})
let g:_spacevim_mappings.e['name'] = get(g:_spacevim_mappings.e, 'name', '+@ Echo value/Edit snippets')

let g:_spacevim_mappings.e.c = ["echo '  '.g:spacevim_autocomplete_method", 'show autocomplete method']
let g:_spacevim_mappings.e.e = ['call feedkeys(":echo ")'                 , 'echo prefix'             ]
let g:_spacevim_mappings.e.f = ['call feedkeys(":call ")'                 , 'function call prefix'    ]
let g:_spacevim_mappings.e.h = ['call feedkeys(":EchoHlight ")'           , 'echo highlight'          ]
let g:_spacevim_mappings.e.l = ['call layers#checkers#showlinter()'       , 'show syntax linter'      ]
let g:_spacevim_mappings.e.g = ['syntax'                                  , 'show syntax summary'     ]
let g:_spacevim_mappings.e.m = ['call feedkeys(":EchoMap ")'              , 'echo specific keymap'    ]
let g:_spacevim_mappings.e.o = ['call feedkeys(":set ")'                  , 'echo vim options'        ]
let g:_spacevim_mappings.e.s = ["echo '  '.g:spacevim_snippet_engine"     , 'show snippet engine'     ]
let g:_spacevim_mappings.e.t = ["echo 'Current Theme is: '.g:colors_name" , 'show current colortheme' ]
let g:_spacevim_mappings.e.v = ['version'                                 , 'show neovim/vim version' ]

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


let g:_spacevim_mappings['<C-I>']  = [':b#<CR>', '@ last buffer' ]
nnoremap <silent><leader><tab> :b#<CR>


" ================================================================================
" Space mapping --- define personal <Space> key mapping for SpaceVim
" ================================================================================
" NOTE: If rhs is a cmd, need to add 5th "arg=1".
"       Define key group, e.g: let g:_spacevim_mappings_space.x = {'name': 'xx'},
"       Space_Custom key can define mapping in a list, no need to call func

" win jump
let g:_spacevim_mappings_space.1    =  ['call Winjump(1)', 'Window 1']
let g:_spacevim_mappings_space.2    =  ['call Winjump(2)', 'Window 2']
let g:_spacevim_mappings_space.3    =  ['call Winjump(3)', 'Window 3']
let g:_spacevim_mappings_space.4    =  ['call Winjump(4)', 'Window 4']
let g:_spacevim_mappings_space.5    =  ['call Winjump(5)', 'Window 5']
let g:_spacevim_mappings_space.6    =  ['call Winjump(6)', 'Window 6']
let g:_spacevim_mappings_space.7    =  ['call Winjump(7)', 'Window 7']
let g:_spacevim_mappings_space.8    =  ['call Winjump(8)', 'Window 8']

let g:_spacevim_mappings_space.h    =  get(g:_spacevim_mappings_space,'h', {'name' : '+Help'})
let g:_spacevim_mappings_space.h.t  =  ['call util#test_SPC()'           , '@ toggle test env of SpaceVim'       ]
let g:_spacevim_mappings_space.h.p  =  ['call feedkeys(":SpcPR ")'       , '@ SPC PR environment preparation'    ]
let g:_spacevim_mappings_space.h.h  =  ['call feedkeys(":EchoHelp ")'    , '@ get help docs of input/cursor word']
let g:_spacevim_mappings_space.q.n  =  ['call dein#recache_runtimepath()', '@ recache runtime path for plugins'  ]
let g:_spacevim_mappings_space.q.u  =  ['call util#update_plugin()'      , '@ update all/input plugins'          ]
let g:_spacevim_mappings_space.q.d  =  ['SPDebugInfo!'                   , '@ check SpaceVim debug info'         ]

if g:is_nvim
  let g:_spacevim_mappings_space.q   = get(g:_spacevim_mappings_space,'q', {'name' : '+Quit'})
  let g:_spacevim_mappings_space.q.m = ['call dein#remote_plugins()'     , '@ update remote plugins'             ]
  let g:_spacevim_mappings_space.q.h = ['checkhealth'                    , '@ Neovim checkhealth'                ]
endif

auto FileType vim call SpaceVim#mapping#space#def('nmap', ['q', 'l'],
      \ 'call util#Show_curPlugin_log()', '@ show cursor plugin`s commit log', 1)


"================================================================================
" g mappings
"================================================================================
let g:_spacevim_mappings_g['0'] = ['call feedkeys("g*", "n")'    , 'seach and highlight under cursor forward']
let g:_spacevim_mappings_g['c'] = ['echo "Col Number:".col(".")' , 'show current column number'              ]
let g:_spacevim_mappings_g['m'] = ['call feedkeys("ga", "n")'    , 'print ascii value of cursor character'   ]
let g:_spacevim_mappings_g['o'] = ['call feedkeys("gf", "n")'    , 'edit file under cursor'                  ]
let g:_spacevim_mappings_g['t'] = ['call feedkeys("'.maparg('gt', 'n')[-5].'")', 'goto TypeDefinition'       ]
let g:_spacevim_mappings_g['i'] = ['call feedkeys("'.maparg('gi', 'n')[-5].'")', 'goto Implementation'       ]
let g:_spacevim_mappings_g['r'] = ['call feedkeys("'.maparg('gr', 'n')[-5].'")', 'find References'           ]
let g:_spacevim_mappings_g['f'] = ['call feedkeys("'.maparg('gf', 'n')[-5].'")', 'format code'               ]
let g:_spacevim_mappings_g['e'] = ['call feedkeys("'.maparg('ge', 'n')[-5].'")', 'rename Symbol'             ]
let g:_spacevim_mappings_g['s'] = ['call feedkeys("'.maparg('gs', 'n')[-5].'")', 'get Symbols of Document'   ]
let g:_spacevim_mappings_g['S'] = ['call feedkeys("'.maparg('gS', 'n')[-5].'")', 'get Symbols of WorkSpace'  ]
let g:_spacevim_mappings_g['l'] = ['call feedkeys("'.maparg('gl', 'n')[-5].'")', 'show Diagnostic Info'      ]
let g:_spacevim_mappings_g['a'] = ['call feedkeys("'.maparg('ga', 'n')[-5].'")', 'do CodeActions'            ]
