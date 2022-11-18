if [[ $- != *i* ]] ; then
        # Shell is non-interactive.
        return
fi

# centralized history for multiplexed shells
setopt share_history extended_history
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=1000000
setopt hist_expire_dups_first hist_ignore_space hist_verify

setopt auto_cd auto_pushd # instead of "'x' is a directory", it now cd's to 'x'
setopt no_beep # gotta be nice to the people who host the box remotely
setopt menu_complete
setopt interactive_comments

# what's this command doing if it takes > 10 seconds?
TIMEFMT="%J  %U user %S system %P cpu %*E total %M KB memory"
REPORTTIME=10

# prep for completions to be loaded in modules
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Here's the bones: source everything in ~/.zsh/modules/
source ~/.zsh/source_modular.sh

# source the personal aliases, containing hostnames and whatnot, only if it exists
[[ -f ~/.zsh/personal.zsh ]] && source ~/.zsh/personal.zsh

# apply the theme
source ~/.zsh/bira.zsh-theme
