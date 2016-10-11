#!/bin/bash

# Locales

if [[ -z "${LANG}" || -z "${LC_ALL}" ]]; then
  export LANG=da_DK.utf8
  export LC_ALL=da_DK.utf8
fi
