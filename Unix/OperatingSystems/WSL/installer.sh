#!/bin/bash

WSL_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SCRIPTS_FOLDER=$(dirname "$WSL_SCRIPT_DIR")

source $SCRIPTS_FOLDER/Linux/bash_lib/common.sh

check_oh_my_bash
check_github_desktop_automatic_update

# Add Bash Profile line
add_profile_line ~/.bashrc $WSL_SCRIPT_DIR/bash_profile
