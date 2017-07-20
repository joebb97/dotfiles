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
            
            ln -sivb $file ~/$file
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
    source ~/.bashrc
fi

echo "sourcing tmux conf"
tmux source ~/.tmux.conf
echo "sourcing bashrc"
source ~/.bashrc

