function render_prompt()
{
  # Window title
    local TITLEBAR
  case $TERM in
    screen|screen-bce|screen-256color|screen-256color-bce)
      TITLEBAR='\033k\033\0134\033k${HOSTNAME%%.*}:${PWD/$HOME/~}\033\0134'
      ;;
    xterm*|rxvt*)
      TITLEBAR='\033]0;${HOSTNAME%%.*}:${PWD/$HOME/~}\007'
      ;;
  esac
  TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'

  if [[ "${USER}" == 'root' ]]; then
    PS1="${TITLEBAR}\[\033[0;31m\]\u@\H\[\033[00m\]:\w> "
  else
    PS1="${TITLEBAR}\[\033[0;32m\]\H\[\033[00m\]:\w> "
  fi

  # export PS1
}

PROMPT_COMMAND=render_prompt
