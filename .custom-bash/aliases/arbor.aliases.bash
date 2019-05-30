export BOX="berm"
alias tubasync="rsync -avh $HOME/Dev/arbor/packages/tuba/build/src/tuba root@$BOX:/base/data/Dev/arbor/packages/tuba/build/src"
alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'
