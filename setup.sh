#!/bin/bash

# LINKS is an associative list containing a set of src->dest elements for which
# symlinks will be created. Base dir for src is ~, for dest it's the location
# of this script
LINKS=(
    ".tmux.conf.local->.tmux.conf.local"
    ".tmux.conf->.tmux/.tmux.conf"
    ".bashrc_profile->.bashrc_profile"
    ".bashrc_ssh->.bashrc_ssh"
    ".bashrc_work->.bashrc_work"
)

readonly SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
readonly HOMEPATH=~

echo "Linking from ${HOMEPATH} to ${SCRIPTPATH}"

for ((i = 0; i < ${#LINKS[@]}; i++))
do
    str="${LINKS[$i]}"
    src=${str%%->*}
    dst=${str##*->}
    ln -vs ${SCRIPTPATH}/${dst} ${HOMEPATH}/${src}
done
