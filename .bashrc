# EXPORT SETTINGS
export BASH_IT="$HOME/.bash_it"
export BASH_IT_THEME='bakke'
export BASH_IT_CUSTOM="$HOME/.custom-bash"
export SCM_CHECK=true
export SCM_GIT="\git"
export TERM=screen-256color
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTIGNORE="ls:rm:history:cd:hgrep"
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# SOURCE NECESSARY SCRIPTS
source "$BASH_IT"/bash_it.sh
# CHECK IF AUTOJUMP IS INSTALLED
if [[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]]; then
    source $HOME/.autojump/etc/profile.d/autojump.sh
fi

# AUTOJUMP WAS INSTALLED VIA PACKAGE MANAGER
if [[ -s /usr/share/autojump/autojump.bash ]]; then
    source /usr/share/autojump/autojump.bash  
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
