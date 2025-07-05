#!/bin/bash

export UNIX_SCRIPT_DIR=$(dirname "$0")
# Define the directory containing the operating systems
PC_DIR="$UNIX_SCRIPT_DIR/computers"

# Source this file for the functions to be available
source $UNIX_SCRIPT_DIR/common_scripts/bash_lib/common.sh

# Function to display available OSs
function list_os() {
    echo "Available Operating Systems:"

    # Check if the directory exists
    if [[ -d "$PC_DIR" ]]; then
        local os_count=0
        for dir in "$PC_DIR"/*; do
            if [[ -d "$dir" ]]; then
                echo " [$os_count] $(basename "$dir")" # Print directory name
                os_count=$((os_count + 1))
            fi
        done

        if [[ $os_count -eq 0 ]]; then
            echo "No operating systems found."
            exit 1
        fi
    else
        echo "Directory $PC_DIR does not exist."
        exit 1
    fi
}

# Function to run the installer script in the selected directory
function run_installer() {
    local choice=$1
    local selected_dir="$(find "$PC_DIR" -mindepth 1 -maxdepth 1 -type d | sort | sed -n "$((choice + 1))p")"
    if [[ -f "$selected_dir/installer.sh" ]]; then
        echo "Setting up $(basename "$selected_dir")..."
        bash "$selected_dir/installer.sh"
    else
        echo "No installer script found in $(basename "$selected_dir")."
    fi
}

# Main script execution
list_os

# Get the total number of directories
total_dirs=$(find "$PC_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l)

# Prompt for user input
read -p "Select an operating system by entering the corresponding number: " user_input

# Validate the input and run the installer if valid
if [[ "$user_input" =~ ^[0-9]+$ ]]; then
    if [[ "$user_input" -ge 0 ]] && [[ "$user_input" -lt "$total_dirs" ]]; then
        run_installer "$user_input"
    else
        echo "Invalid input. Please enter a number within the range 0 to $((total_dirs - 1))."
        exit 1
    fi
else
    echo "Invalid input. Please enter a number."
    exit 1
fi
