if [[ -f $HOME/.bashrc ]]; then
    source $HOME/.bashrc
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Joey/.tools/google-cloud-sdk/path.bash.inc' ]; then . '/Users/Joey/.tools/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/Joey/.tools/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/Joey/.tools/google-cloud-sdk/completion.bash.inc'; fi
source "$HOME/.cargo/env"

source /home/joey/.config/broot/launcher/bash/br

if [ -e /home/joey/.nix-profile/etc/profile.d/nix.sh ]; then . /home/joey/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
