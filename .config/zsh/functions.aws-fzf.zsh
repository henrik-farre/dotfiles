# Based on https://github.com/furikake/aws-cli-helper/blob/master/.aws_functions
function aws-profiles() {
  aws configure list-profiles | sort
}

function aws-profile-set() {
  if [[ -n "$1" ]]; then
    profile="$1"
  elif [[ -z "$1" ]]; then
    if ! [ -x "$(command -v fzf)" ]; then
      echo "please install fzf to make your life easier: fzf (https://github.com/junegunn/fzf)" >&2
      return 1
    fi
    profile=$(aws-profiles | fzf -0 -1 --tac -q "${1:-""}" --prompt "> ")
  fi

  if [[ -z "$profile" ]]; then
    echo "Profile required"
    return 1
  fi

  export AWS_PROFILE="$profile"
}
