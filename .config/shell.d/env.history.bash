#!/bin/bash
# Same size as zsh
# Number of lines
export HISTFILESIZE=15000
# Number of commands
export HISTSIZE=15000

export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '

export HISTIGNORE=ls:l:ll:mc:cd:..
export HISTCONTROL=ignoreboth:erasedups
