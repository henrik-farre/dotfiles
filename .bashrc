# ~/.bashrc: executed by bash(2) for non-login shells.

# If not running interactively, don't do anything:
if [[ "$-" != *i* ]]; then return; fi

####################################################
# Launch screen
# Placed at top of file else the entire file is run, and then run again when tmux creates a new session
#
if [[ -z "${STY}" && ${HOSTNAME_IS} == "management" ]]; then
  ln -sf ${SSH_AUTH_SOCK} ~/.ssh/screen_ssh_auth_sock; screen -DR; rm -f ~/.ssh/screen_ssh_auth_sock
fi

# Source shared *.sh and *.bash files
for sourcefile in ~/.config/shell.d/*.{sh,bash}; do source ${sourcefile}; done
unset sourcefile

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

# Based on coreos /usr/share/baselayout/coreos-profile.sh
if [[ $- == *i* && -e /bin/systemctl && $PLATFORM != 'Darwin' ]]; then
  FAILED=$(systemctl list-units --state=failed --no-legend)
  if [[ ! -z "${FAILED}" ]]; then
    COUNT=$(wc -l <<<"${FAILED}")
    echo -e "Failed Units: \033[31m${COUNT}\033[39m"
    awk '{ print "  " $1 }' <<<"${FAILED}"
  fi
fi
