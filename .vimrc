" PLUGINS BB
call plug#begin()
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kien/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
" Plug 'maralla/completor.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'glench/vim-jinja2-syntax'
Plug 'airblade/vim-gitgutter'
Plug 'elixir-editors/vim-elixir'
Plug 'dag/vim2hs'
Plug 'dag/vim-fish'
if has('nvim-0.4') || has('patch-8.0.1453')
    Plug 'fatih/vim-go'
endif
call plug#end() " DO NOT REMOVE
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
" let g:gitgutter_set_sign_backgrounds = 1
let g:airline#extensions#tabline#enabled=1 
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline_theme='papercolor'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint', 'prettier'],
\   'python': ['autopep8', 'isort'],
\   'cpp': ['clang-format'],
\   'c': ['clang-format'],
\   'elm': ['elm-format'],
\   'go': ['gofmt', 'goimports', 'golines'],
\   'rust': ['rustfmt'],
\   'haskell': ['hindent'],
\}
let g:ale_linters = {
\   'python': ['flake8', 'pydocstyle', 'pyflakes', 'pyright'],
\   'c': ['gcc', 'clang'],
\   'cpp': ['gcc', 'clang'],
\   'javascript': ['jshint'],
\   'typescript': ['eslint', 'tsserver'],
\   'rust': ['cargo', 'rls', 'analyzer'],
\   'go': ['gobuild', 'gofmt', 'gopls', 'govet', 'golangci-lint']
\}
let g:ale_completion_enabled = 1
let g:ale_c_parse_compile_commands=1
let g:ale_c_parse_makefile=1
" let g:ale_python_flake8_executable='python3'
" let g:ale_python_flake8_options='-m flake8'
" let g:ale_python_pyflakes_executable='python3'
" let g:ale_python_pyflakes_options='-m pyflakes'
" let g:ale_python_pydocstyle_executable='python3'
" let g:ale_python_pydocstyle_options='-m pydocstyle'
" let g:ale_python_autopep8_executable='python3'
" let g:ale_python_autopep8_options='-m autopep8'
" let g:ale_python_isort_executable='python3'
" let g:ale_python_isort_options='-m isort'
let g:ale_rust_cargo_check_all_targets=1
let g:ale_rust_cargo_use_clippy = 1

let g:gutentags_ctags_exclude=["@.gitignore"]
let g:tagbar_show_linenumbers = 1

" NON PLUGIN STUFF BELOW HERE
colorscheme sonokai "colors!
syntax enable
" highlight commands need to go after colorscheme
highlight link ALEErrorSign Error
" highlight link ALEError Error
highlight SignColumn ctermbg=NONE guibg=NONE
highlight GitGutterAdd ctermbg=NONE guibg=NONE
highlight GitGutterChange ctermbg=NONE guibg=NONE
highlight GitGutterDelete ctermbg=NONE guibg=NONE
highlight GitGutterChangeDelete ctermbg=NONE guibg=NONE
hi clear VertSplit

set mouse=a
if has('nvim-0.5') || has('patch-8.1.1565')
    set signcolumn=number
endif
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
set path+=**

"LET
let mapleader=","


"COMMAND
command!  Svrc :source $MYVIMRC
command!  Save :mksession!
command!  Evrc :e $HOME/.vimrc
command!  Ebrc :e $HOME/.bashrc
command!  Egcfg :e $HOME/.gitconfig
command!  Efc  :e $HOME/.config/fish/config.fish

"INOREMAP
inoremap <C-J> <ESC><C-W><C-J>
inoremap <C-K> <ESC><C-W><C-K>
inoremap <C-L> <ESC><C-W><C-L>
inoremap <C-H> <ESC><C-W><C-H>
inoremap hh <ESC>

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
nnoremap <C-g>h <C-W><C-h>
nnoremap <C-g>j <C-W><C-j>
nnoremap <C-g>k <C-W><C-k>
nnoremap <C-g>l <C-W><C-l>
nnoremap <C-g><C-H> <C-W><C-h>
nnoremap <C-g><C-J> <C-W><C-j>
nnoremap <C-g><C-K> <C-W><C-k>
nnoremap <C-g><C-l> <C-W><C-l>

"TNOREMAP
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
nnoremap <leader>ef :Efc<CR>
nnoremap <leader><space> :noh<CR>
nnoremap <leader>bl $A {<CR>}<ESC>O
nnoremap <leader>bs $A<CR>{<CR>}<ESC>O
nnoremap <leader>nill oif err != nil {<CR>return err<CR>}<ESC>
nnoremap <leader>nili oif err != nil {<CR>}<ESC>O
nnoremap <leader>nilt oif err != nil {<CR>return nil, err<CR>}<ESC>
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
nnoremap <leader>at :ALEToggle<CR>
nnoremap <leader>ad :ALEGoToDefinition<CR>
nnoremap <leader>ar :ALEFindReferences<CR>
nnoremap <leader>gb :GoBuild<CR>
nnoremap <leader>gf :GoFmt<CR>
nnoremap <leader>gr :GoRun<CR>
nnoremap <leader>gv :GoVet ./...<CR>
nnoremap <leader>gl :GoLint ./...<CR>
nnoremap <leader>tb :TagbarToggle<CR>
nnoremap <leader>to :TagbarOpen fj<CR>
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>gg :GitGutterToggle<CR>
nnoremap <leader>h :bp<CR>
nnoremap <leader>l :bn<CR>
