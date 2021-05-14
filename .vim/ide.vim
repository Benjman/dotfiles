" hi leader
let mapleader=" "

set wildignore+=**/cmake-build*/**
set wildignore+=**/build*/**
set wildignore+=**/dep/**

" fixed indentation for the entire file
nmap <C-A-L> gg=G<C-o><C-o>

" tab navigation
nmap <C-Left> :tabp<cr>
nmap <C-Right> :tabn<cr>

nmap <leader>fc ?class<cr>y2w/{<cr>%$a // <esc>p
nmap <leader><A-R> :echo "Hello"<cr>

" go to ctag definition, or find references
nmap <F3> :YcmCompleter GoToDefinition<cr>
nmap <leader>fr :YcmCompleter GoToReferences<cr>
" ycm FixIt: attempts to make changes to the buffer to correct diagnostics on the current line.
nmap <leader>fl :YcmCompleter FixIt<cr>
" renaming symbols across files
nmap <leader>r :YcmCompleter RefactorRename 
