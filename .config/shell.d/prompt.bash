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

  # local ENV_COLOR
  # local RESET
  ENV_COLOR="$(tput setaf 3)"
  RESET="$(tput sgr0)"
  case "$(hostname)" in
    *.production.*)
      ENV_COLOR="$(tput setab 1)$(tput setaf 0)"
      ;;
    *.backend.*)
      ENV_COLOR="$(tput setaf 1)"
      ;;
    *.dev.* )
      ENV_COLOR="$(tput setaf 2)"
      ;;
  esac


  if [[ "${USER}" == 'root' ]]; then
    PS1="${TITLEBAR}\[\033[0;31m\]\u@\H\[\033[00m\]:\w> "
  else
    PS1='${TITLEBAR}\[${ENV_COLOR}\]\H\[${RESET}\]:\w> '
  fi

  # export PS1
}

PROMPT_COMMAND=render_prompt