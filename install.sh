# thanks, https://github.com/brenns10/dotfiles/blob/master/setup
LINKS=(
  .config/mc
  .config/nano
  .irssi
  .zsh
  .bashrc
  .nanorc
  .profile
  .screenrc
  .tmux.conf
  .vimrc
  .zprofile
  .zshrc
)

create_symlink() {
  # directory removal isn't automated.
  # tough, I've been bitten too many times.
  rm -f "$HOME/$1"
  mkdir -p "$(dirname "$HOME/$1")"
  ln -s "$(pwd)/$1" "$HOME/$1"
}

# if the file/directory exists, back it up
# imperfect (e.g. `.config/mc` is backed up to `.backup/mc`).
# whatever, close enough.
backup() {
  if [ -f "$1" ] || [ -d "$1" ]; then
    cp -a "$1" "${HOME}/.backup/"
  fi
}

git submodule init
git submodule update
mkdir -p "${HOME}/.backup"

for item in "${LINKS[@]}"
do
  backup "$item"
  create_symlink "$item"
done
