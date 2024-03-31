FROM ubuntu:16.04
ARG USER=joey
ENV USER=$USER
ENV HOME=/home/$USER

# INSTALL NECESSARY PACKAGES
RUN apt-get update
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:jonathonf/vim
RUN apt-get update
RUN apt-get install -y curl man git python python3 cmake g++\
    autojump tmux vim ctags 
RUN apt-get upgrade -y

# ADD A USER SPECIFIED FROM ARGUMENT
RUN adduser $USER
RUN adduser $USER users
WORKDIR $HOME
USER $USER

# CHECKOUT THE DOTFILES REPO AND SUBMODULES
ENV cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
RUN git clone --depth 1 --bare https://gitlab.eecs.umich.edu/joebb/dotfiles/ $HOME/.cfg
RUN git clone --depth 1 https://gitlab.eecs.umich.edu/joebb/sandbox $HOME/sandbox
RUN $cfg checkout -f
RUN $cfg submodule update --init 

# PIP IS FUCKED ON UBUNTU SO JUST USE THE SCRIPT THEY GIVE ONLINE
USER root
RUN python $HOME/.tools/get-pip.py 
RUN python3 $HOME/.tools/get-pip.py 
RUN python -m pip install flake8 pylint jedi pydocstyle yapf autopep8
RUN python3 -m pip install flake8 pylint jedi pydocstyle yapf autopep8

USER $USER
RUN vim +PlugInstall +qall
RUN /bin/bash -c "source .bashrc"
ENV SHELL="/bin/bash"
