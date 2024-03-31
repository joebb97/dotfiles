#!/bin/sh
set -eu

_def_prefix="/usr/local"
_to_install=$1
[ $# -eq 2 ] && _prefix=$2 || _prefix="$_def_prefix"
[ "$(id -u)" -eq 0 ] && _isroot=true || _isroot=false
[ "$(basename "$_prefix")" = "bin" ] && echo "Prefix shouldn't end in bin" && exit 1

[ "$_isroot" = false ] && [ "$_prefix" = "$_def_prefix" ] && 
    echo "Need to be root to install to $_def_prefix" && exit 1

[ -f "$_to_install" ] && echo "Invoke this script on a directory (you invoked on a file)" && exit 1
[ ! -d "$_to_install" ]  && echo "Not anything we can install, whoops" && exit 1

cd "$_to_install" || exit
if [ "$(basename "$_to_install")" = "vim" ]; then
    echo "It's vim!"
    _configure_cmd="./configure --with-features=huge
                                --prefix=$_prefix
                                --enable-python3interp
                                --enable-multibyte
                                --enable-terminal"
    [ "$_isroot" = true ] && which apt-get && apt-get install -y gcc make python3-dev libncurses-dev
    $_configure_cmd
    make -j 8
    make -j 8 install
elif [ "$(basename "$_to_install")" = "autojump" ]; then
    echo "It's autojump!"
    ./install.py
else
    [ "$_isroot" = true ] && which apt-get && apt-get install -y autotools-dev autoconf automake pkg-config
    [ -f "autogen.sh" ] && ./autogen.sh
    ./configure --prefix="$_prefix"
    make -j 8
    make -j 8 install
fi
