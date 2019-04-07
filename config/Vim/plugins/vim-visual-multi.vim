"=========================================================================
" File Name    : config/Vim/plugins/vim-visual-multi.vim
" Author       : AlanDing
" mail         :
" Created Time : Wed 27 Mar 2019 06:01:07 AM CST
"=========================================================================
scriptencoding utf-8



let g:VM_maps               = {}
let g:VM_maps['Select All'] = ''
let g:VM_maps['Visual All'] = ''

nmap <silent> <M-k>  <Plug>(VM-Add-Cursor-Up)
nmap <silent> <M-j>  <Plug>(VM-Add-Cursor-Down)
nmap <silent> <M-a>  <Plug>(VM-Select-All)


" mappings {{{
" "o
" let mapsf["Select Operator"][0]         = 'gs'
" let maps["Add Cursor At Pos"][0]        = 'g<space>'
" let maps["Start Regex Search"][0]       = 'g/'
" let maps["Add Cursor Down"][0]          = '<C-Down>'
" let maps["Add Cursor Up"][0]            = '<C-Up>'
" let maps["Visual Regex"][0]             = 'g/'
" let maps["Visual All"][0]               = leader.'A'
" let maps["Visual Add"][0]               = '<C-a>'
" let maps["Visual Find"][0]              = '<C-f>'
" let maps["Visual Cursors"][0]           = '<C-c>'
"
"
" let maps["Mouse Cursor"][0]             = '<C-LeftMouse>'
" let maps["Mouse Word"][0]               = '<C-RightMouse>'
" let maps["Mouse Column"][0]             = '<M-C-RightMouse>'
"
" "s
" call extend(maps, {
"       \"Find I Word":             ['gw',        'n', 1, 1],
"       \"Find A Word":             ['gW',        'n', 1, 1],
"       \"Find A Subword":          ['gw',        'x', 1, 1],
"       \"Find A Whole Subword":    ['gW',        'x', 1, 1],
"       \})
"
" "sublime
" call extend(maps, {
"       \"Skip Region":             ['<C-s>',      'n', 1, 1],
"       \"F3 Next":                 ['<F3>',       'n', 1, 1],
"       \"F2 Prev":                 ['<F2>',       'n', 1, 1],
"       \})
"
" "basic
" call extend(maps, {
"       \"Switch Mode":             ['<Tab>',     'n', 1, 1],
"       \"Toggle Block":            ['<BS>',      'n', 1, 1],
"       \"Toggle Only This Region": ['<CR>',      'n', 1, 1],
"       \})
"
" "select
" call extend(maps, {
"       \"Find Next":               [']',         'n', 1, 1],
"       \"Find Prev":               ['[',         'n', 1, 1],
"       \"Goto Next":               ['}',         'n', 1, 1],
"       \"Goto Prev":               ['{',         'n', 1, 1],
"       \"Seek Up":                 ['<C-b>',     'n', 1, 1],
"       \"Seek Down":               ['<C-f>',     'n', 1, 1],
"       \"Invert Direction":        ['o',         'n', 1, 1],
"       \"q Skip":                  ['q',         'n', 1, 1],
"       \"Remove Region":           ['Q',         'n', 1, 1],
"       \"Remove Last Region":      ['<C-q>',     'n', 1, 1],
"       \"Remove Every n Regions":  [leader.'R',  'n', 1, 1],
"       \"Star":                    ['*',         'n', 1, 1],
"       \"Hash":                    ['#',         'n', 1, 1],
"       \"Visual Star":             ['*',         'x', 1, 1],
"       \"Visual Hash":             ['#',         'x', 1, 1],
"       \"Merge To Eol":            ['<S-End>',   'n', 1, 1],
"       \"Merge To Bol":            ['<S-Home>',  'n', 1, 1],
"       \"Select All Operator":     ['s',         'n', 1, 0],
"       \"Find Operator":           ['m',         'n', 1, 1],
"       \"Add Cursor Down":         ['<C-Down>',  'n', 1, 1],
"       \"Add Cursor Up":           ['<C-Up>',    'n', 1, 1],
"       \})
"
" "utility
" call extend(maps, {
"       \"Tools Menu":              [leader.'x',  'n', 1, 1],
"       \"Show Help":               ['<F1>',      'n', 1, 1],
"       \"Show Registers":          [leader.'"',  'n', 0, 1],
"       \"Toggle Debug":            ['<C-x><F12>','n', 1, 1],
"       \"Case Setting":            ['<c-c>',     'n', 1, 1],
"       \"Toggle Whole Word":       ['<c-w>',     'n', 1, 1],
"       \"Case Conversion Menu":    [leader.'c',  'n', 1, 1],
"       \"Search Menu":             [leader.'S',  'n', 1, 1],
"       \"Rewrite Last Search":     [leader.'r',  'n', 1, 1],
"       \"Show Infoline":           [leader.'l',  'n', 0, 1],
"       \"Toggle Multiline":        ['M',         'n', 1, 1],
"       \})
"
" "zeta
" call extend(maps, {
"       \"Run Normal":              ['zz',        'n', 0, 1],
"       \"Run Last Normal":         ['Z',         'n', 1, 1],
"       \"Run Visual":              ['zv',        'n', 0, 1],
"       \"Run Last Visual":         ['zV',        'n', 1, 1],
"       \"Run Ex":                  ['zx',        'n', 0, 1],
"       \"Run Last Ex":             ['<C-z>',     'n', 1, 1],
"       \"Run Macro":               ['z@',        'n', 1, 1],
"       \"Run Dot":                 ['z.',        'n', 1, 1],
"       \"Align Char":              ['z<',        'n', 1, 1],
"       \"Align Regex":             ['z>',        'n', 1, 1],
"       \"Numbers":                 ['zn',        'n', 0, 1],
"       \"Numbers Append":          ['zN',        'n', 1, 1],
"       \"Zero Numbers":            ['z0n',       'n', 0, 1],
"       \"Zero Numbers Append":     ['z0N',       'n', 1, 1],
"       \"Shrink":                  ["z-",        'n', 1, 1],
"       \"Enlarge":                 ["z+",        'n', 1, 1],
"       \})
" }}}
