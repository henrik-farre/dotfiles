#!/bin/bash

# Fix common errors:
# Referencing undefined variables (which default to "")
# Ignoring failing commands
set -o nounset
set -o errexit
set -o pipefail
IFS=$'\n\t'

SRC_DIR=/shared/backup/image_cleanup_not_found
DST_DIR=/shared/pictures

cd $SRC_DIR

# include "-out ." to copy instead of move

exiftool \
  "-filename<filemodifydate" "-filename<mediacreatedate" "-filename<createdate" "-filename<datetimeoriginal" \
  -preserve \
  --extension mp4 --extension mts \
  -ignoreMinorErrors \
  -quiet -quiet \
  -dateFormat "$DST_DIR/%Y/%m/%Y-%m-%d_%H:%M:%S_%%c_%%f.%%le" \
  -recurse "$SRC_DIR"
