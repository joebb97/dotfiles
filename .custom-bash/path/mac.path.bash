if [[ $(uname) == "Darwin" ]]; then
    # SOURCE THINGS AND ADD TO PATH
    if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
        # shellcheck source=/dev/null
        source "$(brew --prefix)"/etc/bash_completion
    fi

    if [[ -d $HOME/Library/Python/ ]]
    then
        export PATH="$HOME/Library/Python/2.7/bin:$PATH"
        export PATH="$HOME/Library/Python/3.7/bin:$PATH"
    fi
fi
