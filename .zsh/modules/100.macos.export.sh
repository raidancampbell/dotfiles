if [ "$OPERATING_SYSTEM" != "$OSX" ]; then
  return
fi

# PATH updates
export PATH="/usr/local/sbin:$PATH" # for iftop
export PATH="/usr/local/bin:$PATH" # for brew-installed packages
export PATH="/usr/local/opt/libpcap/bin:$PATH"
