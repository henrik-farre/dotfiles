#!/bin/bash

# Fix common errors:
# Referencing undefined variables (which default to "")
# Ignoring failing commands
set -o nounset
set -o errexit
set -o pipefail
IFS=$'\n\t'

SRC_DIR=/tmp/input
DST_DIR=/tmp/output

# Needs to recurse
# for FILE in $SRC_DIR/*.jpg; do
#   EXTENSION=${FILE##*.}
# 
#   DATETIME=$( exiftool -f -s3 -"DateTimeOriginal" "${FILE}" )
# 
#   if [ "${DATETIME}" = '-' ]; then
#     DATETIME=$( exiftool -f -s3 -"MediaCreateDate" "${FILE}")
#   fi
# 
#   echo "$FILE => ${DST_DIR}/${DATETIME}.${EXTENSION}"
# done
exiftool -out . \
  "-filename<filemodifydate" "-filename<mediacreatedate" "-filename<createdate" "-filename<datetimeoriginal" \
  -preserve \
  --extension mp4 --extension mts \
  -ignoreMinorErrors \
  -quiet -quiet \
  -dateFormat '/tmp/output/%Y/%m/%Y-%m-%d_%H:%M:%S.%%le' \
  -recurse /tmp/input
