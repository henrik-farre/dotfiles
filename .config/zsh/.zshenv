if [[ -v WSL_DISTRO_NAME ]]; then
  source $ZDOTDIR/env.sh
  export GTK_THEME=Adwaita:dark
  export BROWSER=open-link
  export XDG_CACHE_HOME=${HOME}/.cache
  export XDG_CONFIG_HOME=${HOME}/.config
  export XDG_DATA_HOME=${HOME}/.local/share
  export XDG_SESSION_TYPE=wayland

  # Temp fix as GUI are broken
  export LIBGL_ALWAYS_SOFTWARE=1
  export __GLX_VENDOR_LIBRARY_NAME=mesa
fi
