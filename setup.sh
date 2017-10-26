#!/bin/bash
printf "running dotfiles setup at $(date)...\n"
if [ "$1" == "-c" ] || [ "$1" == "--copy" ]
then
    files=".vimrc .tmux.conf .gitconfig .inputrc ssh_config .bashrc"
    backup_dir = "~/dotfile-backups"
    if [ ! -d $backup_dir]
    then
        mkdir $backup_dir
    fi
    for file in $files
    do
        if [ -f ~/$file ]
        then
            printf "Moving $file to $backup_dir...\n"
            mv -ivb ~/$file $backup_dir/$file
        fi

        if [ $file == "ssh_config" ]
        then
            if [ ! -d ~/.ssh ]
            then
                mkdir ~/.ssh
            fi
            
            printf "Making symlink from $(pwd)/$file to ~/.ssh/config...\n"
            ln -sivb $(pwd)/$file ~/.ssh/config
            continue
        fi
        
        printf "Making symlink from $(pwd)/$file to ~/$file...\n"
        ln -sivb $(pwd)/$file ~/$file # symbolic links require full path
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
    printf "installing bash_it...\n"
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]
then
    printf "cloning Vundle (vim plugin manager)...\n"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

dpkg -l | grep 'vim-gtk' > /dev/null
if [ $? != 0 ]
then
    sudo apt install vim-gtk
fi

dpkg -l | grep 'tmux' > /dev/null
if [ $? != 0 ]
then
    sudo apt install tmux
fi
    
echo "sourcing bashrc"
source ~/.bashrc
