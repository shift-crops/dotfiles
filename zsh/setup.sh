#!/bin/bash

cd $(dirname $0)

ZDOTDIR="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"
[[ ! -d "$ZDOTDIR" ]] && mkdir -p "$ZDOTDIR"

if [ ! $(which zsh) ]; then
	sudo apt install zsh && chsh -s $(which zsh)
fi

for FILE in zshrc*; do
    [[ ! -s "$ZDOTDIR/.$FILE" ]] && ln -is "$PWD/$FILE" "$ZDOTDIR/.$FILE"
done

if [ ! -d "$ZDOTDIR/.zprezto" ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "$ZDOTDIR/.zprezto"

    for rcfile in $(find "$ZDOTDIR/.zprezto/runcoms/" -type f | grep -v -e README -e zshrc); do
        ln -is "$rcfile" "$ZDOTDIR/.$(basename $rcfile)"
    done
fi
