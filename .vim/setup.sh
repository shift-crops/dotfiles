#!/bin/bash

cd $(dirname $0)
VDOTDIR="$HOME/.vim"
[[ ! -d "$VDOTDIR" ]] && mkdir -p "$VDOTDIR"

if [ ! $(which vim) ]; then
	sudo apt install vim-gtk3
fi

for FILE in vimrc*; do
    [[ ! -s "$VDOTDIR/$FILE" ]] && ln -is "$PWD/$FILE" "$VDOTDIR/$FILE"
done

if [ ! -d "$VDOTDIR/dein" ]; then
	mkdir -p "$VDOTDIR/dein"

	wget https://raw.githubusercontent.com/Shougo/dein-installer.vim/main/installer.sh
	sh installer.sh "$VDOTDIR/dein"
	rm installer.sh
fi

[[ ! -d "$VDOTDIR/undo" ]] && mkdir -p "$VDOTDIR/undo"
