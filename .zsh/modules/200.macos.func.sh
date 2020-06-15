# -------------------------------------------------------------------
# Mac specific functions
# -------------------------------------------------------------------
if [ "$OPERATING_SYSTEM" != "$OSX" ]; then
  return
fi

# view man pages in Preview
pman() {
  ps=$(mktemp -t manpageXXXX).ps
  man -t $@ > "$ps"
  open "$ps" ;
}

# creates an SSH SOCKS proxy through a prespecified server
# this must be edited with your values
function proxyon() {
    _PROXY_USER=user
    _PROXY_SERVER=server
  networksetup -setsocksfirewallproxy "Wi-Fi" localhost 4040
  networksetup -setsocksfirewallproxystate "Wi-Fi" on
  ssh -D 4040 $_PROXY_USER@$_PROXY_SERVER
}

function proxyoff() {
  echo Do not forget to close the SSH session!
  networksetup -setsocksfirewallproxystate "Wi-Fi" off
}