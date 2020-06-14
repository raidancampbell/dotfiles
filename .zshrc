if [[ $- != *i* ]] ; then
        # Shell is non-interactive.  Be done now!
        return
fi

# figure out which operating system we're on
source ~/.zsh/os_definitions.sh

# Thanks, El Capitan for weird permissions.
[[ $OPERATING_SYSTEM == $OSX ]] && export PATH=/usr/local/bin:$PATH

source ~/.zsh/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle compleat
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# theme it. I pulled this from the repo for portability
source ~/.zsh/bira.zsh-theme
export LANG=en_US.UTF-8		# the bira theme's $PS1 causes issues solved by setting this.

# source me some functions
source ~/.zsh/functions.zsh

# source the personal aliases, containing hostnames and whatnot, only if it exists
if [[ -f ~/.zsh/personal.zsh ]]; then
        source ~/.zsh/personal.zsh
else
fi

# thanks https://github.com/solnic/dotfiles/blob/master/home/zsh/key-bindings.zsh
# for future reference, to find the control characters received by a terminal emulator:
# printf '\033[?1000h' ; cat -ute
bindkey -e
bindkey "\e\eOD" backward-word # jetbrains
bindkey '^[[1;9D' backward-word # iterm
bindkey '^[^[[D' backward-word # tmux os x
bindkey '^[[1;3D' backward-word # tmux ubuntu
bindkey '^[^H' delete-word
bindkey "\e\eOC" forward-word # jetbrains
bindkey '^[[1;9C' forward-word # iterm
bindkey '^[^[[C' forward-word # tmux os x
bindkey '^[[1;3C' forward-word # tmux ubuntu
bindkey '^H' delete-word # iterm
bindkey '^[[3~' delete-char # tmux

# centralized history for multiple instances
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=1000000
setopt sharehistory extendedhistory

# instead of "'x' is a directory", it now cd's to 'x'
setopt auto_cd auto_pushd
setopt NO_BEEP #gotta be nice to the people who host the box remotely
setopt menu_complete

# what's this command doing if it takes > 10 seconds?
TIMEFMT="%J  %U user %S system %P cpu %*E total, finished $(date)"
REPORTTIME=10

# variables and plugins
export VISUAL='nano' # I transcend the vim/emacs war.
export EDITOR=$VISUAL

FZF_DEFAULT_OPTS="--height=50% --min-height=15 --reverse"

if which direnv >/dev/null 2>&1 ; then
    eval "$(direnv hook zsh)"
fi


# aliases
source ~/.zsh/aliases.sh

export GOPROXY=https://proxy.golang.org 
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$PATH:/Users/aidan/go/bin"
export PATH="/usr/local/opt/libpcap/bin:$PATH"
eval "$(rbenv init -)"

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' '' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle :compinstall filename '/Users/aidan/.zshrc'

autoload -Uz compinit && compinit
