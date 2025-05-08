#!/bin/bash

cd $(dirname $0)
XDG_CONFIG_FZF="${XDG_CONFIG_HOME:-$HOME/.config}/fzf"
XDG_DATA_FZF="${XDG_DATA_HOME:-$HOME/.local/share}/fzf"

if [ ! -d "$XDG_DATA_FZF" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$XDG_DATA_FZF"
    "$XDG_DATA_FZF/install" --xdg
    echo "export FZF_DEFAULT_OPTS='--height 40% --reverse --border'" >> "$XDG_CONFIG_FZF/fzf.zsh"
fi
