# Aliases
alias e="nvim"
alias sbrc='source $HOME/.bashrc'
alias ebrc='vim $HOME/.bashrc'
alias efc="vim $HOME/.config/fish/config.fish"
alias sfc="source $HOME/.config/fish/config.fish"
alias ebhi='vim $HOME/.bash_history'
alias evrc='vim $HOME/.vimrc'
alias egcfg='vim $HOME/.gitconfig'
alias eggig='vim $HOME/.extra/git-files/global-gitignore.txt'
alias ealias='vim $HOME/.custom-bash/aliases/base.aliases.bash'
alias howbig='du -sh'
# CONFIG ALIASES
alias cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfgs='cfg status'
alias cfga='cfg add '
alias cfgall='cfg add -A'
alias cfgcm='cfg commit -m '
alias cfgp='cfg push'
alias cfgl='cfg pull'
alias cfgll='cfg log --graph --pretty=oneline --abbrev-commit'
alias cfgd='cfg diff'
alias sshnc='ssh -F /dev/null'
alias m='make -j5'
alias make='make -j5'
alias ag="ag --pager='less -XFR'"
alias weather="curl wttr.in/ann_arbor"
alias dkc="docker container"
alias tma="tmux attach"
# Aliases
alias gcl='git clone'
alias ga='git add'
alias grm='git rm'
alias gap='git add -p'
alias gall='git add -A'
alias gf='git fetch --all --prune'
alias gft='git fetch --all --prune --tags'
alias gfv='git fetch --all --prune --verbose'
alias gftv='git fetch --all --prune --tags --verbose'
alias gus='git reset HEAD'
alias gpristine='git reset --hard && git clean -dfx'
alias gclean='git clean -fd'
alias gm="git merge"
alias gmv='git mv'
alias g='git'
alias get='git'
alias gs='git status'
alias gss='git status -s'
alias gsu='git submodule update --init --recursive'
alias gl='git pull'
alias gpl='git pull'
alias glum='git pull upstream master'
alias gpr='git pull --rebase'
alias gpp='git pull && git push'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gpd='git push --delete'
alias gpo='git push origin HEAD'
alias gpu='git push --set-upstream'
alias gpuo='git push --set-upstream origin'
alias gpuoc='git push --set-upstream origin (git symbolic-ref --short HEAD)'
alias gpom='git push origin master'
alias gr='git remote'
alias grv='git remote -v'
alias gra='git remote add'
alias grb='git rebase'
alias grm='git rebase master'
alias grmi='git rebase master -i'
alias gd='git diff'
alias gds='git diff --staged'
alias gdt='git difftool'
alias gdv='git diff -w "$argv" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -v -m'
alias gcam="git commit -v -am"
alias gci='git commit --interactive'
alias gcamd='git commit --amend'
alias gb='git branch'
alias gba='git branch -a'
# FROM https://stackoverflow.com/a/58623139/10362396
alias gbc='git for-each-ref --format="%(authorname) %09 %(if)%(HEAD)%(then)*%(else)%(refname:short)%(end) %09 %(creatordate)" refs/remotes/ --sort=authorname DESC'
alias gbt='git branch --track'
alias gbm='git branch -m'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpx='git cherry-pick -x'
alias gco='git checkout'
alias gcom='git checkout master'
alias gcb='git checkout -b'
alias gcob='git checkout -b'
alias gct='git checkout --track'
alias gcpd='git checkout master; git pull; git branch -D'
alias gexport='git archive --format zip --output'
alias gdel='git branch -D'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias ggf="git log --graph --date=short --pretty=format:'%C(auto)%h %Cgreen%an%Creset %Cblue%cd%Creset %C(auto)%d %s'"
alias ggs="gg --stat"
alias gsh="git show"
alias gsl="git shortlog -sn"
alias gwc="git whatchanged"
alias gt="git tag"
alias gta="git tag -a"
alias gtd="git tag -d"
alias gtl="git tag -l"
alias gpatch="git format-patch -1"
# From http://blogs.atlassian.com/2014/10/advanced-git-aliases/
# Show commits since last pull
alias gnew="git log HEAD@{1}..HEAD@{0}"
# Add uncommitted and unstaged changes to the last commit
alias gcaa="git commit -a --amend -C HEAD"
# Rebase with latest remote master
alias gprom="git fetch origin master && git rebase origin/master && git update-ref refs/heads/master origin/master"
alias gpf="git push --force"
alias gpunch="git push --force-with-lease"
alias ggui="git gui"
alias gcsam="git commit -S -am"
# Stash aliases
alias gst="git stash"
alias gstb="git stash branch"
alias gstd="git stash drop"
alias gstl="git stash list"
# Push introduced in git v2.13.2
alias gstpu="git stash push"
alias gstpum="git stash push -m"
# Save deprecated since git v2.16.0
# - aliases now resolve to push
alias gsts="git stash push"
alias gstsm="git stash push -m"
# Alias gstpo added for symmetry with gstpu (push)
# - gstp remains as alias for pop due to long-standing usage
alias gstpo="git stash pop"
alias gstp="git stash pop"
# Switch aliases - Requires git v2.23+
alias gsw="git switch"
alias gswm="git switch master"
alias gswc="git switch --create"
alias gswt="git switch --track"
alias arc="duoconnect -arc -relay phab.duosec.org arc"
alias loaddc='sudo launchctl load /Library/LaunchDaemons/com.duo.connect.tun.plist; launchctl load /Library/LaunchAgents/com.duo.connect.tcp.plist'
alias unloaddc='sudo launchctl unload /Library/LaunchDaemons/com.duo.connect.tun.plist; launchctl unload /Library/LaunchAgents/com.duo.connect.tcp.plist'
alias awk="gawk"
alias dk="docker"
alias d="docker"
alias dkc="docker-compose"
alias l="ls"
alias p="podman"
alias rh="runhaskell"

