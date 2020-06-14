if [[ $- != *i* ]] ; then
        # Shell is non-interactive.  Be done now!
        return
fi

source ~/.zsh/os_definitions.sh

if [[ $OPERATING_SYSTEM == $CHROMEOS ]]; then
	export prefix=/usr/local/linuxbrew # wherever you want linuxbrew, but it better be somewhere in /usr/local
	PATH="$prefix/bin:$prefix/sbin:$PATH"
	export HOMEBREW_TEMP=$prefix/tmp
	unset LD_LIBRARY_PATH
fi

# source the personal aliases, containing hostnames and whatnot, only if it exists
if [[ -f ~/.zsh/personal.zsh ]]; then
        source ~/.zsh/personal.zsh
fi

export LANG=en_US.UTF-8

source ~/.zsh/aliases.sh

shopt -s histappend
shopt -s autocd
shopt -s dotglob

# share history between multiplexed terminals
# thanks to http://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
export HISTCONTROL=ignoredups:erasedups  
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
