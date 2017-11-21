set nocompatible              " DO NOT REMOVE
filetype off                  " DO NOT REMOVE
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " DO NOT REMOVE
Plugin 'valloric/youcompleteme'
Plugin 'epmatsw/ag.vim'
Plugin 'sjl/gundo.vim'
Plugin 'kien/ctrlp.vim'
" PLUGINS MUST GO HERE
call vundle#end()            " DO NOT REMOVE
filetype plugin indent on    " DO NOT REMOVE

" NON PLUGIN STUFF BELOW HERE
"colorscheme molokai "colors! 
syntax enable "enable different syntaxes
filetype indent on "load file-specific indent files
set clipboard=unnamed
set tabstop=4 "set tabs to 2 visual spaces
set shiftwidth=4
set expandtab
set number "shows line numbers
set showcmd "shows last entered command 
set wildmenu "autocompletes
set backspace=2
set backspace=indent,eol,start
"set lazyredraw "redraw only when needed
set showmatch
set incsearch "makes searching better
"set hlsearch
set foldenable "enable folding
set foldmethod=indent "sets where folding is determined
set cursorline
set splitbelow
set splitright
let mapleader=","
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
inoremap <C-J> <ESC><C-W><C-J>
inoremap <C-K> <ESC><C-W><C-K>
inoremap <C-L> <ESC><C-W><C-L>
inoremap <C-H> <ESC><C-W><C-H>
inoremap jj <ESC>
nnoremap j gj
nnoremap k gk
nnoremap gV `[v`]
nnoremap <leader>w :w<CR>
nnoremap <leader>m :make<CR>
nnoremap <leader>j Lzt
nnoremap <leader>k Hzb
nnoremap <leader><space> :noh<CR>
nnoremap <leader>b $A{<CR>}<ESC>O
nnoremap <leader>svrc :source $MYVIMRC<CR>
nnoremap <leader>save :mksession!<CR>
nnoremap <leader>/ :Ag  
nnoremap <leader>u :GundoToggle<CR>
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif " close preview tab of youcompleteme
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
