# Window title
case $TERM in
  screen|screen-bce|screen-256color|screen-256color-bce)
    PROMPT_COMMAND='echo -ne "\033k\033\0134\033k${HOSTNAME%%.*}:${PWD/$HOME/~}\033\0134"'
    ;;
  xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    ;;
esac

# Prompt
if [[ "${USER}" == 'root' ]]; then
  PS1='[\u@\H \W]> '
else
  PS1='\[\033[0;32m\]\H\[\033[00m\]:\w> '
fi

export PS1 PROMPT_COMMAND
