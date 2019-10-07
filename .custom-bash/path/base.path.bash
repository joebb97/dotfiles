# --- SYSTEM PATH ---

function append_path {
    if [[ -d $1 ]]; then
        export PATH=${PATH}:$1
    fi
}

function prepend_path {
    if [[ -d $1 ]]; then
        export PATH=$1:${PATH}
    fi
}

function set_path {
    if [[ -d $1 ]]; then
        export PATH=$1
    fi
}

prepend_path ${HOME}/.cargo/bin
prepend_path ${HOME}/.local/share
prepend_path ${HOME}/.local/bin


# --- GOPATH ---
function set_gopath {
    if [[ -d $1 ]]; then
        export GOPATH=$1
    fi
}


function append_gopath {
    local appended=${PWD}
    if [ $# -eq 1 ]; then
        appended=$1
    fi
    if [[ -d ${appended} ]]; then
        export GOPATH="${GOPATH}:${appended}"
    fi
}
set_gopath ${HOME}/go
append_gopath ${HOME}/Dev/sandbox/go
append_gopath ${HOME}/Dev/eecs491/project1
append_gopath ${HOME}/Dev/eecs491/project2
