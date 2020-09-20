if [[ $- != *i* ]] ; then
        # Shell is non-interactive.  Be done now!
        return
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

source ~/.zsh/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle compleat
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# theme it. I pulled this from the repo for portability
source ~/.zsh/bira.zsh-theme
export LANG=en_US.UTF-8		# the bira theme's $PS1 causes issues solved by setting this.

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' '' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle :compinstall filename '/Users/aidan/.zshrc'

autoload -Uz compinit && compinit

# everything in ~/.zsh/modules/
source ~/.zsh/source_modular.sh

# source the personal aliases, containing hostnames and whatnot, only if it exists
[[ -f ~/.zsh/personal.zsh ]] && source ~/.zsh/personal.zsh
