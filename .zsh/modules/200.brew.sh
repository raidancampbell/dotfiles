if [ -z "$(command -v brew)" ] ; then
    return
fi

# only autorun brew update once a day
export HOMEBREW_AUTO_UPDATE_SECS=86400
