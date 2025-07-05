#!/bin/bash
#####################################################
# First run the Unix/installer.sh to install in WSL #
#####################################################

SCRIPT_DIR=$(dirname "$0")
source $UNIX_SCRIPT_DIR/common_scripts/bash_lib/common.sh

check_oh_my_bash
check_github_desktop_automatic_update

# Add Bash Profile line
add_profile_line ~/.bashrc $WSL_SCRIPT_DIR/bash_profile
