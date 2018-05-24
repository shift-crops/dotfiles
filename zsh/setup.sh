#!/bin/sh

if [ ! `which zsh` ]; then
    sudo apt install zsh && chsh -s `which zsh`
fi
