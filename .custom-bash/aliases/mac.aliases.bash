BREW_VIM_PATH="/usr/local/Cellar/vim"
if [[ -d $BREW_VIM_PATH ]]
then
    VIM_VER=$(ls $BREW_VIM_PATH)
    alias vim=${BREW_VIM_PATH}/${VIM_VER}/bin/vim
fi
alias make=/usr/local/bin/make
