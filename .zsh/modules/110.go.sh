if [ -z "$(command -v go)" ] ; then
    return
fi

export GOPROXY=https://proxy.golang.org
export PATH="$HOME/go/bin:$PATH"
