set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'valloric/youcompleteme'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set clipboard=unnamed
"colorscheme molokai "colors! 
syntax enable "enable different syntaxes
set tabstop=4 "set tabs to 2 visual spaces
set shiftwidth=4
set expandtab
set number "shows line numbers
set showcmd "shows last entered command 
filetype indent on "load file-specific indent files
set wildmenu "autocompletes
"set lazyredraw "redraw only when needed
set showmatch
set incsearch "makes searching better
set hlsearch
"set foldenable "enable folding
"set foldmethod=indent "sets where folding is determined
nnoremap j gj
nnoremap k gk
nnoremap gV `[v`]

