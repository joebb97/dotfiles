# Aliases
abbr -g e '$EDITOR'
abbr -g sbrc 'source $HOME/.bashrc'
abbr -g ebrc '$EDITOR $HOME/.bashrc'
abbr -g efc '$EDITOR $HOME/.config/fish/config.fish'
abbr -g sfc 'source $HOME/.config/fish/config.fish'
abbr -g ebhi '$EDITOR $HOME/.bash_history'
abbr -g evrc '$EDITOR $HOME/.vimrc'
abbr -g egcfg '$EDITOR $HOME/.gitconfig'
abbr -g eggig '$EDITOR $HOME/.extra/git-files/global-gitignore.txt'
abbr -g ealias '$EDITOR $HOME/.custom-bash/aliases/base.aliases.bash'
abbr -g howbig 'du -sh'
# CONFIG ALIASES
abbr -g cfg 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
abbr -g cfgs "$_fish_abbr_cfg status"
abbr -g cfga "$_fish_abbr_cfg add"
abbr -g cfgall "$_fish_abbr_cfg add -A"
abbr -g cfgcm "$_fish_abbr_cfg commit -m"
abbr -g cfgp "$_fish_abbr_cfg push"
abbr -g cfgl "$_fish_abbr_cfg pull"
abbr -g cfgll "$_fish_abbr_cfg log --graph --pretty=oneline --abbrev-commit"
abbr -g cfgd "$_fish_abbr_cfg diff"
abbr -g sshnc 'ssh -F /dev/null'
abbr -g m 'make -j5'
abbr -g make 'make -j5'
abbr -g ag "ag --pager='less -XFR"
abbr -g weather 'curl wttr.in/ann_arbor'
abbr -g dkc 'docker container'
abbr -g tma 'tmux attach'
# Aliases
abbr -g ga 'git add'
abbr -g gall 'git add -A'
abbr -g g 'git'
abbr -g gs 'git status'
abbr -g gsubu 'git submodule update --init --recursive'
abbr -g gl 'git pull'
abbr -g glr 'git pull --rebase'
abbr -g gr 'git rebase'
abbr -g gm 'git merge'
abbr -g gp 'git push'
abbr -g gd 'git diff'
abbr -g gds 'git diff --staged'
abbr -g gc 'git commit -v'
abbr -g gcm 'git commit -v -m'
abbr -g gb 'git branch'
# FROM https://stackoverflow.com/a/58623139/10362396
abbr -g gbc 'git for-each-ref --format="%(authorname) %09 %(if)%(HEAD)%(then)*%(else)%(refname:short)%(end) %09 %(creatordate)" refs/remotes/ --sort=authorname DESC'
abbr -g gco 'git checkout'
abbr -g gcb 'git checkout -b'
abbr -g gll 'git log --graph --pretty=oneline --abbrev-commit'
abbr -g gg "git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
abbr -g ggf "git log --graph --date=short --pretty=format:'%C(auto)%h %Cgreen%an%Creset %Cblue%cd%Creset %C(auto)%d %s'"
abbr -g ggs "$_fish_abbr_gg --stat"
abbr -g gsh "git show"
abbr -g gwc "git whatchanged"
# alias awk="gawk"
abbr -g dk "docker"
abbr -g dke "docker exec"
abbr -g ca "cargo"
abbr -g car "cargo"
abbr -g dkc "docker compose"
abbr -g l "ls"
abbr -g pm "podman"
abbr -g rh "runhaskell"

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
add_to_path $HOME/.gem/ruby/2.6.0/bin
add_to_path /usr/local/bin
add_to_path /usr/local/sbin
add_to_path /usr/local/share

set -x GOPATH $HOME/go:$HOME/src/sandbox/go
set -x TMPDIR $HOME/src/tmpdir
set -x ELM_HOME $HOME/src/.elm
set -x SSH_AUTH_SOCK $HOME/.ssh/ykpiv-sock

set -gx EDITOR vim
set -gx GIT_EDITOR vim

set -x PAGER "less -XFR"
set -x GIT_PAGER "less -XFR"
set -x HOMEBREW_NO_AUTO_UPDATE 1
set fish_greeting

# Slows things down a bit
# set __fish_git_prompt_show_informative_status

# Slows things A LOT
# set __fish_git_prompt_showuntrackedfiles

# Just right
set __fish_git_prompt_showdirtystate

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

if type -q nvim
    set -gx EDITOR nvim
    set -gx GIT_EDITOR nvim
end

if type -q zoxide
    zoxide init fish | source
    abbr -g cd 'z'
end

if type -q fdfind
    abbr -g fd 'fdfind'
end

if type -q bat
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -x PAGER "bat -p"
end
