#!/bin/bash

# Define the directory containing the operating systems
os_dir="$(dirname "$(realpath "$0")")/OperatingSystems"

# Function to display available OSs
list_os() {
    echo "Available Operating Systems:"
    
    # Check if the directory exists
    if [[ -d "$os_dir" ]]; then
        local os_count=0
        for dir in "$os_dir"/*; do
            if [[ -d "$dir" ]]; then
                echo " [$os_count] $(basename "$dir")"  # Print directory name
                os_count=$((os_count + 1))
            fi
        done
        
        if [[ $os_count -eq 0 ]]; then
            echo "No operating systems found."
            exit 1
        fi
    else
        echo "Directory $os_dir does not exist."
        exit 1
    fi
}

# Function to run the installer script in the selected directory
run_installer() {
    local choice=$1
    local selected_dir="$(find "$os_dir" -mindepth 1 -maxdepth 1 -type d | sed -n "$((choice + 1))p")"
    
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
total_dirs=$(find "$os_dir" -mindepth 1 -maxdepth 1 -type d | wc -l)

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
