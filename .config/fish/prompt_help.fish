# function _git_branch_name
#     echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
# end

# function _is_git_dirty
#     echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
# end

## Function to show a segment
function _prompt_segment -d "Function to show a segment"
    # Get colors
    set -l bg $argv[1]
    set -l fg $argv[2]

    # Set 'em
    set_color -b $bg
    set_color $fg

    # Print text
    if [ -n "$argv[3]" ]
        echo -n -s $argv[3]
    end

    # Reset
    set_color -b normal
    set_color normal

    # Print padding
    if [ (count $argv) = 4 ]
        echo -n -s $argv[4]
    end
end

function show_ssh_status -d "Function to show the ssh tag"
    if [ -n "$SSH_CLIENT" ]
        if [ (id -u) = "0" ]
        _prompt_segment red white "-SSH-" ' '
        else
        _prompt_segment blue white "-SSH-" ' '
        end
    end
end

function show_host -d "Show host & user name"
  # Display [user & host] info
  if [ (id -u) = "0" ]
    echo -n (set_color red)
  else
    echo -n (set_color blue)
  end
  echo -n ''$USER@(hostname|cut -d . -f 1)' ' (set color normal)
end

# function show_cwd -d "Function to show the current working directory"
#   if test "$theme_short_path" != 'yes' -a (prompt_pwd) != '~' -a (prompt_pwd) != '/'
#     set -l cwd (dirname (prompt_pwd))
#     test $cwd != '/'; and set cwd $cwd'/'
#     _prompt_segment normal cyan $cwd
#   end
#   set_color -o cyan
#   echo -n (basename (prompt_pwd))' '
#   set_color normal
# end

# function show_git_info -d "Show git branch and dirty state"
#   if [ (_git_branch_name) ]
#     set -l git_branch '['(_git_branch_name)']'

#     set_color -o
#     if [ (_is_git_dirty) ]
#       set_color -o red
#       echo -ne "$git_branch× "
#     else
#       set_color -o green
#       echo -ne "$git_branch "
#     end
#     set_color normal
#   end
# end

# function show_prompt_char -d "Terminate with a nice prompt char"
#   set -q THEME_EDEN_PROMPT_CHAR
#     or set -U THEME_EDEN_PROMPT_CHAR '»'
#   echo -n -s $normal $THEME_EDEN_PROMPT_CHAR ' '
# end

# # Eden prompt
# function fish_prompt
#   set fish_greeting

#   # The newline before prompts
#   # echo ''

#   show_ssh_status
#   # show_host
#   show_cwd
#   show_git_info
#   show_prompt_char
# end

# Based off of default prompt
function fish_prompt --description 'Write out the prompt'
    set -l fish_color_cwd cyan
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l prompt_status ""

    # set -q fish_prompt_pwd_dir_length
    # or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    # set -l suffix '❯'
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color " [" $last_status "]" $normal
    end

    show_ssh_status
    if set -q __prompt_show_host
        show_host
    end
    echo -s $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal $prompt_status $status_color $suffix ' ' $normal
end
