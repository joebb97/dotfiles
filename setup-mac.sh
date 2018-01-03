#!/bin/bash
printf "running dotfiles setup at $(date)...\n"
if [ "$1" == "-c" ] || [ "$1" == "--copy" ]
then
    files=".bashrc-mac .vimrc .gitconfig .inputrc"
    backup_dir = "~/dotfile-backups"
    if [ ! -d $backup_dir]
    then
        mkdir $backup_dir
    fi
    for file in $files
    do
        if [ $file == ".bashrc-mac" ]
        then
            if [ -f ~/.bashrc]
            then
                printf "Moving bashrc to $backup_dir...\n"
                mv -iv ~/$file $backup_dir/.bashrc
            fi
            
            printf "Making symlink from $(pwd)/$file to ~/.bashrc...\n"
            ln -siv $(pwd)$file ~/.bashrc
            continue
        fi

        if [ -f ~/$file ]
        then
            printf "Moving $file to $backup_dir...\n"
            mv -iv ~/$file $backup_dir/$file
        fi

        if [ $file == "ssh_config" ]
        then
            if [ ! -d ~/.ssh ]
            then
                mkdir ~/.ssh
            fi
            
            printf "Making symlink from $(pwd)/$file to ~/.ssh/config...\n"
            ln -siv $(pwd)/$file ~/.ssh/config
            continue
        fi

        printf "Making symlink from $(pwd)/$file to ~/$file...\n"
        ln -siv $(pwd)/$file ~/$file # symbolic links require full path
    done
fi

if [ ! -d ~/.bash_it ]
then
    printf "installing bash_it...\n"
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]
then
    printf "cloning Vundle (vim plugin manager)...\n"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ ! -d /usr/local/Cellar/autojump ]
then
    brew install autojump
fi

source ~/.bashrc
