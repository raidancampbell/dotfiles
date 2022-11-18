if [ -z "$(command -v kubectl)" ]; then
  return
fi

alias kc=kubectl

# if the current shell is zsh, then source the zsh autocompletions
if [ -n "$(echo $ZSH_NAME)" ]; then
  # cache zsh autocompletions for 7 days: it's slow and doesn't change often anyways
  # thanks, https://pickard.cc/posts/why-does-zsh-start-slowly/
  local cache_loc
  cache_loc=~/.zsh/modules/assets/kubectl_completion_zsh.zsh
  if [[ -f "$cache_loc" ]] && ! [[ $(find "$cache_loc" -mtime +7 -print) ]]; then
  else
    kubectl completion zsh > "$cache_loc"
  fi
  source "$cache_loc"
  compdef __start_kubectl kc
fi

alias king='kubectl get ingress'
alias watchpo='watch kubectl get po'
alias kcdebug='kubectl run -i --rm --tty $(whoami)-debug --image=alpine --restart=Never -- sh -c "apk --no-cache add curl ; sh" '

# scrapes the raw metrics endpoint
# flattens and ignores multiple containers per pod
# converts resource usage from nanocores and kilobytes of memory into millicores and megabytes
# sorts by most CPU usage
function kcresource() {
    kubectl get --raw /apis/metrics.k8s.io/v1beta1/pods\
     | jq '[.items [] | {podName: .metadata.name, podNamespace: .metadata.namespace, c0CPUMilli: .containers[0].usage.cpu, c0mem: .containers[0].usage.memory}] | [.[] | .c0CPUMilli = (.c0CPUMilli | rtrimstr("n") | tonumber | ./1000000)] | [.[] | .c0MemMB = (.c0mem | rtrimstr("Ki") | tonumber | ./1024)]  | sort_by(.c0CPUMilli) | reverse| del(.[].c0mem)'
}

# see kcresource, but sorted by memory usage instead
function kcresource_memsort() {
    kcresource | jq 'sort_by(.c0MemMB) | reverse'
}

# thanks, https://talkcloudlytome.com/raw-kubernetes-metrics-with-kubectl/
function kc_node_resource() {
  kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes | jq '[.items [] | {nodeName: .metadata.name, nodeCpu: .usage.cpu, nodeMemory: .usage.memory}]'
}

# thanks, https://talkcloudlytome.com/raw-kubernetes-metrics-with-kubectl/
function kc_container_resource() {
  kubectl get --raw /apis/metrics.k8s.io/v1beta1/pods | jq '[.items [] | {podName: .metadata.name, podNamespace: .metadata.namespace, containers: [{name: .containers[].name, cpu: .containers[].usage.cpu, memory: .containers[].usage.memory}]}]'
}

function kc_container_total_millicores() {
  kubectl get --raw /apis/metrics.k8s.io/v1beta1/pods | jq '[.items[].containers[].usage.cpu | rtrimstr("n") | tonumber] | add | . / 1000000'
}

function kc_nodes_total_millicores() {
  kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes | jq '[.items[].usage.cpu | rtrimstr("n") | tonumber] | add | . / 1000000'
}