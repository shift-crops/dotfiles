#!/bin/sh

for DIR in *
do
    if [ ! -d $DIR ]; then
	    continue
    fi

    [ -f $DIR/setup.sh ] && $DIR/setup.sh
    for FILE in $DIR/.??*
    do
        ln -Fis "$PWD/$FILE" $HOME
    done
done
