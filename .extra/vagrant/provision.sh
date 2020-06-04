apt-get update
apt-get -y install software-properties-common
add-apt-repository ppa:jonathonf/vim
apt-get update
apt-get install -y git python3-dev libffi-dev build-essential virtualenvwrapper
apt-get install -y curl man git python python3 cmake g++\
    autojump tmux vim ctags 
cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
git clone --depth 1 --bare https://gitlab.eecs.umich.edu/joebb/dotfiles/ $HOME/.cfg
git clone --depth 1 https://gitlab.eecs.umich.edu/joebb/sandbox $HOME/sandbox
$cfg checkout -f
$cfg submodule update --init 
