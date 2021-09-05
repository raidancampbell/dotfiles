if [ -z "$(command -v go)" ] ; then
    return
fi

export GOPROXY=https://proxy.golang.org
export PATH="$HOME/go/bin:$PATH"
# can't use `~` in the GOPATH, so we need to evaluate the value, then export it
_gopath_str="/Users/$(whoami)/go"
export GOPATH=$_gopath_str