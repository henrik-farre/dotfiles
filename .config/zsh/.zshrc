#if [[ -o login ]]; then
#  echo "I'm login shell"
#fi

#if [[ -o interactive ]]; then
#  echo "I'm interactive shell"
#fi

if [[ -v WSL_DISTRO_NAME ]]; then
  declare -a ssh_keys

  for i in ~/.ssh/id_*.pub; do
    test -f "${i%.*}" && ssh_keys+=("${${i%.*}##*/}");
  done
  eval $(keychain --eval --quiet $ssh_keys)
  unset ssh_keys
fi

####################################################
# Launch tmux
# Placed at top of file else the entire file is run, and then run again when tmux creates a new session
#
function allow_tmux() {
  [[ -z "${TMUX}" && ! -f /tmp/no_tmux && (( $+commands[tmux] )) && -z $SSH_CLIENT ]];
}

if allow_tmux; then
  SESSION_NAME=local
  export PATH=${PATH}:${HOME}/.local/bin
  tmux -q has-session -t ${SESSION_NAME} &>/dev/null
  if [ $? != 0 ]; then
    # -n window name
    exec tmux new-session -n ${USER} -s ${SESSION_NAME}
  else
    # Only reattach if remote session
    # attach-session -d : Detach existing: aggressive resize does not work will
    if [[ -n $SSH_CLIENT ]]; then
      SESSION_NAME=remote
    fi
    exec tmux attach-session -d -t ${SESSION_NAME}
  fi
fi

# Update environment from tmux
# - not effective on the first command
# http://sourceforge.net/mailarchive/message.php?msg_id=31280570
# http://stackoverflow.com/questions/18241406/tmux-environment-variables-dont-show-up-in-session
if [[ -n "${TMUX}" ]]; then
  VARS="$(tmux show-environment)"
  for VAR in ${(f)VARS}; do
    if [[ $VAR == -* ]]; then
      unset $(echo $VAR | cut -c2-);
    else
      export $VAR;
    fi;
  done
fi

# Use color names instead of escapecodes
autoload colors; colors

# Source shared files
for sourcefile in ~/.config/zsh/*; do source ${sourcefile}; done
unset sourcefile

# Source external files if there are any
if [[ -d ~/.config/zsh/external && -n "$(ls -A ~/.config/zsh/external 2>/dev/null)" ]]; then
  for sourcefile in ~/.config/zsh/external/*; do source ${sourcefile}; done
  unset sourcefile
fi

# Based on coreos /usr/share/baselayout/coreos-profile.sh
if [[ $- == *i* && $PLATFORM != 'Darwin' ]]; then
  FAILED=$(systemctl list-units --state=failed --no-legend)
  if [[ ! -z "${FAILED}" ]]; then
    COUNT=$(wc -l <<<"${FAILED}")
    echo -e "Failed Units: \033[31m${COUNT}\033[39m"
    printf " %s" ${FAILED}
  fi
fi
