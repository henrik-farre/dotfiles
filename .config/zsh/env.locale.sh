#!/bin/bash

# Locales

if [[ -z "${LANG}" || -z "${LC_ALL}" ]]; then
  export LANG=da_DK.utf8
  export LC_ALL=da_DK.utf8
fi

# Fix: cursor is on top of prompt and command is repeated
if [[ $PLATFORM == 'Darwin' && -z "${LC_CTYPE}" ]]; then
  export LC_CTYPE=da_DK.UTF-8
fi
