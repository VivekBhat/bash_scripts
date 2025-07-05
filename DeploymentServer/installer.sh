#!/bin/bash

DS_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SCRIPTS_FOLDER=$(dirname "$DS_SCRIPT_DIR")

source $SCRIPTS_FOLDER/Linux/bash_lib/common.sh

# Add ZSH Profile line
add_profile_line ~/.zshrc $DS_SCRIPT_DIR/zsh_profile

# Add Bash Profile line
add_profile_line ~/.bashrc $DS_SCRIPT_DIR/bash_profile
