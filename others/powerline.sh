#!/bin/sh

if [ ! `which powerline` ]; then
	sudo pip install powerline-status

	if [ ! -d "~/.fonts" ]; then
		mkdir ~/.fonts
	fi
	wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -P ~/.fonts
	fc-cache -vf ~/.fonts/

	if [ ! -d "~/.config/fontconfig/conf.d" ]; then
		mkdir -p ~/.config/fontconfig/conf.d
	fi
	wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -P ~/.config/fontconfig/conf.d/

	POWERLINE_ROOT=`pip show powerline-status | grep Location | awk '{print $2}'`
	ln -Fis $POWERLINE_ROOT/powerline/bindings/tmux/powerline.conf ~/.powerline.tmux.conf
	ln -Fis $POWERLINE_ROOT/powerline/bindings/zsh/powerline.zsh ~/.powerline.zsh
fi
