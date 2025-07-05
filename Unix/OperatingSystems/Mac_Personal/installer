#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Function to add profile line if it doesn't exist
add_profile_line() {
    local profile_file="$1"
    local profile_name="$2"
    local profile_str="source $(pwd)/$profile_name"

    if grep -q "$profile_str" "$profile_file"; then
        echo "$profile_name Profile exists in $profile_file"
    else
        echo "$profile_str" >>"$profile_file"
        echo "Added $profile_name in $profile_file successfully"
    fi
}

(
    cd $SCRIPT_DIR
    # Add ZSH Profile line
    add_profile_line ~/.zshrc zsh_profile

    # Add Bash Profile line
    add_profile_line ~/.bashrc bash_profile
)
