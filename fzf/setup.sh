#! /bin/sh

if [ ! -d ~/.fzf ]; then
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --bin
fi
