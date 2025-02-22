# https://github.com/junegunn/fzf-git.sh
# Pick branch
function gcob() {
  _fzf_git_each_ref --no-multi | xargs git checkout
}

# Pick files to commit
function gcif() {
  _fzf_git_files | xargs git ci
}
