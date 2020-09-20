if [ -z "$(command -v kubectl)" ]; then
  return
fi

alias kc=kubectl

if [ -n "$(echo $ZSH_NAME)" ]; then
  source <(kubectl completion zsh)
  complete -F __start_kubectl kc
fi
