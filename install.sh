#!/bin/bash

for DIR in *; do
    if [ ! -d $DIR ]; then
	    continue
    fi

    [ -x $DIR/setup.sh ] && $DIR/setup.sh
    for FILE in $DIR/.??*; do
        [ -f $PWD/$FILE ] && ln -Fis "$PWD/$FILE" $HOME
    done
done

for FILE in others/*.sh; do
    if [ -x $FILE ]; then
        $FILE
    fi
done
