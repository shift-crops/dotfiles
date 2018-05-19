#! /bin/sh

if [ ! -d ~/.vim/dein ]; then
    mkdir -p ~/.vim/dein

    wget https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh
    sh installer.sh ~/.vim/dein
    rm installer.sh
fi

