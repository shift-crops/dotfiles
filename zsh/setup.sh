#!/bin/sh

if [ ! `which zsh` ]; then
    sudo apt install zsh && chsh -s `which zsh`
fi

if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

    for rcfile in `find "${ZDOTDIR:-$HOME}/.zprezto/runcoms/" -type f | grep -v -e README -e zshrc`; do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.`basename $rcfile`"
    done
fi
