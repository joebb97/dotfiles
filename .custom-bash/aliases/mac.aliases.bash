if [[ $(uname) == "Darwin" ]]; then
    BREW_VIM_PATH="/usr/local/Cellar/vim"
    alias ls='ls -G'
    alias make=/usr/local/bin/gmake
    if [[ -d $BREW_VIM_PATH ]]
    then
        VIM_VER=$(ls $BREW_VIM_PATH)
        alias vim=${BREW_VIM_PATH}/${VIM_VER}/bin/vim
    fi
    alias swipl="/Applications/SWI-Prolog.app/Contents/MacOS/swipl"
fi
