if [ -z "$(command -v terraform)" ]; then
  return
fi

complete -o nospace -C $(which terraform) terraform
