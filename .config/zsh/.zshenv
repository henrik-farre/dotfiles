if [[ -v WSL_DISTRO_NAME ]]; then
  export GTK_THEME=Adwaita:dark
  export BROWSER=open-link
  export XDG_CACHE_HOME=${HOME}/.cache
  export XDG_CONFIG_HOME=${HOME}/.config
  export XDG_DATA_HOME=${HOME}/.local/share
fi
