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

  local ENV_COLOR
  ENV_COLOR='\033[1;33m'
  case "$(hostname)" in
    *.production.* )
      ENV_COLOR='\033[30m\033[41m'
      ;;
    *.backend.* )
      ENV_COLOR='\033[0;31m'
      ;;
    *.dev.* )
      ENV_COLOR='\033[0;32m'
      ;;
  esac


  if [[ "${USER}" == 'root' ]]; then
    PS1="${TITLEBAR}\[\033[0;31m\]\u@\H\[\033[00m\]:\w> "
  else
    PS1="${TITLEBAR}${ENV_COLOR}\H\[\033[00m\]:\w> "
  fi

  # export PS1
}

PROMPT_COMMAND=render_prompt
