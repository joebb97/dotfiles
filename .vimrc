set nocompatible              " DO NOT REMOVE
filetype off                  " DO NOT REMOVE
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " DO NOT REMOVE
Plugin 'davidhalter/jedi-vim'
Plugin 'epmatsw/ag.vim'
Plugin 'sjl/gundo.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mileszs/ack.vim'
" PLUGINS MUST GO HERE
call vundle#end()            " DO NOT REMOVE
filetype plugin indent on    " DO NOT REMOVE

" NON PLUGIN STUFF BELOW HERE
colorscheme molokai "colors! 
syntax enable "enable different syntaxes

"SET
set clipboard=unnamed "universal clipboard
set autoindent
set tabstop=4 
set shiftwidth=4
set softtabstop=4
set expandtab
"set noexpandtab "use tabs
"set list
"set listchars=tab:>

set number "shows line numbers
set showcmd "shows last entered command 
set wildmenu "autocompletes
set backspace=2
set backspace=indent,eol,start
set lazyredraw "redraw only when needed
set showmatch
set incsearch "makes searching better
"set hlsearch
set foldenable "enable folding
set foldlevelstart=10
set foldmethod=indent "sets where folding is determined
set cursorline
set splitbelow
set splitright
set laststatus=2
set ttimeoutlen=50

"LET
let mapleader=","
" enable line numbers
let NERDTreeShowLineNumbers=1

"WEIRD SHIT FOR PLUGINS
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif " close preview tab of youcompleteme
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
let python_highlight_all=1
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'ra'
"let g:ctrlp_user_command = 'ag %s -l --nocolor -hidden -g ""'
let g:airline#extensions#tabline#enabled=1 
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline_theme='molokai'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"COMMAND
command!  Svrc :source $MYVIMRC
command!  Save :mksession!
command!  Evrc :e $MYVIMRC

"INOREMAP
inoremap <C-J> <ESC><C-W><C-J>
inoremap <C-K> <ESC><C-W><C-K>
inoremap <C-L> <ESC><C-W><C-L>
inoremap <C-H> <ESC><C-W><C-H>
inoremap jj <ESC>

"NNOREMAP
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <space> za
nnoremap j gj
nnoremap k gk
nnoremap gV `[v`]
nnoremap <leader>r :! rscript -e "library('knitr');knit2pdf('$(ls *.Rnw)')"<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>m :make<CR>
nnoremap <leader>j Lzt
nnoremap <leader>k Hzb
nnoremap <leader><space> :noh<CR>
nnoremap <leader>b $A{<CR>}<ESC>O
nnoremap <leader>/ :Ag  
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>h :bp<CR>
nnoremap <leader>l :bn<CR>
