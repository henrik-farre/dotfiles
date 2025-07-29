if [[ -o interactive && ! -f /tmp/.motd_seen ]]; then
  echo -e "\e[42mMotd:\e[0m"

  cat <<EOF
Use:
  git switch
  git worktree
  git restore
  git status -sb
  git pull --rebase
  gcif
  ctrl+g ctrl+f for fzf-git files
  ctrl+g ctrl+b for fzf-git branches
  smite
  ctrl+a F for tmux fingers
EOF

  touch /tmp/.motd_seen
fi
