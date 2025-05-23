#!/bin/bash

if [ ! $(which vim) ]; then
	sudo apt install vim-gtk3
fi

if [ ! -d ~/.vim/dein ]; then
	mkdir -p ~/.vim/dein

	wget https://raw.githubusercontent.com/Shougo/dein-installer.vim/main/installer.sh
	sh installer.sh ~/.vim/dein
	rm installer.sh
fi

[[ ! -d ~/.vim/undo ]] && mkdir -p ~/.vim/undo
