#!/bin/bash

cd $(dirname $0)
XDG_CONFIG_NVIM="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
XDG_DATA_NVIM="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
[[ ! -d "$XDG_CONFIG_NVIM" ]] && mkdir -p "$XDG_CONFIG_NVIM"
[[ ! -d "$XDG_DATA_NVIM" ]] && mkdir -p "$XDG_DATA_NVIM"

if [ ! $(which nvim) ]; then
	wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage -O "$XDG_DATA_NVIM/nvim-linux-x86_64.appimage"
	chmod +x "$XDG_DATA_NVIM/nvim-linux-x86_64.appimage"
	ln -s "$XDG_DATA_NVIM/nvim-linux-x86_64.appimage" "$HOME/.local/bin/nvim"
fi

for FILE in {init.lua,nvimrc,lua}; do
    [[ ! -s "$XDG_CONFIG_NVIM/$FILE" ]] && ln -is "$PWD/$FILE" "$XDG_CONFIG_NVIM/$FILE"
done

[[ ! -d "$XDG_DATA_NVIM/undo" ]] && mkdir -p "$XDG_DATA_NVIM/undo"
