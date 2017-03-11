#!/bin/bash

if [[ $(hostname) == 'workstation' ]]; then
  export GIT_COMMITTER_EMAIL="hfar@tv2.dk"
  export GIT_AUTHOR_EMAIL="hfar@tv2.dk"
  export GIT_AUTHOR_NAME="Henrik Farre"
  export GIT_COMMITTER_NAME="Henrik Farre"
fi
