# if fzf isn't installed, skip it.
# there's potential to auto-install
if [ -z "$(command -v fzf)" ] ; then
    return
fi

export FZF_DEFAULT_OPTS="--height=50% --min-height=15 --reverse"

# find in file
fif() {
    if [ ! "$#" -gt 0 ]; then
        echo "Search string required"
        return 1
    fi

    rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}


if [[ -f /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ]]; then
    # find in file, but open in sublime
    sfif() {
        /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl $(fif "$@")
    }
fi

