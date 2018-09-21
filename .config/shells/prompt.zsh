#!/bin/zsh

if [[ $PLATFORM == 'Darwin' ]]; then
  if [[ -f macos/prompt.zsh ]]; then
    source macos/prompt.zsh
  fi
else
  source linux/prompt.zsh
fi
