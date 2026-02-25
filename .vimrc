set nocompatible
set expandtab
set tabstop=4

filetype on
filetype plugin on
filetype indent on

syntax on
set number 

highlight LineNr ctermfg=yellow 
highlight CursorLineNr ctermfg=red

noremap h <left>
noremap j <Up>
noremap k <Down>
noremap l <Right>


call plug#begin()
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'dylanaraps/wal.vim'
	Plug 'davidhalter/jedi-vim'
	Plug 'tpope/vim-fugitive'
	Plug 'jmcantrell/vim-virtualenv'
	Plug 'vim-python/python-syntax'
    Plug 'elkowar/yuck.vim'
call plug#end()
