#!/bin/sh

if [ ! -f "$HOME/.fonts/PowerlineSymbols.otf" ]; then
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -P ~/.fonts
    fc-cache -vf ~/.fonts/
fi

if [ ! -f "$HOME/.config/fontconfig/conf.d/10-powerline-symbols.conf" ]; then
    wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -P ~/.config/fontconfig/conf.d
fi

if [ ! `which powerline` ]; then
	sudo pip install powerline-status

	POWERLINE_ROOT=`pip show powerline-status | grep Location | awk '{print $2}'`
	ln -Fis $POWERLINE_ROOT/powerline/bindings/tmux/powerline.conf ~/.powerline.tmux.conf
	ln -Fis $POWERLINE_ROOT/powerline/bindings/zsh/powerline.zsh ~/.powerline.zsh
	cp -r $POWERLINE_ROOT/powerline/config_files .config/powerline
fi
