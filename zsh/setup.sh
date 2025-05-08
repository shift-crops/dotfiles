#!/bin/bash

cd $(dirname $0)

ZDOTDIR="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"
[[ ! -d "$ZDOTDIR" ]] && mkdir -p "$ZDOTDIR"

if [ ! $(which zsh) ]; then
	sudo apt install zsh && chsh -s $(which zsh)
fi

[[ ! -s "$ZDOTDIR/.zshrc" ]] && ln -s "$PWD/zshrc" "$ZDOTDIR/.zshrc"

if [ ! -d "$ZDOTDIR/.zprezto" ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "$ZDOTDIR/.zprezto"

    for rcfile in $(find "$ZDOTDIR/.zprezto/runcoms/" -type f | grep -v -e README -e zshrc); do
        ln -s "$rcfile" "$ZDOTDIR/.$(basename $rcfile)"
    done
fi
