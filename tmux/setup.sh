#!/bin/bash

cd $(dirname $0)
XDG_CONFIG_TMUX="${XDG_CONFIG_HOME:-$HOME/.config}/tmux"
XDG_DATA_TMUX="${XDG_DATA_HOME:-$HOME/.local/share}/tmux"
[[ ! -d "$XDG_CONFIG_TMUX" ]] && mkdir -p "$XDG_CONFIG_TMUX"
[[ ! -d "$XDG_DATA_TMUX" ]] && mkdir -p "$XDG_DATA_TMUX"

if [ ! $(which tmux) ]; then
    sudo apt install tmux
fi

[[ ! -s "$XDG_CONFIG_TMUX/tmux.conf" ]] && ln -s "$PWD/tmux.conf" "$XDG_CONFIG_TMUX/tmux.conf"

if [ ! -d "$XDG_DATA_TMUX/plugins/tpm" ]; then
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$XDG_DATA_TMUX/plugins/tpm"
fi
