#!/bin/bash
printf "running dotfiles setup at $(date)\n"
if [ "$1" == "-c" ] || [ "$1" == "--copy" ]
then
    files=$(ls -a | grep '^\.\w' | grep -v '^\.git$' | grep -v '\.swp$')
    for file in $files
    do
        if [ -f ~/$file ]
        then
            if [ ! -d ~/dot-file-backups ]
            then
                mkdir ~/dot-file-backups
            fi

            if [ ! -f ~/dot-file-backups/$file ]
            then
                cp -ivb ~/$file ~/dot-file-backups/$file
            fi   
            
            ln -sivb $(pwd)/$file ~/$file # symbolic links require full path
        fi
    done
fi

if [ ! -d ~/.tmux ]
then
    printf "cloning tmux plugin manager\n"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d /usr/share/autojump ]
then
    printf "installing autojump\n"
    sudo apt install autojump
    echo "source /usr/share/autojump/autojump.sh" >> ~/.bashrc
fi

if [ ! -d ~/.bash_it ]
then
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh
fi

echo "sourcing bashrc"
source ~/.bashrc
