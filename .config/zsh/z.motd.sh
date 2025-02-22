if [[ -o interactive && ! -f /tmp/.motd_seen ]]; then
echo -e "\e[42mMotd:\e[0m"

cat << EOF
Use:
  git switch
  git worktree
  git restore
  git status -sb
  git pull --rebase
EOF

touch /tmp/.motd_seen
fi
