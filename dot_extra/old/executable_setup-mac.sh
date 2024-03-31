#!/bin/bash
printf "running dotfiles setup at $(date)...\n"
if [ "$1" == "-c" ] || [ "$1" == "--copy" ]
then
    files=".bashrc-mac .vimrc .gitconfig .inputrc"
    backup_dir="$HOME/dotfile-backups"
    if [ ! -d $backup_dir ]
    then
        mkdir $backup_dir
    fi
    for file in $files
    do
        if [ $file == ".bashrc-mac" ]
        then
            file=".bashrc"
            cp .bashrc-mac .bashrc
        fi

        if [ -f $HOME/$file ]
        then
            printf "Moving $file to $backup_dir...\n"
            mv -iv $HOME/$file $backup_dir/$file
        fi

        if [ $file == "ssh_config" ]
        then
            if [ ! -d $HOME/.ssh ]
            then
                mkdir $HOME/.ssh
            fi
            
            printf "Making symlink from $(pwd)/$file to $HOME/.ssh/config...\n"
            ln -siv $(pwd)/$file $HOME/.ssh/config
            continue
        fi

        printf "Making symlink from $(pwd)/$file to $HOME/$file...\n"
        ln -siv $(pwd)/$file $HOME/$file # symbolic links require full path
    done
fi

if [ ! -d $HOME/.bash_it ]
then
    printf "installing bash_it...\n"
    git clone --depth=1 https://github.com/Bash-it/bash-it.git $HOME/.bash_it
    $HOME/.bash_it/install.sh
fi

if [ ! -d $HOME/.vim/bundle/Vundle.vim ]
then
    printf "cloning Vundle (vim plugin manager)...\n"
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

if [ ! -d /usr/local/Cellar/autojump ]
then
    brew install autojump
fi

source $HOME/.bashrc
