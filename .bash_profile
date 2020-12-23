if [[ -f $HOME/.bashrc ]]; then
    source $HOME/.bashrc
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Joey/.tools/google-cloud-sdk/path.bash.inc' ]; then . '/Users/Joey/.tools/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/Joey/.tools/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/Joey/.tools/google-cloud-sdk/completion.bash.inc'; fi
