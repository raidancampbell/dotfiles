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

# this is only intended to be run once per OS instance, it's a collection of OS default changes
# thanks https://macos-defaults.com/#%F0%9F%92%BB-list-of-commands
function set_defaults() {
# don't warn on file extension changes
  defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "true"
# show file extensions
  defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
# spaces should not reorder themselves based on most recently used
  defaults write com.apple.dock "mru-spaces" -bool "false"
# show the full directory path at the bottom of the current Finder window
  defaults write com.apple.finder "ShowPathbar" -bool "true"
# Finder should show  contents in list view (as opposed to icons, column, or gallery)
  defaults write com.apple.Finder "FXPreferredViewStyle" -String "Nlsv"
# don't pollute network mounts with .DS_Store files
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool "true"
# don't pollute USB mounts with .DS_Store files
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool "true"
  killall Finder
  killall Dock
}