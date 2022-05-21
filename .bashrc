# ~/.bashrc: executed by bash(2) for non-login shells.

# If not running interactively, don't do anything:
if [[ "$-" != *i* ]]; then return; fi

####################################################
# Launch screen
# Placed at top of file else the entire file is run, and then run again when tmux creates a new session
#
# http://www.askapache.com/security/bash_profile-functions-advanced-shell.html
# checkwinsize            bash checks the window size after each command and, if necessary, updates the values of LINES and COLUMNS.
# cdspell                 minor errors in the spelling of a directory component in a cd command will be corrected.
# histappend              the history list is appended to the file named by the value of the HISTFILE variable when shell exits, no overwriting the file
# cmdhist                 bash attempts to save all lines of a multiple-line command in the same history entry.  Allows re-editing of multi-line commands.
# no_empty_cmd_completion bash will not attempt to search the PATH for possible completions when completion is attempted on an empty line.
# extglob                 the extended pattern matching features described above under Pathname Expansion are enabled.
# checkhash               bash checks that a command found in the hash table exists before execute it.  If no longer exists, a path search is performed.
# globstar                allows for stuff like cache/smarty/{cache,compile}/{,**/}*.tpl.php

shopt -s checkwinsize cdspell histappend cmdhist no_empty_cmd_completion extglob checkhash globstar

# Delete part of path using ctrl+w
stty werase undef
bind '\C-w:unix-filename-rubout'

if [[ -z ${BASH_COMPLETION} && -f /etc/bash_completion ]]; then
  . /etc/bash_completion
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

###################################################################
# Prompt
#
function render_prompt()
{
  # Window title
  local TITLEBAR
  # case $TERM in
    # screen|screen-bce|screen-256color|screen-256color-bce)
      # TITLEBAR='\033k\033\0134\033k${HOSTNAME%%.*}:${PWD/$HOME/~}\033\0134'
      # ;;
    # xterm*|rxvt*)
      # TITLEBAR='\033]0;${HOSTNAME%%.*}:${PWD/$HOME/~}\007'
      # ;;
  # esac
  # TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'

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

  if [[ -z $SSH_TTY ]]; then
    echo -ne "\033]0;${HOSTNAME%%.*}:> ${PWD##*/}\007"
  else
    echo -ne "\033]0;$USER@${HOSTNAME}:> ${PWD:${#PWD}<25?0:(-25)}\007"
  fi

  if [[ "${USER}" == 'root' ]]; then
    PS1="\[\033[0;31m\]\u@\H\[\033[00m\]:\w> "
  else
    PS1='\[${ENV_COLOR}\]\H\[${RESET}\]:\w> '
  fi

  # export PS1
}

PROMPT_COMMAND=render_prompt
# PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}: ${PWD##*/}\007"'

###################################################################
# History
#
# Number of lines
export HISTFILESIZE=15000
# Number of commands
export HISTSIZE=15000

export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '

export HISTIGNORE=ls:l:ll:mc:cd:..
export HISTCONTROL=ignoreboth:erasedups


# Based on coreos /usr/share/baselayout/coreos-profile.sh
if [[ $- == *i* && -e /bin/systemctl && $PLATFORM != 'Darwin' ]]; then
  FAILED=$(systemctl list-units --state=failed --no-legend)
  if [[ ! -z "${FAILED}" ]]; then
    COUNT=$(wc -l <<<"${FAILED}")
    echo -e "Failed Units: \033[31m${COUNT}\033[39m"
    awk '{ print "  " $1 }' <<<"${FAILED}"
  fi
fi
