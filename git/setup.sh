#!/bin/bash

cd $(dirname $0)

XDG_CONFIG_GIT="${XDG_CONFIG_HOME:-$HOME/.config}/git"
[[ ! -d "$XDG_CONFIG_GIT" ]] && mkdir -p "$XDG_CONFIG_GIT"

if [ ! $(which git) ]; then
    sudo apt install git
fi

[[ ! -s "$XDG_CONFIG_GIT/config" ]] && ln -is "$PWD/gitconfig" "$XDG_CONFIG_GIT/config"

XDG_CONFIG_LG="${XDG_CONFIG_HOME:-$HOME/.config}/lazygit"
XDG_DATA_LG="${XDG_DATA_HOME:-$HOME/.local/share}/lazygit"
[[ ! -d "$XDG_CONFIG_LG" ]] && mkdir -p "$XDG_CONFIG_LG"

if [ ! $(which lazygit) ]; then
    # sudo apt install lazygit

    if [ ! $(which go) ]; then
        sudo apt install golang
    fi
    git clone --depth 1 https://github.com/jesseduffield/lazygit.git $XDG_DATA_LG
    cp "$PWD/lazygit/pin.patch" "$XDG_DATA_LG/pin.patch"
    (cd $XDG_DATA_LG && \
    git apply pin.patch && \
    go build)
    [[ ! -d "$HOME/.local/bin" ]] && mkdir -p "$HOME/.local/bin"
    ln -is "$XDG_DATA_LG/lazygit" "$HOME/.local/bin/lazygit"
fi

[[ ! -s "$XDG_CONFIG_LG/config.yml" ]] && ln -is "$PWD/lazygit/config.yml" "$XDG_CONFIG_LG/config.yml"

if [ ! $(which delta) ]; then
    if [ ! $(which curl) ]; then
        sudo apt install curl
    fi
    DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
    curl -L "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb" -o /tmp/git-delta.deb
    sudo dpkg -i /tmp/git-delta.deb && rm /tmp/git-delta.deb
fi

