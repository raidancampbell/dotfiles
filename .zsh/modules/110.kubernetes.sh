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

alias king='kubectl get ingress'
#alias watchpo=''
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