# Feature branch
alias gfb="git checkout -b"
compdef _git gfb=git-checkout

# https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/git/git.plugin.zsh
# Aliases
alias gst='git status'
compdef _git gst=git-status
# Fix typo "gs" when I ment "gst"
alias gs='git status'
compdef _git gs=git-status
alias gd='git diff'
compdef _git gd=git-diff
# alias gco='git checkout'
# compdef _git gco=git-checkout
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'
