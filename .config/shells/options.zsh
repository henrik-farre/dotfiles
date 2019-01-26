# slashes, dots and few other things are treated as delimiters too.
autoload -U select-word-style
select-word-style bash

# Options
setopt NO_CORRECT_ALL # correct_all wants to replace vim with .vim
setopt NO_AUTO_REMOVE_SLASH
setopt AUTO_PARAM_SLASH
setopt AUTO_MENU
setopt AUTO_LIST
setopt AUTO_CD

############################################################################################
setopt NO_BG_NICE
setopt NO_CHECKJOBS
setopt NO_HUP
setopt NO_NOMATCH
setopt autopushd               # automatically append dirs to the push/pop list
setopt pushdignoredups         # and don't duplicate them
setopt cdablevars              # avoid the need for an explicit $
setopt nolisttypes             # show types in completion
setopt extendedglob            # weird & wacky pattern matching - yay zsh!
setopt completeinword          # not just at the end
setopt alwaystoend             # when complete from middle, move cursor
setopt histverify              # when using ! cmds, confirm first
setopt interactivecomments     # escape commands so i can use them later
setopt printexitvalue          # alert me if something's failed
setopt prompt_subst            # Allow for functions/variable expansion in the prompt.
setopt transientrprompt        # Remove any right prompt from display when accepting a command line. This may be useful with terminals with other cut/paste methods.
setopt rm_star_silent          # Remove double verification: "zsh: sure you want to delete all the files in ..."
