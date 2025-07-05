#!/bin/bash

DS_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SCRIPTS_FOLDER=$(dirname "$DS_SCRIPT_DIR")

source $SCRIPTS_FOLDER/Linux/bash_lib/common.sh

# Check for Oh My Bash installation
check_oh_my_bash

# Add Bash Profile line
add_profile_line ~/.bashrc $DS_SCRIPT_DIR/bash_profile
