"PLUGINS BB
call plug#begin()
Plug 'davidhalter/jedi-vim'
"Plug 'valloric/youcompleteme'
Plug 'ludovicchabant/vim-gutentags'
Plug 'sjl/gundo.vim'
Plug 'kien/ctrlp.vim'
"Plug 'vim-syntastic/syntastic'
"Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdtree'
" VIM AIRLINE
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/taglist.vim'
Plug 'mileszs/ack.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'maralla/completor.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
" Auto completion boys
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'keremc/asyncomplete-clang.vim'
call plug#end()            " DO NOT REMOVE
"
"WEIRD SHIT FOR PLUGINS
"autocmd User asyncomplete_setup call asyncomplete#register_source(
"    \ asyncomplete#sources#clang#get_source_options())

"if executable('pyls')
    " pip install python-language-server
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'pyls',
"        \ 'cmd': {server_info->['pyls']},
"        \ 'whitelist': ['python'],
"        \ })
"endif

"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
"set completeopt+=preview
"imap <c-space> <Plug>(asyncomplete_force_refresh)
"autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" enable line numbers
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let python_highlight_all=1
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'ra'
let g:airline#extensions#tabline#enabled=1 
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline_theme='molokai'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'python': ['autopep8', 'yapf', 'isort']
\}
let g:ale_linters = {
\   'python': ['pylint', 'flake8', 'pydocstyle'],
\   'c': ['gcc', 'clang'],
\   'cpp': ['gcc', 'clang']
\}
let g:ale_c_parse_compile_commands=1
let g:ale_c_parse_makefile=1

" NON PLUGIN STUFF BELOW HERE
colorscheme deus "colors! 
syntax enable "enable different syntaxes

set clipboard=unnamed "universal clipboard
set autoindent
set tabstop=4 
set shiftwidth=4
set softtabstop=4
set expandtab
"set noexpandtab "use tabs
"set list
"set listchars=tab:>

set nobackup
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


"COMMAND
command!  Svrc :source $MYVIMRC
command!  Save :mksession!
command!  Evrc :e $MYVIMRC
command!  Ebrc :e $HOME/.bashrc
command!  Egcfg :e $HOME/.gitconfig

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
nnoremap <leader>/ :Ack
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>c :NERDTreeToggle<CR>
nnoremap <leader>t :TlistToggle<CR>
nnoremap <leader>h :bp<CR>
nnoremap <leader>l :bn<CR>
nnoremap <leader>f :NERDTreeFind<CR>
