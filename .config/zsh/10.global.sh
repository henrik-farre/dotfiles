if [[ -f /etc/arch-release ]]; then
  export DISTRO_IS='arch'
elif [[ -f /etc/debian_version ]]; then
  export DISTRO_IS='debian'
  DEBIAN_VERSION=$(cat /etc/debian_version)
else
  export DISTRO_IS='unknown'
fi

export PLATFORM=$(uname)

if [[ ${ZSH_VERSION:-x} != 'x' ]]; then
  export SHELL_IS='zsh'
elif [[ ${BASH_VERSION:-x} != 'x' ]]; then
  export SHELL_IS='bash'
fi
