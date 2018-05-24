#!/bin/sh

if [ ! `which zsh` ]; then
    sudo apt install zsh && chsh -s `which zsh`
fi

if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^\(README.md\|zshrc\)\(.N\); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
fi
