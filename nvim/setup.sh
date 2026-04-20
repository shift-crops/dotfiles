#!/bin/bash

cd $(dirname $0)
XDG_CONFIG_NVIM="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
XDG_DATA_NVIM="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
[[ ! -d "$XDG_CONFIG_NVIM" ]] && mkdir -p "$XDG_CONFIG_NVIM"
[[ ! -d "$XDG_DATA_NVIM" ]] && mkdir -p "$XDG_DATA_NVIM"

if [ ! $(which nvim) ]; then
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt install neovim
fi

for FILE in {init.lua,nvimrc,lua}; do
    [[ ! -s "$XDG_CONFIG_NVIM/$FILE" ]] && ln -is "$PWD/$FILE" "$XDG_CONFIG_NVIM/$FILE"
done

[[ ! -d "$XDG_DATA_NVIM/undo" ]] && mkdir -p "$XDG_DATA_NVIM/undo"
