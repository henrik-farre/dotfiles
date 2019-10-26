#!/bin/zsh
####################################################
# Prompt
# TODO: when not running in X, use plain prompt
#
function build_prompt() {
  if [[ $TERM =~ linux* || $TERM =~ xterm-256* || $TERM = xterm ]]; then
    PS1=$'%{$fg[green]%}${VIMODE}%~%{$reset_color%}${vcs_info_msg_0_}%{$fg[green]%}> %{$reset_color%}'
    export PS1
    return
  fi

  local PROMPT_USER=''
  local PROMPT_USER_SEP=''
  if [[ "${USER}" != 'enrique' ]]; then
    PROMPT_USER=$'%{$fg[black]$bg[red]%} %n '
    PROMPT_USER_SEP='%{$reset_color%}%{$fg[red]$bg[green]%} %{$reset_color%}'
  fi

  local PROMPT_HOST=''
  local PROMPT_HOST_SEP=''
  if [[ -n $SSH_TTY ]]; then
    if [[ -n $PROMPT_USER ]]; then
      PROMPT_USER_SEP='%{$reset_color%}%{$fg[red]$bg[blue]%} %{$reset_color%}'
    fi
    PROMPT_HOST=$'%{$fg[black]$bg[blue]%}%m %{$reset_color%}%{$fg[blue]$bg[green]%}%{$reset_color%}'
  fi

  # Current directory: green background, white text
  local PROMPT_PATH=$'%{$fg[white]$bg[green]%} %~ '
  # If psvar[1] is set and not empty, set text to green, and "black" background, else reset background and show green text
  local PROMPT_PATH_SEP=$'%1(V:%{$bg[black]%}%{$fg[green]%} :%{$reset_color%}%{$fg[green]%})'
  # Show VCS info, color codes are set where vcs_info is configured
  local PROMPT_GIT=$'${vcs_info_msg_0_} '
  local PROMPT_GIT_SEP=$'%1(V:%{$reset_color%}%{$fg[black]%}:)'
  # New line and blue text
  # The space is not a space, but Unicode non-breaking space
  # From http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html
  local PROMPT_END=$'\n%{$reset_color%}%{$fg[blue]%}%{$reset_color%} '
  PS1=${PROMPT_USER}${PROMPT_USER_SEP}${PROMPT_HOST}${PROMPT_HOST_SEP}${PROMPT_PATH}${PROMPT_PATH_SEP}${PROMPT_GIT}${PROMPT_GIT_SEP}${PROMPT_END}
  export PS1
}

####################################################
# Set title function
# Used in precmd
function title() {
  # escape '%' chars in $1, make nonprintables visible
  local cmd=${(V)1//\%/\%\%}

  # See "Conditional Substrings in Prompts"
  # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
  # %X>...>                     : truncate to 40 chars followed by ...
  # %X(c:true-text:false-text)  : if c > %X show true text, else false text

  if [[ -n $cmd ]]; then
    cmd="  $cmd"
  fi
  # Truncate cmd to 40
  cmd=$(print -Pn "%40>...> $cmd" | tr -d "\n")

  # print -Pn "\e]2;%n@%m:%40<...<%~> $cmd\a"
  print -Pn "\e]2;%40<...<%~> $cmd\a"

  # case $TERM in
  #   screen|screen-bce|screen-256color|screen-256color-bce|tmux-256color)
  #     if [[ -z $SSH_TTY ]]; then
  #       #print -Pn "\ek%40<...<%~> $cmd\e\\"
  #       # if c (current path with prefix replace, aka ~) is larger than 7,
  #       # show first 3 parts, then ... and then last 3 parts, else just %~
  #       print -Pn "\ek%7(c:%-3~/.../%3~:%~)$cmd\e\\"
  #     else
  #       # With user/hostname
  #       print -Pn "\ek%m:%40<...<%~> $cmd\e\\"
  #     fi
  #     ;;
  #   xterm*|rxvt*)
  #     # plain xterm title
  #     if [[ -z $SSH_TTY ]]; then
  #     else
  #       # With user/hostname
  #       print -Pn "\e]2;%n@%m:%40<...<%~> $cmd\a"
  #     fi
  #     ;;
  # esac
}

####################################################
# Window title (bash complains about the syntax if in shared file)
# precmd is called just before the prompt is printed
# http://grml.org/zsh-pony/#sec-13 about psvar
function precmd() {
  title ""
  psvar=()
  # Disabled 06-oct-2016 for use on dev:
  # Don't run vcs_info if remote shell
  # if [[ -z $SSH_TTY ]]; then
    vcs_info
    psvar[1]="${vcs_info_msg_0_}"
  # fi
}

# preexec is called just before any command line is executed
function preexec() {
  title "$1"
}

####################################################
# SPROMPT - the spelling prompt
#
SPROMPT='zsh: correct '%R' to '%r' ? ([Y]es/[N]o/[E]dit/[A]bort) '

####################################################
# Vi mode: set $VIMODE to current mode
#
# zle-keymap-select is executed every time KEYMAP changes.
# http://paulgoscicki.com/archives/2012/09/vi-mode-indicator-in-zsh-prompt/ <- This fixes the last line being eaten
# http://zshwiki.org/home/examples/zlewidgets
# http://stackoverflow.com/questions/14316463/zsh-clear-rps1-before-adding-line-to-linebuffer
vim_ins_mode="%{$fg[black]%}%{$fg[white]$bg[black]%}INSERT%{$reset_color%}"
vim_cmd_mode="%{$fg[green]%}%{$fg[black]$bg[green]%}NORMAL%{$reset_color%}"

# Remove space from right side of rprompt
ZLE_RPROMPT_INDENT=0

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}

function zle-line-finish {
  vim_mode=$vim_ins_mode
}

if [[ $TERM =~ linux* || $TERM =~ xterm-* ]]; then
  #
else
  zle -N zle-keymap-select
  zle -N zle-line-finish

  RPROMPT='${vim_mode}'
fi

####################################################
# Git prompt
# http://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
# Misc symbols for git prompt http://www.paradox.io/posts/9-my-new-zsh-prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true # Might be slow as it checks for unstaged and changed files
zstyle ':vcs_info:*' disable-patterns "$HOME/remote_mounts(|/*)"
zstyle ':vcs_info:*' stagedstr '%F{yellow}✔%F{reset}'
zstyle ':vcs_info:*' unstagedstr '%F{red}✘%F{reset}'
# %s The current version control system, like git or svn.
# %r The name of the root directory of the repository
# %S The current path relative to the repository root directory
# %b Branch information, like master
# %m In case of Git, show information about stashes
# %u Show unstaged changes in the repository
# %c Show staged changes in the repository
zstyle ':vcs_info:git*' formats " %b %u%c%m"

build_prompt
export SPROMPT

# Removes % from lines with no EOL
export PROMPT_EOL_MARK=""
