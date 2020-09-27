if [ -z "$(command -v kubectl)" ]; then
  return
fi

if [ -n "$(echo $ZSH_NAME)" ]; then
  function kc() {
    if ! type __start_kubectl >/dev/null 2>&1; then
      source <(command kubectl completion zsh)
      complete -F __start_kubectl kc
    fi
    kubectl "$@"
  }
else
  alias kc=kubectl
fi
