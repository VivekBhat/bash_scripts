#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $UNIX_SCRIPT_DIR/common_scripts/bash_lib/common.sh

check_and_install_zsh

# Add to ZSH Profile
add_profile_line ~/.zshrc $SCRIPT_DIR/zsh_profile

# Add to Bash Profile
add_profile_line ~/.bashrc $SCRIPT_DIR/bash_profile
