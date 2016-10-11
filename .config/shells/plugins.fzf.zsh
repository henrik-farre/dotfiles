######################################################
# FZF
# From https://github.com/junegunn/fzf

# Use -e if symlink (locally installed)
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  # System installed:
  . /usr/share/fzf/key-bindings.zsh
  # Local installed:
  # source ~/.fzf.zsh

  # https://github.com/junegunn/fzf/blob/master/fzf#L653
  #export FZF_DEFAULT_COMMAND="find * -path '*/\\.*' -xdev -prune -o -type f -print -o -type l -print 2> /dev/null"
  # https://github.com/junegunn/fzf Respecting .gitignore, .hgignore, and svn:ignore
  if type ag &>/dev/null; then
    export FZF_DEFAULT_COMMAND='ag -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
  export FZF_DEFAULT_OPTS="-x -e"

  #
  # fe [FUZZY PATTERN] - Open the selected file with the default editor
  #   - Bypass fuzzy finder if there's only one match (--select-1)
  #   - Exit if there's no match (--exit-0)
  fe() {
    local file
    file=$(fzf --query="$1" --select-1 --exit-0)
    [ -n "$file" ] && ${EDITOR:-vim} "$file"
  }

  # fd - cd to selected directory
  fd() {
    local dir
    dir=$(find ${1:-*} -path '*/\.*' -prune \
                    -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
  }

  # fda - including hidden directories
  fda() {
    local dir
    dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
  }

  # fh - repeat history
  fh() {
    eval $(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s | sed 's/ *[0-9]* *//')
  }

  # fkill - kill process
  fkill() {
    ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
  }

  # fbr - checkout git branch
  fbr() {
    local branches branch
    branches=$(git branch) &&
    branch=$(echo "$branches" | fzf +s +m) &&
    git checkout $(echo "$branch" | sed "s/.* //")
  }

  # fco - checkout git commit
  fco() {
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf +s +m -e) &&
    git checkout $(echo "$commit" | sed "s/ .*//")
  }

  # ftags - search ctags
  ftags() {
    local line
    [ -e tags ] &&
    line=$(
      awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
      cut -c1-80 | fzf --nth=1,2
    ) && $EDITOR $(cut -f3 <<< "$line") -c "set nocst" \
                                        -c "silent tag $(cut -f2 <<< "$line")"
  }

  zle     -N   fzf-git-changed-files
  bindkey '^F' fzf-git-changed-files
fi
