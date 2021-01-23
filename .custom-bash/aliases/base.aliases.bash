#!/bin/bash
# QUALITY OF LIFE ALIASES
alias sbrc='source $HOME/.bashrc'
alias ebrc='vim $HOME/.bashrc'
alias ebhi='vim $HOME/.bash_history'
alias evrc='vim $HOME/.vimrc'
alias egcfg='vim $HOME/.gitconfig'
alias eggig='vim $HOME/.extra/git-files/global-gitignore.txt'
alias ealias='vim $HOME/.custom-bash/aliases/base.aliases.bash'
alias howbig='du -sh'
# CONFIG ALIASES
alias cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfgs='cfg status'
alias cfga='cfg add '
alias cfgall='cfg add -A'
alias cfgcm='cfg commit -m '
alias cfgp='cfg push'
alias cfgl='cfg pull'
alias cfgll='cfg log --graph --pretty=oneline --abbrev-commit'
alias cfgd='cfg diff'
alias sshnc='ssh -F /dev/null'
alias m='make -j5'
alias make='make -j5'
alias ag="ag --pager='less -XFR'"
# Use best tool for job for finding files
alias ls='ls --color=auto'
if hash rg 2>/dev/null; then
    alias find_file='rg --files -g'
elif hash ag 2>/dev/null; then
    alias find_file='ag -g'
elif hash ack 2>/dev/null; then
    alias find_file='ack --ignore-file=is:tags -g'
else
    alias find_file="find . -iname"
fi
alias weather="curl wttr.in/ann_arbor"
alias dkc="docker container"
alias tma="tmux attach"
alias top15="find . -maxdepth 1 -mindepth 1 -print0 | xargs -0 du -ks -- | sort -rn | head -15"
