# Enable ls colors, largely taken from https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/theme-and-appearance.zsh
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# if we're in zsh, then autoload
if [ -n "$(echo $ZSH_NAME)" ]; then
  autoload -U colors && colors
fi


if [[ "$OSTYPE" == darwin* || "$OSTYPE" == freebsd* ]]; then
  # this is a good alias, it works by default just using $LSCOLORS
  ls -G . &>/dev/null && alias ls='ls -G'

  # only use coreutils ls if there is a dircolors customization present ($LS_COLORS or .dircolors file)
  # otherwise, gls will use the default color scheme which is ugly af
  [[ -n "$LS_COLORS" || -f "$HOME/.dircolors" ]] && gls --color -d . &>/dev/null && alias ls='gls --color=tty'
else
  # For GNU ls, we use the default ls color theme. They can later be overwritten by themes.
  if [[ -z "$LS_COLORS" ]]; then
    if [ -z "$(command -v dircolors)" ]; then
      eval "$(dircolors -b)"
    fi
  fi

  if ls --color -d . &>/dev/null ; then
    alias ls='ls --color=tty'
  else
    ls -G . &>/dev/null && alias ls='ls -G'
  fi

  if [ -n "$(echo $ZSH_NAME)" ]; then
    # Take advantage of $LS_COLORS for completion as well.
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
  fi
fi

# enable diff color if possible.
if command diff --color . . &>/dev/null; then
  alias diff='diff --color'
fi