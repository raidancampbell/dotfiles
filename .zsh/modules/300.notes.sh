# OPTIONS:
# LOG_DIRECTORY [~/.config/notes]
# LOG_NAME [log]

# macos needs coreutils from homebrew to get a GNU compatible date. this is gdate.

# get the current datetime in ISO-3339 format
# date --rfc-3339=date
function _get_timestamp() {
  if [ -n "$(command -v gdate)" ]; then
    gdate --rfc-3339=seconds
  else
    date --rfc-3339=seconds
  fi
}

function _get_file() {
  local logdir
  if [ -z "${LOG_DIRECTORY}" ]; then
    logdir="$HOME/.config/notes"
  else
    logdir="$LOG_DIRECTORY"
  fi

  if [ ! -d "$logdir" ]; then
    mkdir -p "$logdir"
    chmod 700 "$logdir"
  fi

  local logname
  if [ -z "${LOG_NAME}" ]; then
    logname="log"
  else
    logname="$LOG_NAME"
  fi

  if [ ! -f "$logdir/$logname" ]; then
    touch "$logdir/$logname"
    chmod 600 "$logdir/$logname"
  fi

  echo "$logdir/$logname"
}

# $1 should be the filename to get the edit time of
function _get_edit_time() {
  if [ -n "$(command -v gstat)" ]; then
    gstat -c %Y "$1"
  else
    stat -c %Y "$1"
  fi
}

function log() {
  local dstring
  dstring=$(_get_timestamp)
  local fname
  fname=$(_get_file)

  # make a backup
  cp "$fname" "$fname.bak"

  # copy the file contents into a temporary file
  local tmpfile
  tmpfile=$(mktemp /tmp/notes-script.XXXXXX)
  cat "$fname" >"$tmpfile"

  # timestamp the new file
  echo "$dstring" >>"$tmpfile"

  # record the edit time of the new file
  local initial_ts
  initial_ts=$(_get_edit_time "$tmpfile")

  # open up the new file in the editor.
  # I non-ironically use nano, so this has code for jump-to-end when opening in nano
  if [[ "$EDITOR" -eq "nano" ]]; then
    local file_lines
    file_lines="$(wc -l "$tmpfile"|awk '{print $1;}')"
    ((file_lines=file_lines+1))
    nano +"$file_lines" "$tmpfile"
  else
    $EDITOR "$tmpfile"
  fi

  # if the file was edited, overwrite the notes file
  if [[ $(_get_edit_time "$tmpfile") -gt initial_ts ]]; then
    cat "$tmpfile" >"$fname"
  fi

  # cleanup
  rm "$tmpfile"
}
