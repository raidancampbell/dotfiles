if [ -z "${ZSH_NAME}" ] || [ -z "$(command -v sqlite3)" ]; then
    return
fi

if [ "$OPERATING_SYSTEM" = "$OSX" ]; then
  HISTDB_TABULATE_CMD=(sed -e $'s/\x1f/\t/g')
fi
HISTDB_FILE="$HOME/.zsh/zsh-history.db"
source ~/.zsh/zsh-histdb/sqlite-history.zsh
autoload -Uz add-zsh-hook

source ~/.zsh/zsh-histdb-fzf/fzf-histdb.zsh
bindkey '^R' histdb-fzf-widget