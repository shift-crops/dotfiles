#!/bin/sh

if [ ! `which tmux` ]; then
    sudo apt install tmux
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
