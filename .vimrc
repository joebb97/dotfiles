"PLUGINS BB
call plug#begin()
Plug 'davidhalter/jedi-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'sjl/gundo.vim'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/taglist.vim'
Plug 'mileszs/ack.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'maralla/completor.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
"Plug 'vim-syntastic/syntastic'
"Plug 'nvie/vim-flake8'
" Plug 'christoomey/vim-tmux-navigator'
" Auto completion boys
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'keremc/asyncomplete-clang.vim'
call plug#end()            " DO NOT REMOVE
"
"WEIRD SHIT FOR PLUGINS
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_fmt_autosave = 0
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let python_highlight_all=1
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'ra'
" Prefer rg over ag over ack
if executable('rg')
    set grepprg=rg\ --hidden
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
elseif executable('ag')
    set grepprg=ag\ --no-color\ --hidden
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
elseif executable('ack')
    set grepprg=ack\ --no-color
endif
let g:airline#extensions#tabline#enabled=1 
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline_theme='molokai'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'python': ['autopep8', 'isort'],
\   'cpp': ['clang-format'],
\   'c': ['clang-format'],
\   'elm': ['elm-format'],
\   'go': ['go-fmt'],
\   'rust': ['rustfmt']
\}
let g:ale_linters = {
\   'python': ['flake8', 'pydocstyle', 'pyflakes'],
\   'c': ['gcc', 'clang'],
\   'cpp': ['gcc', 'clang'],
\   'javascript': ['jshint'],
\   'rust': ['cargo', 'rls', 'rustc']
\}
let g:ale_c_parse_compile_commands=1
let g:ale_c_parse_makefile=1
let g:gundo_prefer_python3=1

" NON PLUGIN STUFF BELOW HERE
colorscheme deus "colors! 
syntax enable "enable different syntaxes

set autowrite " Enable autowrite
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
nnoremap <C-g>v :vert term<CR>
nnoremap <C-g>% :vert term<CR>
nnoremap <C-g>s :term<CR>
nnoremap <C-g>" :term<CR>
nnoremap <C-g>c :tabe<CR>:term ++curwin<CR>
nnoremap <C-g>n gt
nnoremap <C-g>p gT
nnoremap <C-g>" :term<CR>
nnoremap <C-g>h <C-W><C-h>
nnoremap <C-g>j <C-W><C-j>
nnoremap <C-g>k <C-W><C-k>
nnoremap <C-g>l <C-W><C-l>
nnoremap <C-g><C-H> <C-W><C-h>
nnoremap <C-g><C-J> <C-W><C-j>
nnoremap <C-g><C-K> <C-W><C-k>
nnoremap <C-g><C-l> <C-W><C-l>

"TNOREMAP
tnoremap <C-j> <C-W>N
tnoremap <C-g>v <C-W>N:vert term<CR>
tnoremap <C-g>% <C-W>N:vert term<CR>
tnoremap <C-g>s <C-W>N:term<CR>
tnoremap <C-g>" <C-W>N:vert term<CR>
tnoremap <C-g>c <C-W>N:tabe<CR>:term ++curwin<CR>
tnoremap <C-g>n <C-W>Ngt
tnoremap <C-g>p <C-W>NgT
tnoremap <C-g>h <C-W><C-h>
tnoremap <C-g>j <C-W><C-j>
tnoremap <C-g>k <C-W><C-k>
tnoremap <C-g>l <C-W><C-l>
tnoremap <C-g><C-H> <C-W><C-h>
tnoremap <C-g><C-J> <C-W><C-j>
tnoremap <C-g><C-K> <C-W><C-k>
tnoremap <C-g><C-l> <C-W><C-l>

"LEADER KEY
nnoremap <leader>rnw:! rscript -e "library('knitr');knit2pdf('$(ls *.Rnw)')"<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>m :make<CR>
nnoremap <leader>j Lzt
nnoremap <leader>k Hzb
nnoremap <leader>z <C-w>\|<C-w>_
nnoremap <leader>x <C-w>=
nnoremap <leader>sa :Save<CR>
nnoremap <leader>sv :Svrc<CR>
nnoremap <leader>ev :Evrc<CR>
nnoremap <leader>eb :Ebrc<CR>
nnoremap <leader><space> :noh<CR>
nnoremap <leader>bl $A {<CR>}<ESC>O
nnoremap <leader>bs $A<CR>{<CR>}<ESC>O
nnoremap <leader>/ :Ack
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nc :NERDTreeClose<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>cn :cn<CR>
nnoremap <leader>cp :cp<CR>
nnoremap <leader>te :tabe<CR>
nnoremap <leader>af :ALEFix<CR>
nnoremap <leader>ai :ALEInfo<CR>
nnoremap <leader>gb :GoBuild<CR>
nnoremap <leader>gf :GoFmt<CR>
nnoremap <leader>gr :GoRun<CR>
nnoremap <leader>gl :GoMetaLinter<CR>
nnoremap <leader>tl :TlistToggle<CR>
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>h :bp<CR>
nnoremap <leader>l :bn<CR>
