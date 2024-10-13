#!/bin/bash

ProfileVersion="2.1.0"

COMMON_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Function to add profile line if it doesn't exist
add_profile_line() {
    local profile_file="$1"
    local profile_name="$2"
    local profile_str="source $profile_name"

    if grep -q "$profile_str" "$profile_file"; then
        echo "$profile_name Profile exists in $profile_file"
    else
        echo "$profile_str" >>"$profile_file"
        echo "Added $profile_name in $profile_file successfully"
    fi
}

#--------------------------------------
# Function to Check if the directory is not already in PATH before adding it
# [Original PATH] export PATH=/usr/local/bin:/usr/bin:/bin:/usr/games
#--------------------------------------

add_to_path() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH=$PATH:$1
    fi
}

#--------------------------------------
# Function to move to desktop quickly
#--------------------------------------

desktop() {
    cd $HOME/Desktop || return 1
    trace "Moved to Desktop :) "
}

#--------------------------------------
# Function to move to downloads quickly
#--------------------------------------
downloads() {
    cd $HOME/Downloads || return 1
    trace "Moved to Downloads :) "
}

#--------------------------------------
# Function to move to desktop quickly
# If input is not provided, it will print "Moved to projects folder",
# and if input is provided, it will trace "Moved to <folder_name> folder".
# Additionally, I added error handling to exit the function if cd fails.
#--------------------------------------
openProjects() {
    # PROJECTS_FOLDER is supplied by the function calling this common.sh
    cd "$PROJECTS_FOLDER/$1" || return 1
    if [ -z "$1" ]; then
        trace "Moved to projects folder"
    else
        trace "Moved to $1 folder"
    fi
}

#--------------------------------------
# Function to edit zshrc
#--------------------------------------

prof() {
    trace "Opening Visual Studio Code to edit the bash profile"
    (
        cd $BASH_SCRIPTS_FOLDER
        code . 1>/dev/null
    )
}

trace() {
    echo "==========================================================="
    echo -e "$1"
    echo "==========================================================="
}

# Source: http://patorjk.com/software/taag/#p=display&f=Graffiti&t=bhatvive
# http://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=vivekbhat
#--------------------------------------
# :-|
#--------------------------------------
vivek() {
    trace "${CYAN}
██╗   ██╗██╗██╗   ██╗███████╗██╗  ██╗   ██████╗ ██╗  ██╗ █████╗ ████████╗
██║   ██║██║██║   ██║██╔════╝██║ ██╔╝   ██╔══██╗██║  ██║██╔══██╗╚══██╔══╝
██║   ██║██║██║   ██║█████╗  █████╔╝    ██████╔╝███████║███████║   ██║   
╚██╗ ██╔╝██║╚██╗ ██╔╝██╔══╝  ██╔═██╗    ██╔══██╗██╔══██║██╔══██║   ██║   
 ╚████╔╝ ██║ ╚████╔╝ ███████╗██║  ██╗██╗██████╔╝██║  ██║██║  ██║   ██║   
  ╚═══╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   
${NC}
"
}


# Function to check if Oh My Bash is installed
check_oh_my_bash() {
    if [ ! -d "$HOME/.oh-my-bash" ]; then
        echo "Oh My Bash is not installed."
        read -p "Would you like to install it? (y/n): " install_choice
        if [[ "$install_choice" =~ ^[Yy]$ ]]; then
            # Install Oh My Bash
            echo "Installing Oh My Bash..."
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
            echo "Oh My Bash has been installed."
        else
            echo "Skipping Oh My Bash installation."
        fi
    else
        echo "Oh My Bash is already installed."
    fi
}


