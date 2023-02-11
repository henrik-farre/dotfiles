#!/bin/bash
# Fix cd filename
function cd () {
if [[ -z $2 ]]; then
  if [[ -f $1 ]]; then
    builtin cd $1:h
  else
    builtin cd $1
  fi
else
  builtin cd $*
fi
}

function error() {
  local RESET="\\033[0;39m"
  local RED="\\033[1;31m"
  echo -n ${RED}$1${RESET}
}

function notice() {
  local RESET="\\033[0;39m"
  local GREEN="\\033[1;32m"
  echo -n ${GREEN}$1${RESET}
}

function f() {
  if [[ -e /usr/bin/fd ]]; then
    /usr/bin/fd $@
  else
    # Based on https://github.com/cyphunk/humanism.sh/blob/master/humanism.sh
    FOLLOWSYMLNK="-L"
    if [ $# -eq 0 ]; then
      /usr/bin/env find .
    elif [ $# -eq 1 ]; then
      # If it is a directory in cwd, file list
      if [ -d "$1" ]; then
        /usr/bin/env find $FOLLOWSYMLNK "$1"
        # else fuzzy find
      else
        /usr/bin/env find $FOLLOWSYMLNK ./ -iname "*$1*" 2>/dev/null
      fi
    elif [ $# -eq 2 ]; then
      /usr/bin/env find $FOLLOWSYMLNK "$1" -iname "*$2*" 2>/dev/null
    else
      /usr/bin/env find $@
    fi
  fi
}

function x {
for archive in "${@}"; do
  if [ -f "$archive" ] ; then
    case $archive in
      *.tar.bz2)  tar xvjf "$archive";;
      *.tar.gz)   tar xvzf "$archive";;
      *.tar.xz)   tar xvJf "$archive";;
      *.tar.zst)  tar --zstd -xvf "$archive";;
      *.bz2)      bunzip2 "$archive";;
      *.rar)      unrar x "$archive";;
      *.gz)       gunzip "$archive";;
      *.tar)      tar xvf "$archive";;
      *.tbz2)     tar xvjf "$archive";;
      *.tgz)      tar xvzf "$archive";;
      *.ezpkg)    tar zxvf "$archive";;
      *.7z)       7z x "$archive";;
      *.xz)       unxz "$archive";;
      *.deb)      ar vx "$archive";;
      *.zip)
        DIRNAME1=$(echo "$archive" | tr ' ' '_')
        DIRNAME=$(basename "${DIRNAME1}" .zip)
        echo "Creating '${DIRNAME}', and moving '$archive' to it"
        mkdir "$DIRNAME"
        mv "$archive" "$DIRNAME/"
        cd "$DIRNAME" || exit
        unzip "$archive"
        ;;
      *.Z)        uncompress "$archive"   ;;
      *.rpm)      rpmextract.sh "$archive" ;;
      *)          echo "'$archive' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$archive' is not a valid file"
    return 1
  fi
done
}

