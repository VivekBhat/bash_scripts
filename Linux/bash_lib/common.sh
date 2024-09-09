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
