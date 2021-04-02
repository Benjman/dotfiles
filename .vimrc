" remove vi integration. not needed in current millenium.
set nocompatible

" enable syntax and plugins
syntax enable
filetype plugin on

"""""""""""""""""
"	FINDING FILES
"
set cmdheight=2
set hidden
set incsearch
set nobackup
set noerrorbells
set nohlsearch
set noshowmatch
set noswapfile
set nowrap
set number
set relativenumber
set scrolloff=3
set shiftwidth=4
set smartcase
set smartindent
set tabstop=4
set termguicolors
set textwidth=135
set undodir=~/.vim/undodir
set undofile

" map *.vert and *.frag to glsl filetype
autocmd! BufNewFile,BufRead *.vert,*.frag set filetype=glsl


let mapleader=" "

" =========
" =	PLUGINS
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" improved status bar
Plugin 'vim-airline/vim-airline'

" glsl filetype highlighting
Plugin 'tikhomirov/vim-glsl'

" gruvbox color scheme
Plugin 'gruvbox-community/gruvbox'

" file navigation
Plugin 'scrooloose/nerdtree'

" code completion
Plugin 'ycm-core/YouCompleteMe'

" tpope is god
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-commentary'

Plugin 'ryanoasis/vim-devicons'

call vundle#end()
filetype plugin indent on

" To ignore plugin indent changes, instead use:
filetype plugin on

" set color scheme
silent! colorscheme gruvbox
colorscheme gruvbox
set background=dark

" display all matching files with tab complete
set path +=**
set wildmenu

" highlight all instances of word under cursor
autocmd CursorMoved * exe printf('match PmenuThumb /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" tilde navigates to open file in nerdtree
nmap ` :NERDTreeFind<cr>

" open file finder with ctrl-h
nmap <C-h> :find 
