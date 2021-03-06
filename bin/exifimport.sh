#!/bin/bash

# Fix common errors:
# Referencing undefined variables (which default to "")
# Ignoring failing commands
set -o nounset
set -o errexit
set -o pipefail
IFS=$'\n\t'

# Based on https://matts.org/organizing-photos-by-date-on-the-linux-command-line/

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
  -ext mts -ext mp4 \
  -ignoreMinorErrors \
  -dateFormat "$VID_DST_DIR/%Y/%m/%Y-%m-%d_%H:%M:%S_%%c_%%f.%%le" \
  -recurse "$SRC_DIR"

echo "#############################################################"
echo "Performing backup"
sudo mount /mnt/3tb

(
echo "- Pictures"
cd /shared/pictures
rsync --ignore-existing -raz --progress * /mnt/3tb/pictures/
)
(
echo "- Clips"
cd /shared/clips
rsync --ignore-existing -raz --progress * /mnt/3tb/clips/
)

sudo umount /mnt/3tb

echo "Putting backup drive to sleep"
sudo hdparm -y /dev/sdc
sudo smartctl -i -n standby /dev/sdc
