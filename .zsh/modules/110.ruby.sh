if [ -z "$(command -v ruby)" ] ; then
    return
fi

if [ -z "$(command -v rbenv)" ] ; then
    eval "$(rbenv init -)"
fi
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting
