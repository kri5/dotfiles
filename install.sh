#!/usr/bin/env bash

# Get the current script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#Installing Nix package manager
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# source freshly installed nix
. ~/.nix-profile/etc/profile.d/nix.sh

# create symlink in order to have nix config file at the correct location
# we can't use stow yet for those directories as it might be runned
# before stow is even installed
ln -sf ${SCRIPT_DIR}/nix/.config/nix ${HOME}/.config/nix
ln -sf ${SCRIPT_DIR}/home-manager/.config/home-manager ${HOME}/.config/home-manager

nix run home-manager/master -- switch
