#!/bin/bash

# Fix common errors:
# Referencing undefined variables (which default to "")
# Ignoring failing commands
set -o nounset
set -o errexit
set -o pipefail
IFS=$'\n\t'

SRC_DIR=/shared/backup/incomming-pictures
PIC_DST_DIR=/shared/pictures
VID_DST_DIR=/shared/clips

cd $SRC_DIR

# include "-out ." to copy instead of move

# Import everything else than mp4 and mts
exiftool -v . \
  "-filename<filemodifydate" "-filename<mediacreatedate" "-filename<createdate" "-filename<datetimeoriginal" \
  -preserve \
  --extension mp4 --extension mts \
  -ignoreMinorErrors \
  -dateFormat "$PIC_DST_DIR/%Y/%m/%Y-%m-%d_%H:%M:%S_%%c_%%f.%%le" \
  -recurse "$SRC_DIR"

# Import everything else than jpg and jpeg
exiftool -v . \
  "-filename<filemodifydate" "-filename<mediacreatedate" "-filename<createdate" "-filename<datetimeoriginal" \
  -preserve \
  --extension jpg --extension jpeg \
  -ignoreMinorErrors \
  -dateFormat "$VID_DST_DIR/%Y/%m/%Y-%m-%d_%H:%M:%S_%%c_%%f.%%le" \
  -recurse "$SRC_DIR"
