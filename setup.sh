#!/bin/bash

# LINKS is an associative list containing a set of src->dest elements for which
# symlinks will be created. Base dir for src is ~, for dest it's the location
# of this script
LINKS=(
    ".tmux.conf.local->.tmux.conf.local"
    ".tmux.conf->.tmux/.tmux.conf"
    ".bashrc_olli->.bashrc_olli"
    ".bashrc_ssh->.bashrc_ssh"
)

LINKS_WORK=(
    ".bashrc_work->.bashrc_work"
)

readonly SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
readonly HOMEPATH=~

function create_symlink() {
    src=${HOMEPATH}/${str%%->*}
    dst=${SCRIPTPATH}/${str##*->}
    echo "Linking from ${src} to ${dst}"
    ln -vs ${dst} ${src}
}

for ((i = 0; i < ${#LINKS[@]}; i++))
do
    str="${LINKS[$i]}"
    create_symlink ${str}
done

if [[ $1 = "-w" ]]
then
    for ((i = 0; i < ${#LINKS_WORK[@]}; i++))
    do
        str="${LINKS_WORK[$i]}"
        create_symlink ${str}
    done
fi

echo "This did not install fzf yet, run fzf installer if you want that"
