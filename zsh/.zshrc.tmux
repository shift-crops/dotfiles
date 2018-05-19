select_session() {
        # get the IDs
        sessions="`tmux list-sessions 2>/dev/null`"
        if [[ -n $sessions ]]; then
                sessions="${sessions}\n"
        fi

        create_new_session="Create New Session"
        default="Default"
        ID="${sessions}${create_new_session}\n${default}"
        ID="`echo $ID | fzf | cut -d: -f1`"

        if [[ $ID = ${default} ]]; then
                :
        elif [[ $ID = ${create_new_session} ]]; then
                tmux new-session && exit
        elif [[ -n $ID ]]; then
                tmux attach-session -t $ID && exit
        else
                :
        fi
}

if [[ -x `which fzf` && ! -n $TMUX ]]; then
	select_session
fi
