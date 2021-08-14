" enable syntax and plugins
syntax enable
filetype plugin on

source ~/.vim/defaults.vim
source ~/.vim/plugins.vim

" map *.vert and *.frag to glsl filetype
autocmd! BufNewFile,BufRead *.vert,*.frag set filetype=glsl


let mapleader=" "

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
nmap <C-h> :Telescope find_files<cr>
