#!/bin/bash
printf "running dotfiles setup at $(date)\n" 
files=$(ls -a | grep '^\.\w' | grep -v '^\.git$' | grep -v '\.swp$')
for file in $files
do
    if [ -f ~/$file ]
    then
        printf "found $file in ~ \n"
    fi
done

if [ ! -d ~/.tmux ]
then
    printf "cloning tmux plugin manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
fi

if [ ! -d /usr/share/autojump ]
then
    printf "installing autojump"
    sudo apt install autojump
    echo "source /usr/share/autojump.sh" >> ~/.bashrc
    source ~/.bashrc
fi
