set nocompatible              " DO NOT REMOVE
filetype off                  " DO NOT REMOVE

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " DO NOT REMOVE
Plugin 'valloric/youcompleteme'
" PLUGINS MUST GO HERE
call vundle#end()            " DO NOT REMOVE
filetype plugin indent on    " DO NOT REMOVE

" NON PLUGIN STUFF BELOW HERE
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
set backspace=2
set backspace=indent,eol,start
"set lazyredraw "redraw only when needed
set showmatch
set incsearch "makes searching better
set hlsearch
"set foldenable "enable folding
"set foldmethod=indent "sets where folding is determined
nnoremap j gj
nnoremap k gk
nnoremap gV `[v`]
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif " close preview tab of youcompleteme
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
