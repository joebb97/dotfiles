# QUALITY OF LIFE ALIASES
alias sbrc='source $HOME/.bashrc'
alias ebrc="vim $HOME/.bashrc"
alias evrc="vim $HOME/.vimrc"
alias egcfg="vim $HOME/.gitconfig"
alias eggig="vim $HOME/.extra/git-files/global-gitignore.txt"
# CONFIG ALIASES
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfgs='cfg status'
alias cfga='cfg add '
alias cfgall='cfg add -A'
alias cfgcm='cfg commit -m '
alias cfgp='cfg push'
alias cfgl='cfg pull'
alias cfgll='cfg log --graph --pretty=oneline --abbrev-commit'
alias cfgd='cfg diff'
alias ssh-no-conf='ssh -F /dev/null'
alias m='make -j5'
alias make='make -j5'
# Use best tool for job for finding files
alias_name="find_file"
if hash rg 2>/dev/null; then
    alias ${alias_name}="rg --files -g"
elif hash ag 2>/dev/null; then
    alias ${alias_name}="ag -g"
elif hash ack 2>/dev/null; then
    alias ${alias_name}="ack --ignore-file=is:tags -g"
else
    alias ${alias_name}="find . -iname"
fi
alias weather="curl wttr.in/ann_arbor"
