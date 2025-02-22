# Based on coreos /usr/share/baselayout/coreos-profile.sh
if [[ $- == *i* && $PLATFORM != 'Darwin' ]]; then
  FAILED=$(systemctl list-units --state=failed --no-legend)
  if [[ -n "${FAILED}" ]]; then
    COUNT=$(wc -l <<<"${FAILED}")
    echo -e "Failed Units: \033[31m${COUNT}\033[39m"
    printf " %s" "${FAILED}"
  fi
fi
