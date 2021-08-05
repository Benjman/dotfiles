call plug#begin('~/.vim/plugged')

" let Vundle manage Vundle, required
Plug 'VundleVim/Vundle.vim'

" " improved status bar
Plug 'vim-airline/vim-airline'

" glsl filetype highlighting
Plug 'tikhomirov/vim-glsl'

" gruvbox color scheme
Plug 'gruvbox-community/gruvbox'

" file navigation
Plug 'scrooloose/nerdtree'

Plug 'neoclide/coc.nvim'
Plug 'drmikehenry/vim-headerguard'

" tpope is god
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'

Plug 'ryanoasis/vim-devicons'
Plug 'cj/vim-webdevicons'

call plug#end()

filetype plugin indent on

" To ignore plugin indent changes, instead use:
filetype plugin on

" enable man plugin for vim
runtime ftplugin/man.vim 

