if [ -z "$(command -v direnv)" ] ; then
    return
fi

# if we're in zsh, then load
if [ -n "$(echo $ZSH_NAME)" ]; then
  eval "$(direnv hook zsh)"
fi

