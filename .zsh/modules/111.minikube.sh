if [ -z "$(command -v minikube)" ]; then
  return
fi

alias mk=minikube
if [ -n "$(echo $ZSH_NAME)" ]; then
  source <(minikube completion zsh)
  compdef __start_minikube mk
fi
