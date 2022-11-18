if [ -z "$(command -v minikube)" ]; then
  return
fi

alias mk=minikube

# if the current shell is zsh, then source the zsh autocompletions
if [ -n "$(echo $ZSH_NAME)" ]; then
  # cache zsh autocompletions for 7 days: it's slow and doesn't change often anyways
  # thanks, https://pickard.cc/posts/why-does-zsh-start-slowly/
  local cache_loc=~/.zsh/modules/assets/minikube_completion_zsh.zsh
  if [[ -f "$cache_loc" ]] && ! [[ $(find "$cache_loc" -mtime +7 -print) ]]; then
  else
    minikube completion zsh > "$cache_loc"
  fi
  source "$cache_loc"
  compdef __start_minikube mk
fi