if exists('g:vscode')
    " VSCode extension
    call plug#begin()
    Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }
    Plug 'unblevable/quick-scope'
    call plug#end()
else
    " ordinary neovim
    call plug#begin()
    Plug 'easymotion/vim-easymotion'
    Plug 'unblevable/quick-scope'
    call plug#end()
endif

let mapleader="\<Space>"

" easymotion settings
let g:EasyMotion_smartcase = 1

" quick-scope settings
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T', ';', ',']

highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
