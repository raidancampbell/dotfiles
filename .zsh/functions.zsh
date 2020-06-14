# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		PAGER="${commands[less]:-$PAGER}" \
		_NROFF_U=1 \
		PATH="$HOME/bin:$PATH" \
			man "$@"
}

# -------------------------------------------------------------------
# compressed file expander 
# (from https://github.com/myfreeweb/zshuery/blob/master/zshuery.sh)
# -------------------------------------------------------------------
ex() {
    if [[ -f $1 ]]; then
        case $1 in
          *.tar.bz2) tar xvjf $1;;
          *.tar.gz) tar xvzf $1;;
          *.tar.xz) tar xvJf $1;;
          *.tar.lzma) tar --lzma xvf $1;;
          *.bz2) bunzip $1;;
          *.rar) unrar $1;;
          *.gz) gunzip $1;;
          *.tar) tar xvf $1;;
          *.tbz2) tar xvjf $1;;
          *.tgz) tar xvzf $1;;
          *.zip) unzip $1;;
          *.Z) uncompress $1;;
          *.7z) 7z x $1;;
          *.dmg) hdiutul mount $1;; # mount OS X disk images
          *) echo "'$1' cannot be extracted via >ex<";;
    esac
    else
        echo "'$1' is not a valid file"
    fi
}

fix_perl_complaining_about_encoding() {
	if cat /etc/locale.gen | egrep -v "^#" | grep -q "en_US.UTF-8"; then
		echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	else
		echo The fix is already in place.  Rebuilding anyways...
	fi
	locale-gen
}

# -------------------------------------------------------------------
# Mac specific functions
# -------------------------------------------------------------------
if [ "$OPERATING_SYSTEM" = "$OSX" ]; then
    # view man pages in Previewi
    pman() { ps=`mktemp -t manpageXXXX`.ps ; man -t $@ > "$ps" ; open "$ps" ; }

    # fix stubborn UI issues by stabbing it with a fork
    alias fix='killall Dock'

    # handy dandy built in serial port reader
    alias serial='screen /dev/cu.usbserial-A402EXEV 115200 -L'

function proxyon() {
    _PROXY_USER=user
    _PROXY_SERVER=server
	networksetup -setsocksfirewallproxy "Wi-Fi" localhost 4040
	networksetup -setsocksfirewallproxystate "Wi-Fi" on
	ssh -D 4040 $_PROXY_USER@$_PROXY_SERVER
}

function proxyoff() {
    echo Do not forget to close the SSH session!
	networksetup -setsocksfirewallproxystate "Wi-Fi" off
}


    # OSX-specific PATH updates
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    export PATH="$PATH:/usr/local/sbin" # for iftop
fi


# find in file
fif() {
    if [ ! "$#" -gt 0 ]; then
        echo "Search string required"
        return 1
    fi
    
    rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# find in file, but open in sublime
sfif() {
    /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl $(fif "$@")
}
