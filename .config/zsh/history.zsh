# History settings
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=100000                 # The number of lines loaded into the shell memory
SAVEHIST=100000                 # The number of lines of history you want to be saved
HISTORY_IGNORE="(bg|fg|cd*|rm*|clear|ls|pwd|history|exit|make*|* --help|gst|git pull|git push|gst|gd|pacsearch *|..|x *)"

setopt INC_APPEND_HISTORY      # Add commands as they are typed, don't wait until shell exit
setopt SHARE_HISTORY           # Share history between all sessions.
setopt EXTENDED_HISTORY        # Write the history file in the ":start:elapsed;command" format.
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicate entries first when trimming history
setopt HIST_SAVE_NO_DUPS       # Don't write duplicate entries in the history file
setopt HIST_IGNORE_SPACE       # Don't record an entry starting with a space.
setopt HIST_IGNORE_ALL_DUPS    # Delete old recorded entry if new entry is a duplicate.
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks before recording entry.
setopt HIST_FIND_NO_DUPS       # When searching history don't display results already cycled through twice
