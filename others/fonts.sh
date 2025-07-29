#!/bin/bash

FONTSDIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts"

if [ ! -d "$FONTSDIR/HackNerdFont" ]; then
	mkdir -p "$FONTSDIR/HackNerdFont"
	cd "$FONTSDIR/HackNerdFont"
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip
	unzip Hack.zip
fi

fc-cache -v
