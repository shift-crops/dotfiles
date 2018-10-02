setopt histignorealldups sharehistory
setopt IGNOREEOF

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
fi

# Set up the prompt
[ -s ~/.powerline.zsh ] && source ~/.powerline.zsh
[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ] &&  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
autoload -Uz promptinit
promptinit
prompt powerline

# vi mode
bindkey -v
bindkey -M viins '^j' vi-cmd-mode
bindkey -M vicmd -r '^j'
function zle-line-init zle-keymap-select {
	if [ -n "$TMUX" ]; then
		VIM_NORMAL="#{?client_prefix,#[bg=colour31],#[bg=red]}#[fg=colour255,bold] NORMAL "
		VIM_NORMAL+="#{?client_prefix,#[fg=colour31],#[nobold]#[fg=red]}#[bg=colour232]"
		VIM_INSERT="#{?client_prefix,#[fg=colour255]#[bg=colour31],#[fg=colour232]#[bg=colour255]}#[bold] INSERT "
		VIM_INSERT+="#{?client_prefix,#[fg=colour31],#[nobold]#[fg=colour255]}#[bg=colour232]"
		VIM_MODE="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"

		tmux set-option status-left "$VIM_MODE#[default] "
	fi
}
zle -N zle-line-init
zle -N zle-keymap-select

function zle-line-finish {
	if [ -n "$TMUX" ]; then
		STATUS="#{?client_prefix,#[fg=colour255]#[bg=colour31],#[fg=colour232]#[bg=colour255]}#[bold] #S "
		STATUS+="#{?client_prefix,#[fg=colour31],#[nobold]#[fg=colour255]}#[bg=colour232]"

		tmux set-option status-left "$STATUS#[default] "
	fi
}
zle -N zle-line-finish

[ -s ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s ~/.zshrc.tmux ] && source ~/.zshrc.tmux
[ -s ~/.zshrc.local ] && source ~/.zshrc.local
