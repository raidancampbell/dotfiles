OSX="Darwin"
LINUX="Linux"
UNIX="FreeBSD"

OPERATING_SYSTEM="$(uname)"

if [ "$OPERATING_SYSTEM" != $OSX ] && [ "$OPERATING_SYSTEM" != $LINUX ] && [ "$OPERATING_SYSTEM" != $UNIX ]; then
        echo WARNING! Unknown uname "$OPERATING_SYSTEM"
fi
