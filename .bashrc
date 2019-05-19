# EXPORT SETTINGS
export BASH_IT="$HOME/.bash_it"
export BASH_IT_THEME='bakke'
export BASH_IT_CUSTOM="$HOME/.custom-bash"
export SCM_CHECK=true
export TERM=screen-256color

# SOURCE NECESSARY SCRIPTS
source "$BASH_IT"/bash_it.sh
# CHECK IF AUTOJUMP IS INSTALLED
if [[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]]; then
    source $HOME/.autojump/etc/profile.d/autojump.sh
fi
