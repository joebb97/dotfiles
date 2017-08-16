#!/bin/bash
printf "running dotfiles setup at $(date)...\n"
if [ "$1" == "-c" ] || [ "$1" == "--copy" ]
then
    files=".vimrc .tmux.conf .bashrc .gitconfig .inputrc"
    backup_dir = "~/dotfile-backups"
    for file in $files
    do
        if [ -f ~/$file ]
        then
            if [ ! -d $backup_dir]
            then
                mkdir $backup_dir
            fi

            if [ ! -f $backup_dir/$file ]
            then
                printf "Moving $file to $backup_dir...\n"
                mv -ivb ~/$file $backup_dir/$file
            fi   
            
            printf "Making symlink from $(pwd)/$file to ~/$file...\n"
            ln -sivb $(pwd)/$file ~/$file # symbolic links require full path
        fi
    done
fi

if [ ! -d ~/.tmux ]
then
    printf "cloning tmux plugin manager...\n"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d /usr/share/autojump ]
then
    printf "installing autojump...\n"
    sudo apt install autojump
    echo "source /usr/share/autojump/autojump.sh" >> ~/.bashrc
fi

if [ ! -d ~/.bash_it ]
then
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]
then
    printf "cloning Vundle (vim plugin manager)...\n"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ ! $(dpkg -l | grep 'vim-gtk') ]
then
    sudo apt install vim-gtk
fi
    
echo "sourcing bashrc"
source ~/.bashrc