function cmpall() {
  DIR1=${1}
  DIR2=${2}
  EXT=${3}

  if [ ${#} -lt 2 ]; then
    echo Usage: cmpall dir1 dir2
    echo - or -
    echo Usage: cmpall dir1 dir2 ext
    return 1
  fi

  if [ ${#} == 2 ]; then
    #  ARGS='{.[a-zA-Z],}*'
    ARGS=""
  elif [ ${#} == 3 ]; then
    ARGS="-name \"*.${EXT}\""
  fi

  for i in `find ${DIR1} ${ARGS} -type f`;do
    j=`basename ${i}`
    FILE1=${DIR1}/${j}
    FILE2=${DIR2}/${j}

    if [ -f ${FILE2} ]; then
      # check om filen findes i dir2
      if ! cmp -s ${FILE1} ${FILE2}; then
        echo "filen \"${j}\" er forskellig i de to mapper"
        echo -n "Choose action: vimdiff (d), cp (c), skip (s), skip all (a), exit (x): "
        read action

        case "${action}" in
          "d" )
            vimdiff ${FILE1} ${FILE2}
            ;;
          "c" )
            BAKFILE=${FILE2}.bak_`date +"%d-%m-%Y"`
            echo "opretter bak fil: ${BAKFILE}"
            cp -i ${FILE2} ${BAKFILE}
            cp -iv ${FILE1} ${FILE2}
            ;;
          "s" )
            continue
            ;;
          "a" )
            SKIPALL=true
            continue
            ;;
          "x" )
            return 0
            ;;
          * )
            echo "vimdiff ${FILE1} ${FILE2}"
            ;;
        esac
      fi;
    else
      if [ ${SKIPALL} ]; then
        continue
      fi
      # filen findes ikke i dir2
      echo "filen \"${j}\" findes ikke i ${DIR2}/"
      echo -n "Choose action: cp (c), skip (s), exit (x): "
      read action

      case "${action}" in
        "c" )
          cp -iv ${FILE1} ${FILE2}
          ;;
        "s" )
          continue
          ;;
        "x" )
          return 0
          ;;
      esac
    fi
  done
}

function forall() {
  if [ $# -eq 0 ]; then
    echo Usage 1: forall katalog tekststreng
    echo Usage 2: forall katalog extension tekststreng
    return 1
  elif [ $# -eq 2 ]; then
    echo "Søger i mappe: $1 efter alle filer, efter streng: $2"
    find $1 -type f -exec grep --color=auto -Hn "$2" {} \;
  elif [ $# -eq 3 ]; then
    echo "Søger i mappe: $1 efter filer med navn: $2 efter streng: $3"
    find $1 -iname "*$2" -type f -exec grep --color=auto -Hn "$3" {} \;
  fi
}

function myip() {
  INTIP=`/sbin/ifconfig | egrep -o '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | grep -v "\(^127\|255\)"`
  EXTIP=`curl http://icanhazip.com/`
  # Simpler er http://www.whatismyip.org
  # EXTIP=`wget -q http://checkip.dyndns.org:8245/ -O - | egrep -o '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'`
  echo "Internal ip: ${INTIP}"
  echo "External ip: ${EXTIP}"
}

# clashes with litra-driver command
# function lc() {
#   # a little bit of help in case of misuse
#   if [ ${#} -lt 2 ]
#   then
#     echo "usage: lc /directory pattern"
#     echo "example: lc /etc config"
#     return 1
#   fi
# 
#   # $DIR is the first argument, the path to the directory
#   DIR=${1}
# 
#   # $SEARCH is what you are looking for, and it's the second argument
#   SEARCH=${2}
# 
#   # $RED sets the text to inverted red, changing the capabilities of the terminal via terminfo parameters
#   # setaf 1 = red, smso = inverted
#   RED=`tput setaf 1; tput smso`
# 
#   #  $NORMAL returns text to normal attributes
#   NORMAL=`tput sgr0`
# 
#   ls -lA ${DIR} | sed s/"${SEARCH}"/"${RED}${SEARCH}${NORMAL}"/g
# }

function wake-host() {
  case "${1}" in
    "spook" | "spookcentral")
      # GIGABYTE GA-Z87-D3HP
      MAC="94:de:80:78:e9:6a"
      ;;
    "fire" | "firehouse")
      # Old gigabyte:
      # MAC="00:24:1D:15:85:99 00:24:1d:15:85:89"
      # Asus Rog Strix
      MAC="24:4b:fe:97:2d:21"
      ;;
    "sedge" | "sedgewick")
      # Asus H170M-Plus
      MAC="1c:b7:2c:b1:65:61"
      ;;
    *)
      echo "Does not know that host"
      return 1
      ;;
  esac

  wol -v ${MAC}
}

########################################
# Functions to handle encoding fubars

