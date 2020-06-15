if [[ $- != *i* ]] ; then
        # Shell is non-interactive.  Be done now!
        return
fi

# source the personal aliases, containing hostnames and whatnot, only if it exists
if [[ -f ~/.zsh/personal.zsh ]]; then
        source ~/.zsh/personal.zsh
fi

export LANG=en_US.UTF-8

# everything in ~/.zsh/modules/
source ~/.zsh/source_modular.sh

shopt -s histappend
shopt -s autocd
shopt -s dotglob

# share history between multiplexed terminals
# thanks to http://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
export HISTCONTROL=ignoredups:erasedups  
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
