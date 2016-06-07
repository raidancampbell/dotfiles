if [[ $- != *i* ]] ; then
        # Shell is non-interactive.  Be done now!
        return
fi

# figure out which operating system we're on
source ~/.zsh/os_definitions

# Thanks, El Capitan for weird permissions.
[[ $OPERATING_SYSTEM == $OSX ]] && export PATH=/usr/local/bin:$PATH

source ~/.zsh/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle colored-man-pages
antigen bundle colorize
[[ $OPERATING_SYSTEM == $OSX ]] && antigen bundle brew
antigen bundle compleat
antigen theme bira
export LANG=en_US.UTF-8		# the bira theme's $PS1 causes issues solved by setting this.
antigen apply

# source me some functions
source ~/.zsh/functions.zsh

# source the personal aliases, containing hostnames and whatnot, only if it exists
if [[ -f ~/.zsh/personal.zsh ]]; then
        source ~/.zsh/personal.zsh
else
fi

# thanks https://github.com/solnic/dotfiles/blob/master/home/zsh/key-bindings.zsh
bindkey -e
bindkey '^[[1;9D' backward-word # iterm
bindkey '^[^[[D' backward-word # tmux os x
bindkey '^[[1;3D' backward-word # tmux ubuntu
bindkey '^[^H' delete-word
bindkey '^[[1;9C' forward-word # iterm
bindkey '^[^[[C' forward-word # tmux os x
bindkey '^[[1;3C' forward-word # tmux ubuntu
bindkey '^H' delete-word # iterm
bindkey '^[[3~' delete-char # tmux

# centralized history for multiple instances
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt sharehistory extendedhistory

# instead of "'x' is a directory", it now cd's to 'x'
setopt auto_cd auto_pushd
setopt NO_BEEP #gotta be nice to the people who host the box remotely
setopt menu_complete

# what's this command doing if it takes > 10 seconds?
REPORTTIME=10

# variables and plugins
export VISUAL='nano' # I transcend the vim/emacs war.
export EDITOR=$VISUAL

# aliases
source ~/.zsh/aliases

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' '' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle :compinstall filename '/Users/aidan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
