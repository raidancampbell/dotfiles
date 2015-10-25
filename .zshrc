source ~/.zsh/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle autojump		# sourced in functions.zsh for OSX only --you need to both bundle and source it.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle colored-man
antigen bundle colorize
antigen bundle screen
antigen bundle brew		# TODO: only bundle this on darwin systems
antigen bundle compleat
antigen theme bira
export LANG=en_US.UTF-8		# the bira theme's $PS1 causes issues solved by setting this.
antigen apply

# source me some functions
source ~/.zsh/functions.zsh

# source the personal aliases, containing hostnames and whatnot
source ~/.zsh/personal.zsh

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
export VISUAL='nano' #I transcend the vim/emacs war.
export EDITOR=$VISUAL

# aliases
alias mc='mc -x' # use xterm-mode, to allow mouse support even in a tmux session
alias untar='tar xzfv'
alias dkp='cd ~/Desktop'
alias mirror="wget -e robots=off -m -r -np"
alias findwifi='sudo wash -i en0'
alias crackwifi='sudo reaver -i en0 -vv -b'
alias lsa='ls -AlhF'
alias clsa='clear && ls -AlhF'
alias alsa='ls -AlhF' # for all those times I hit enter before finishing the `lsa` alias
alias internet='ping -c 4 www.google.com'
alias used='du -ch -d 1'
alias left='df -h .'
alias q='exit'
alias count='wc -l' #e.g. lsa | count
alias screena='screen -dRR -S aidan'
alias tmuxa='tmux attach -t mainSession || tmux new'
alias c='clear'
alias cl='clear'
alias cls='clear' # ugh, windows habits.

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' '' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle :compinstall filename '/Users/aidan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
