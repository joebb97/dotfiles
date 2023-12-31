#!/bin/bash

# NOTE: This script is not guaranteed to be run sequentially.
# It's meant to document steps of setup. Functions would run in order

### Update the system, package manager might need to change depending on distro
set -eux
system_packages() {
    # If you have sudo
    sudo apt-get update
    sudo apt-get install -y curl man git python3 cmake g++\
        tmux vim ctags fish
    sudo apt-get upgrade -y
}

get_dotfiles() {
    git clone git@github.com:joebb97/dotfiles.git --bare "$HOME/.cfg"
    cfg="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
    $cfg checkout -f
    $cfg submodule update --init
    $cfg config status.showUntrackedFiles no

    cp "$HOME/.ssh/ssh_config" "$HOME/.ssh/config"
}

make_an_ssh_key() {
    ssh-keygen -t ed25519
    # upload key to github.com and gitlab
}

install_neovim() {
    # Following https://github.com/neovim/neovim/wiki/Building-Neovim
    sudo apt-get install ninja-build gettext libtool-bin cmake g++ pkg-config unzip curl
    cd .tools/neovim
    git checkout stable
    make -j8 CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make -j8 install
    # To install to custom location, i.e $HOME/.local/bin
    # make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local"
    # make install
    # Used by mason for some LSPs
    sudo apt-get install -y npm
}

install_rust_and_tools() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    # Pick all defaults except modify PATH variable (you've already done it)
    cargo install -f --git https://github.com/jez/as-tree
    cargo install git-delta
    cargo install ripgrep
    cargo install cargo-watch

    sudo apt-get install -y bat
    # Only needed on Ubuntu since it's installed as batcat
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat

    sudo apt-get install -y zoxide
    # Allow rust-analyzer to get installed by mason
    sudo apt install fd-find
    ln -s "$(which fdfind)" ~/.local/bin/fd

    git clone https://github.com/Canop/broot
    cargo install --locked --path .
}

install_nerd_font(){
    # on macOS
    cd ~/Library/Fonts
    # on Linux
    cd ~/.local/share/fonts
    curl -fLo "Iosevka Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Nerd%20Font%20Complete.ttf
    curl -fLo "Iosevka Nerd Font Complete Bold.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Bold/complete/Iosevka%20Nerd%20Font%20Complete%20Bold.ttf
    curl -fLo "Iosevka Nerd Font Complete Italic.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Italic/complete/Iosevka%20Nerd%20Font%20Complete%20Italic.ttf
    curl -fLo "Iosevka Nerd Font Complete Bold Italic.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Bold-Italic/complete/Iosevka%20Nerd%20Font%20Complete%20Bold%20Italic.ttf
    # curl -fLo "Iosevka Term Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Term%20Nerd%20Font%20Complete.ttf
    # You may or may not want to get the Regular, Bold, Italic, Bold-Italic ones, etc.
}

install_alacritty() {
    # https://github.com/alacritty/alacritty/blob/master/INSTALL.md
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty
    rustup override set stable
    rustup update stable
    # Install alacritty
    sudo apt-get install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

    # check if alacritty already installed
    infocmp alacritty
    # if not present
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

    # or anywhere else in $PATH
    sudo cp target/release/alacritty /usr/local/bin
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database

    # install manpage
    sudo mkdir -p /usr/local/share/man/man1
    gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
    gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null

    # install completions
    mkdir -p $fish_complete_path[1]
    cp extra/completions/alacritty.fish $fish_complete_path[1]/alacritty.fish
}

install_kitty() {
    # Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in
    # your system-wide PATH)
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
    # Place the kitty.desktop file somewhere it can be found by the OS
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    # If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
    cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
    # Update the paths to the kitty and its icon in the kitty.desktop file(s)
    sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
}


install_go_and_tools() {
    wget https://go.dev/dl/go1.20.1.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go1.20.1.linux-amd64.tar.gz
    # add /usr/local/go/bin to PATH
    env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest
    sudo apt install fzf
}

install_lazy_things() {
    cd /tmp
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin

    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

    # install lazydocker
}

install_cht_sh() {
    cd ~/.local/bin
    curl https://cht.sh/:cht.sh  > cht.sh
    chmod +x cht.sh
}

install_tldr() {
    npm i -g tldr
}

install_gh_cli() {
    type -p curl >/dev/null || sudo apt install curl -y
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
}

screen_info() {
    # Dell Precision 5560 Native Panel
    # height: 336.38 mm
    # width: 210.24 mm
    # diagonal: 396.24 mm
    # native res: 3840x2400
    
    # AOC CU34G2X
    # height: 333.72 mm
    # width: 797.184 mm
    # diagonal: 863.6 mm
    # native res: 3440x1440
    echo
}

install_webi() {
    curl -sS "https://webi.sh/" | sh
}

install_k9s() {
    curl -sS "https://webinstall.dev/k9s" | bash
    # or
    webi k9s
}

install_btop() {

}

install_applets() {
    sudo apt install nm-applet redshift-gtk pasystray blueman
}
