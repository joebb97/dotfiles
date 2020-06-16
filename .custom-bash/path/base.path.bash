#!/bin/bash
# --- SYSTEM PATH ---

function append_path {
    # Make sure the directory exists and isn't apart of the path
    if [[ -d $1 && :$PATH: != *:"$1":* ]]; then
        export PATH=${PATH}:$1
    fi
}

function prepend_path {
    if [[ -d $1 && :$PATH: != *:"$1":* ]]; then
        export PATH=$1:${PATH}
    fi
}

function set_path {
    if [[ -d $1 && :$PATH: != *:"$1":* ]]; then
        export PATH=$1
    fi
}

function print_path {
    echo "${PATH}" | awk -v RS=: '{print}'
}

prepend_path /usr/local/bin
# If we're logged in as root we don't want an extra leading slash
_home=${HOME}
if [[ ${_home} == "/" ]]; then
    _home=""
fi
prepend_path "${_home}"/.cargo/bin
prepend_path "${_home}"/.local/share
prepend_path "${_home}"/.local/bin
prepend_path "${_home}"/go/bin

# macOS feels the need to put this somewhere else lol
prepend_path "${_home}"/Library/Python/2.7/bin
prepend_path "${_home}"/Library/Python/3.7/bin


# --- GOPATH ---
function set_gopath {
    if [[ -d $1 ]]; then
        export GOPATH=$1
    else
        mkdir "$1"
    fi
}


function append_gopath {
    local appended=${PWD}
    # Support adding current directory by using no argument
    if [ $# -eq 1 ]; then
        appended=$1
    fi
    # Append argument specified
    if [[ -d ${appended} ]]; then
        export GOPATH="${GOPATH}:${appended}"
    fi
}
set_gopath "${_home}"/go
append_gopath "${_home}"/Dev/sandbox/go
append_gopath "${_home}"/Dev/eecs491/project4
