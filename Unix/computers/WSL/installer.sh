#!/bin/bash
#####################################################
# First run the Unix/installer.sh to install in WSL #
#####################################################

export PROJECTS_FOLDER="$HOME/Projects"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $UNIX_SCRIPT_DIR/common_scripts/bash_lib/common.sh

check_oh_my_bash
check_github_desktop_automatic_update

# Add Bash Profile line
add_profile_line ~/.bashrc $SCRIPT_DIR/bash_profile
