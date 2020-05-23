function hgrep {
    NUM=10
    if [ $# -eq 2 ]; then
        NUM=$2
    fi
    history | grep -v 'history' | grep $1 | head -n $NUM
}

function noman {
    $1 --help | less
}

function cdl {
    cd $1; l
}

function jl {
    j $@; l
}