# From demunger.sh script
function encoding_demunger() {
  echo I\'d work on "$@" ...
  for i in "$@" ; do
    echo -n $i... to $i.new
    sed \
      -e 's/Ã©/é/g' -e 's/Ã¨/è/g' -e 's/Ãª/ê/g' -e 's/Ã«/ë/g' \
      -e 's/Â / /g' -e 's/Â«/«/g' -e 's/Â»/»/g' -e 's/Â°/°/g' \
      -e 's/Ã¤/ä/g' -e 's/Ã¢/â/g' -e 's/Ã®/î/g' -e 's/Â/’/g'  \
      -e 's/Ã¯/ï/g' -e 's/Ã¬/ì/g' -e 's/Ã²/ò/g' -e 's/Ã´/ô/g' \
      -e 's/Ã¶/ö/g' -e 's/Ã¿/ÿ/g' -e 's/Ã¹/ù/g' -e 's/Ã¼/ü/g' \
      -e 's/Ã»/û/g' -e 's/Ã§/ç/g' -e 's/Ã‰/É/g' -e 's/Ãˆ/È/g' \
      -e 's/ÃŠ/Ê/g' -e 's/Ã‹/Ë/g' -e 's/Ã€/À/g' -e 's/Ã„/Ä/g' \
      -e 's/Ã‚/Â/g' -e 's/ÃŽ/Î/g' -e 's/Ã/Ï/g' -e 's/ÃŒ/Ì/g' \
      -e 's/Ã’/Ò/g' -e 's/Ã”/Ô/g' -e 's/Ã–/Ö/g' -e 's/Å¸/Ÿ/g' \
      -e 's/â€¦/…/g' -e 's/â€™/’/g' -e 's/àƒâ‚¬/ä/g' -e 's/â€˜//g' \
      -e 's/â€œ/“/g' -e 's/â€/”/g' -e 's/â€¹/‹/g' -e 's/â€º/›/g' \
      -e 's/â€”/—/g' -e 's/â€“/—/g' -e 's/â€?/”/g' -e 's/àƒ’/à/g' \
      -e 's/â’€’™/’/g' -e 's/â’€’œ/“/g' -e 's/â’€?/”/g' -e 's/àƒ’©/é/g' \
      -e 's/â’€’¦//g' -e 's/â€“/\&bull;/g' \
      -e 's/Ã…/Å/g' -e 's/Ã¥/å/g' -e 's/Ã¦/æ/g' -e 's/Ã˜/Ø/g' -e 's/Ã¸/ø/g' \
      -e 's/Ã™/Ù/g' -e 's/Ãœ/Ü/g' -e 's/Ã›/Û/g' -e 's/Ã‡/Ç/g' $i > $i.new
    echo done
  done
}

function switch-dns() {
  local DNS
  local NEW_DNS="192.168.0.7"
  local CONNECTION
  CONNECTION=$(nmcli -g name,device con show --active| grep eth0 | cut -f1 -d:)
  DNS=$(nmcli -t -f IP4.DNS device show eth0)
  if [[ $DNS == "IP4.DNS[1]:192.168.0.7" ]]; then
    NEW_DNS="1.1.1.1"
    nmcli connection modify "$CONNECTION" +ipv4.ignore-auto-dns yes
  else
    nmcli connection modify "$CONNECTION" +ipv4.ignore-auto-dns no
  fi

  nmcli connection modify "$CONNECTION" ipv4.dns "$NEW_DNS"
  nmcli con up "$CONNECTION"

  cat /etc/resolv.conf
}

function check_if_ip_is_free() {
  local IP=$1
  echo "================ $IP ================"
  if [[ $PLATFORM == 'Darwin' ]]; then
    ping -c1 -t2 "${IP}"
  else
    ping -c1 -w2 "${IP}"
  fi
  wget -S -T 2 --tries 1 "http://${IP}" -O /dev/null
  wget -S -T 2 --tries 1 "http://${IP}:8080" -O /dev/null
  wget -S -T 2 --tries 1 "https://${IP}" -O /dev/null
  ssh -oConnectTimeout=2 "${IP}"
  dig -x +timeout=1 "${IP}" @ns.tv2.dk
}
