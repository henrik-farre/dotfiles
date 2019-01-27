# History settings
HISTFILE=~/.zhistory
HISTSIZE=15000
SAVEHIST=15000
HISTORY_IGNORE="(bg|fg|cd*|rm*|clear|ls|pwd|history|exit|make*|* --help|gst|git pull|git pull|pacsearch *|..)"

setopt INC_APPEND_HISTORY      # Add comamnds as they are typed, don't wait until shell exit
setopt SHARE_HISTORY           # Share history between all sessions.
setopt EXTENDED_HISTORY        # Write the history file in the ":start:elapsed;command" format.
setopt HIST_IGNORE_SPACE       # Don't record an entry starting with a space.
setopt HIST_IGNORE_ALL_DUPS    # Delete old recorded entry if new entry is a duplicate.
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks before recording entry.
setopt HIST_FIND_NO_DUPS       # When searching history don't display results already cycled through twice