# Set the path
function add_to_path
    set -l to_add $argv[1]
    set -l override $argv[2]
    if test -d $to_add; or test $override
        if not contains $to_add $PATH
            set -x PATH $to_add $PATH
        end
    end
end

# Set the gopath
function add_to_gopath
    set -l to_add $argv[1]
    if test -d $to_add
        if not contains $to_add $GOPATH
            set -x GOPATH $GOPATH $to_add
        end
    end
end

add_to_path node_modules/.bin override
add_to_path $HOME/.cargo/bin
add_to_path $HOME/.local/share
add_to_path $HOME/.local/bin
add_to_path $HOME/go/bin
add_to_path $HOME/bin
add_to_path $HOME/Library/Python/2.7/bin
add_to_path $HOME/Library/Python/3.7/bin
add_to_path /usr/local/bin
add_to_path /usr/local/share

set -x GOPATH $HOME/go:$HOME/src/sandbox/go
set -x TMPDIR $HOME/src/tmpdir
set -x ELM_HOME $HOME/src/.elm
set -x SSH_AUTH_SOCK $HOME/.ssh/ykpiv-sock

set -gx EDITOR vim
set -gx GIT_EDITOR vim
which nvim > /dev/null && \
    set -gx EDITOR nvim
    set -gx GIT_EDITOR nvim

set -l autojump_path_home $HOME/.autojump/share/autojump/autojump.fish
set -l autojump_path_pack /usr/share/autojump/autojump.fish
set -l autojump_local_share /usr/local/share/autojump/autojump.fish
if test -f $autojump_path_home
    . $autojump_path_home
else if test -f $autojump_path_pack
    . $autojump_path_pack
else if test -f $autojump_local_share
    . $autojump_local_share
end

set -l prompt_help_path $HOME/.config/fish/prompt_help.fish
if test -f $prompt_help_path
    . $prompt_help_path
end
set -l private_path $HOME/.config/fish/private.fish
if test -f $private_path
    . $private_path
end
which zoxide > /dev/null && zoxide init fish | source
which zoxide > /dev/null && alias cd='z'
which fdfind > /dev/null && alias fd='fdfind'
set -x PAGER "less -XFR"
set -x GIT_PAGER "less -XFR"
which bat > /dev/null && \
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'" && \
    set -x PAGER "bat -p"

which delta > /dev/null && set -x GIT_PAGER "delta -s"
