set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu

" ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

nnoremap <silent> Q <nop>

vnoremap J :move '>+1<CR>gv=gv
vnoremap K :move '<-2<CR>gv=gv

command! W w

call plug#begin('~/.vim/plugged')

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'
Plug 'svenstaro/glsl-language-server', { 'do': 'cmake -Bbuild && make --directory build' }

" file navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" tpope is god
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'

call plug#end()

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

let mapleader=" "

syntax enable
filetype plugin indent on

" To ignore plugin indent changes, instead use:
filetype plugin on

" enable man plugin for vim
runtime ftplugin/man.vim 

" tilde navigates to open file in nerdtree
nmap ` :NERDTreeFind<cr>

