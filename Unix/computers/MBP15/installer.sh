#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
source $UNIX_SCRIPT_DIR/common_scripts/bash_lib/common.sh

check_and_install_zsh

# Add ZSH Profile
add_profile_line ~/.zshrc $SCRIPT_DIR/profile

# Add Bash Profile
add_profile_line ~/.bashrc $SCRIPT_DIR/profile
