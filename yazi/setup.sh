#!/bin/bash

cd $(dirname $0)
XDG_CONFIG_YAZI="${XDG_CONFIG_HOME:-$HOME/.config}/yazi"
[[ ! -d "$XDG_CONFIG_YAZI" ]] && mkdir -p "$XDG_CONFIG_YAZI"

if [ ! $(which rustup) ]; then
    sudo apt install rustup
    rustup default stable
    rustup update
fi

if [ ! $(which yazi) ]; then
    cargo install --locked yazi-fm yazi-cli
fi

# if [ ! $(which snap) ]; then
# 	sudo apt install snapd
# fi
# 
# if [ ! $(which yazi) ]; then
# 	sudo snap install yazi --classic
# 	sudo ln -s /snap/yazi/current/ya /snap/ya
# fi

for FILE in *.toml; do
    [[ ! -s "$XDG_CONFIG_YAZI/$FILE" ]] && ln -is "$PWD/$FILE" "$XDG_CONFIG_YAZI/$FILE"
done

ya pkg add tkapias/nightfly

if [ ! $(which zoxide) ]; then
	sudo apt install zoxide
fi
