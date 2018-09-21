#!/bin/zsh

if [[ $PLATFORM == 'Darwin' ]]; then
  if [[ -f ~/.config/shells/macos/prompt.zsh ]]; then
    source ~/.config/shells/macos/prompt.zsh
  fi
else
  source ~/.config/shells/linux/prompt.zsh
fi
