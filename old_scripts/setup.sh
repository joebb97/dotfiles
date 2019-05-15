#!/bin/bash
printf "running dotfiles setup at $(date)...\n"
if [ "$1" == "-c" ] || [ "$1" == "--copy" ]
then
    files=".vimrc .tmux.conf .gitconfig .inputrc ssh_config .bashrc-deb"
    backup_dir="$HOME/dotfile-backups"
    if [ ! -d $backup_dir ]
    then
        mkdir $backup_dir
    fi
    for file in $files
    do
        if [ -f $HOME/$file ]
        then
            printf "Moving $file to $backup_dir...\n"
            mv -ivb $HOME/$file $backup_dir/$file
        fi

        if [ $file == ".bashrc-deb" ]
        then
            file=".bashrc"
            cp .bashrc-deb .bashrc
        fi

        if [ $file == "ssh_config" ]
        then
            if [ ! -d $HOME/.ssh ]
            then
                mkdir $HOME/.ssh
            fi
            
            printf "Making symlink from $(pwd)/$file to $HOME/.ssh/config...\n"
            ln -sivb $(pwd)/$file $HOME/.ssh/config
            continue
        fi
        
        printf "Making symlink from $(pwd)/$file to $HOME/$file...\n"
        ln -sivb $(pwd)/$file $HOME/$file # symbolic links require full path
    done
fi

if [ ! -d $HOME/.tmux ]
then
    printf "cloning tmux plugin manager...\n"
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

if [ ! -d /usr/share/autojump ]
then
    printf "installing autojump...\n"
    sudo apt install autojump
    echo "source /usr/share/autojump/autojump.sh" >> $HOME/.bashrc
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

sudo apt-get update
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
rm -f .bashrc
source $HOME/.bashrc
