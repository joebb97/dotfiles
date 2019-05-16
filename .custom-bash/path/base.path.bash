if [[ -f $HOME/.cargo/bin ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if [[ -d $HOME/.local/ ]]; then
    export PATH="$HOME/.local/bin:$HOME/.local/share:$PATH"
fi
