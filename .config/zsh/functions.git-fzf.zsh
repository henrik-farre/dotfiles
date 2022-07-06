# https://github.com/junegunn/fzf/wiki/Examples#git
function git-checkout-local-branch() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# Based on https://seb.jambor.dev/posts/improving-shell-workflows-with-fzf/
function git-create-branch-from-jira() {
  branch_name=$(
    jira tasks-with-id-and-description |
    fzf \
      --with-nth=1 \
      --delimiter='\t' \
      --preview='echo -e {2}' \
      --preview-window=top:wrap |
    cut -f1 |
    awk '{printf "%s", $1}'
  )

  if [ -n "$branch_name" ]; then
    git checkout -b "$branch_name"
  fi
}

# Based on https://seb.jambor.dev/posts/improving-shell-workflows-with-fzf/ and
# https://github.blog/2021-03-11-scripting-with-github-cli/#combine-gh-with-other-tools
function git-pr-checkout() {
  local pr_number

  pr_number=$(gh pr list -L100 | fzf | cut -f1)

  if [ -n "$pr_number" ]; then
    gh pr checkout "$pr_number"
  fi
}
