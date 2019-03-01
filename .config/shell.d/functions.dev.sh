function swat-phpmd() {
  if [[ -z $1 ]]; then
    (>&2 echo "Missing file argument")
    return 1
  fi

  if [[ ! -f /usr/local/etc/phpmd_swat_rules.xml ]]; then
    (>&2 echo "Missing rule set")
    return 1
  fi

  phpmd "$1" text /usr/local/etc/phpmd_swat_rules.xml
}
