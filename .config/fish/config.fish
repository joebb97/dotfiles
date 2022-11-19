# Aliases
abbr e 'nvim'
abbr sbrc 'source $HOME/.bashrc'
abbr ebrc '$EDITOR $HOME/.bashrc'
abbr efc '$EDITOR $HOME/.config/fish/config.fish'
abbr sfc 'source $HOME/.config/fish/config.fish'
abbr ebhi '$EDITOR $HOME/.bash_history'
abbr evrc '$EDITOR $HOME/.vimrc'
abbr egcfg '$EDITOR $HOME/.gitconfig'
abbr eggig '$EDITOR $HOME/.extra/git-files/global-gitignore.txt'
abbr ealias '$EDITOR $HOME/.custom-bash/aliases/base.aliases.bash'
abbr howbig 'du -sh'
# CONFIG ALIASES
abbr cfg 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
abbr cfgs "$_fish_abbr_cfg status"
abbr cfga "$_fish_abbr_cfg add"
abbr cfgall "$_fish_abbr_cfg add -A"
abbr cfgcm "$_fish_abbr_cfg commit -m"
abbr cfgp "$_fish_abbr_cfg push"
abbr cfgl "$_fish_abbr_cfg pull"
abbr cfgll "$_fish_abbr_cfg log --graph --pretty=oneline --abbrev-commit"
abbr cfgd "$_fish_abbr_cfg diff"
abbr sshnc 'ssh -F /dev/null'
abbr m 'make -j5'
abbr make 'make -j5'
abbr ag "ag --pager='less -XFR"
abbr weather 'curl wttr.in/ann_arbor'
abbr dkc 'docker container'
abbr tma 'tmux attach'
# Aliases
abbr ga 'git add'
abbr gall 'git add -A'
abbr g 'git'
abbr gs 'git status'
abbr gsubu 'git submodule update --init --recursive'
abbr gl 'git pull'
abbr glr 'git pull --rebase'
abbr gr 'git rebase'
abbr gm 'git merge'
abbr gp 'git push'
abbr gd 'git diff'
abbr gds 'git diff --staged'
abbr gc 'git commit -v'
abbr gcm 'git commit -v -m'
abbr gb 'git branch'
# FROM https://stackoverflow.com/a/58623139/10362396
abbr gbc 'git for-each-ref --format="%(authorname) %09 %(if)%(HEAD)%(then)*%(else)%(refname:short)%(end) %09 %(creatordate)" refs/remotes/ --sort=authorname DESC'
abbr gco 'git checkout'
abbr gcb 'git checkout -b'
abbr gll 'git log --graph --pretty=oneline --abbrev-commit'
abbr gg "git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
abbr ggf "git log --graph --date=short --pretty=format:'%C(auto)%h %Cgreen%an%Creset %Cblue%cd%Creset %C(auto)%d %s'"
abbr ggs "$_fish_abbr_gg --stat"
abbr gsh "git show"
abbr gwc "git whatchanged"
# alias awk="gawk"
abbr dk "docker"
abbr dke "docker exec"
abbr ca "cargo"
abbr car "cargo"
abbr dkc "docker-compose"
abbr l "ls"
abbr pm "podman"
abbr rh "runhaskell"

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

add_to_path /usr/local/opt/scala@2.12/bin
add_to_path node_modules/.bin override
add_to_path $HOME/.cargo/bin
add_to_path $HOME/.local/share
add_to_path $HOME/.local/bin
add_to_path $HOME/go/bin
add_to_path $HOME/bin
add_to_path $HOME/Library/Python/3.7/bin
add_to_path $HOME/Library/Python/3.9/bin
add_to_path $HOME/Library/Python/2.7/bin
add_to_path /usr/local/bin
add_to_path /usr/local/sbin
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

set -l opam_init $HOME/.opam/opam-init/init.fish
if test -f $opam_init
    source $opam_init
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
which zoxide > /dev/null && abbr cd 'z'
which fdfind > /dev/null && abbr fd 'fdfind'
set -x PAGER "less -XFR"
set -x GIT_PAGER "less -XFR"
which bat > /dev/null && \
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'" && \
    set -x PAGER "bat -p"
set -x HOMEBREW_NO_AUTO_UPDATE 1
