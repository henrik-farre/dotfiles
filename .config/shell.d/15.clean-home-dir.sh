#!/bin/bash

export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"
export ANDROID_HOME="$XDG_DATA_HOME/android"

export ANSIBLE_HOME="${XDG_DATA_HOME}/ansible"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
#
#     export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
#     export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
#
# [bpython]: $HOME/.pythonhist
#
#   You can overwrite this in the config file:
#
#   (XDG_CONFIG_HOME/bpython/config)
#
#     [general]
#     hist_file = $XDG_DATA_HOME/bpythonhistory

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

#[git]: $HOME/.gitconfig
#
#  XDG is supported out-of-the-box, so we can simply move the file to XDG_CONFIG_HOME/git/config.
#

export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

#[nss]: $HOME/.pki
#
#  XDG is supported out-of-the-box, so we can simply move the file to XDG_DATA_HOME/pki.


#[python]: $HOME/.python_history
#
#  Export the following environment variables:
#
#    export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
#
#  Now create the file pythonrc, and put the following code into it:
#
#    import os
#    import atexit
#    import readline
#
#    history = os.path.join(os.environ['XDG_CACHE_HOME'], 'python_history')
#    try:
#        readline.read_history_file(history)
#    except OSError:
#        pass
#
#    def write_history():
#        try:
#            readline.write_history_file(history)
#        except OSError:
#            pass
#
#    atexit.register(write_history)
#
#  Credit: https://unix.stackexchange.com/a/675631/417527

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"

#  Export the following environment variables:
#
#    ZDOTDIR=$HOME/.config/zsh
#
#  You can do this in /etc/zsh/zshenv.
