set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set clipboard=unnamedplus
nnoremap <C-g>v :vsp +term<CR>
nnoremap <C-g>% :vsp +term<CR>
nnoremap <C-g>s :sp +term<CR>
nnoremap <C-g>" :sp +term<CR>
nnoremap <C-g>c :tabe<CR>:term<CR>

tnoremap <C-g>v :vsp +term<CR>
tnoremap <C-g>% :vsp +term<CR>
tnoremap <C-g>s :sp +term<CR>
tnoremap <C-g>" :sp +term<CR>
tnoremap <C-g>c :tabe<CR>:term<CR>

tnoremap <C-g>h <C-\><C-N><C-w>h
tnoremap <C-g>j <C-\><C-N><C-w>j
tnoremap <C-g>k <C-\><C-N><C-w>k
tnoremap <C-g>l <C-\><C-N><C-w>l
tnoremap <C-g><C-h> <C-\><C-N><C-w>h
tnoremap <C-g><C-j> <C-\><C-N><C-w>j
tnoremap <C-g><C-k> <C-\><C-N><C-w>k
tnoremap <C-g><C-l> <C-\><C-N><C-w>l

inoremap <C-g>h <C-\><C-N><C-w>h
inoremap <C-g>j <C-\><C-N><C-w>j
inoremap <C-g>k <C-\><C-N><C-w>k
inoremap <C-g>l <C-\><C-N><C-w>l
inoremap <C-g><C-h> <C-\><C-N><C-w>h
inoremap <C-g><C-j> <C-\><C-N><C-w>j
inoremap <C-g><C-k> <C-\><C-N><C-w>k
inoremap <C-g><C-l> <C-\><C-N><C-w>l

nnoremap <C-g>h <C-w>h
nnoremap <C-g>j <C-w>j
nnoremap <C-g>k <C-w>k
nnoremap <C-g>l <C-w>l
