# Feature branch
alias gfb="git switch -c"
compdef _git gfb=git-switch
alias gsw="git switch"
compdef _git gsw=git-switch
alias gp="git pull"
compdef _git gp=git-pull

# https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/git/git.plugin.zsh
# Aliases
alias gst='git status -sb'
compdef _git gst=git-status
# Fix typo "gs" when I ment "gst"
alias gs='git status -sb'
compdef _git gs=git-status
alias gd='git diff'
compdef _git gd=git-diff
# alias gco='git checkout'
# compdef _git gco=git-checkout
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'
