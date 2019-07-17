function push_changes {
    if [[ $# -ne 1 ]] &&  [[ $# -ne 2 ]]; then
        echo "Error: usage push_changes <box_name> [--test]"
        return 1
    fi
    local testing=false
    if [[ ! -z $2 ]]; then
        testing=true
    fi
    for item in $(git diff --name-only)
    do
        local bname=$(basename $item)
        local ext="${bname##*.}"
        local no_ext="${bname%.*}"
        if [[ ${ext} == 'less' ]]; then
            bname="${no_ext}.css"
            echo "Found .less file, needs building, copying ${bname}"
        fi
        local file=$(ssh -F /dev/null root@$1 find /base/pkg -iname $bname)
        local num_files=$(echo ${file} | wc -w)
        if [[ ${num_files} -ne 1 ]]; then
            echo "Found duplicate files with name ${bname} skipping ..."
            continue
        fi
        local cmd="scp ${item} root@$1:${file}"
        if ${testing}; then
            echo "Would run: $cmd"
        else
            $cmd
        fi
    done
    return 0
}

function find_remote {
    if [[ $# -ne 2 ]]; then
        echo "Error: usage find_remote <box_name>"
        return 1
    fi
    local file=$(ssh -F /dev/null root@$1 find /base/pkg/ -wholename $2)
    echo ${file}
}

function do_remote {
    if [[ $# -ne 2 ]]; then
        echo "Error: usage find_remote <box_name>"
        return 1
    fi
    local cmd="ssh -F /dev/null root@$1 $2"
    ${cmd}
}

function tuba_sync {
    if [[ $# -ne 1 ]]; then
        echo "Error: usage tuba_sync <box_name>"
        return 1
    fi
    local src_path="${HOME}/Dev/arbor/packages/tuba/"
    local dst_path="root@$1:/base/data/Dev/arbor/packages/tuba/"
    rsync -e 'ssh -F /dev/null' -avh ${src_path} ${dst_path}
}
