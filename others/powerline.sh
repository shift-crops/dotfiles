#!/bin/sh

if [ ! `which powerline` ]; then
	sudo apt install powerline

	POWERLINE_ROOT=/usr/share/powerline/
	ln -Fis $POWERLINE_ROOT/bindings/tmux/powerline.conf ~/.powerline.tmux.conf
	ln -Fis $POWERLINE_ROOT/bindings/zsh/powerline.zsh ~/.powerline.zsh
	cp -r $POWERLINE_ROOT/config_files ~/.config/powerline
fi
