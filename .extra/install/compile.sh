#!/bin/sh
set -eu

_to_install=$1
if [ -f "$_to_install" ]; then
    echo "Invoke this script on a directory (you invoked on a file)"
elif [ -d "$_to_install" ]; then
    cd "$_to_install" || exit
    if [ "$(basename "$_to_install")" = "vim" ]; then
        echo "It's vim!"
        _configure_cmd="./configure --with-features=huge
                                    --enable-pythoninterp
                                    --enable-python3interp
                                    --enable-multibyte
                                    --enable-terminal | tee /tmp/log.txt"
        apt install -y gcc make python3-dev libncurses-dev
        $_configure_cmd
        sudo make -j 8
        sudo make install
    elif [ "$(basename "$_to_install")" = "autojump" ]; then
        echo "It's autojump!"
        ./install.py
    else
        apt install -y autotools-dev autoconf automake pkg-config
        if [ -f "autogen.sh" ]; then
            ./autogen.sh
        fi
        ./configure
        make -j 8
        make -j 8 install
    fi
else
    echo "Not anything we can install, whoops"
fi
