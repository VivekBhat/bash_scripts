#!/bin/bash
#--------------------------------------
# Function to move to OneWeb Projects quickly
#--------------------------------------
export REPO_DIR=$HOME/Projects/owaiops

function ow() {
    mkdir -p $REPO_DIR
    cd $REPO_DIR
    trace "Moved to OneWeb AIOps project folder :) "
    ll
}

function ws() {
    local workspaces=$REPO_DIR/workspaces
    mkdir -p $workspaces
    cd $workspaces
    trace "Moved to OneWeb AIOps Workspaces folder :) "
    ll
}

function workon() {
    source $HOME/.virtualenvs/$1/bin/activate
    cd $REPO_DIR/$1
}

function pyvenv_here() {
    folder_name=$(basename "$(pwd)")
    echo folder=$folder_name
    venv_path="$HOME/.virtualenvs/$folder_name"
    echo venv_path=$venv_path
    if [ ! -d "$venv_path" ]; then
        echo "Creating virtual environment for $folder_name..."
        python3 -m venv "$venv_path"
    fi

    source "$venv_path/bin/activate"
    echo "Activated virtual environment for $folder_name."
}

export FLINK_HOME=$HOME/Projects/owaiops
export MLAIOPS_MASTER_PASSWORD_FILE=$HOME/.credentials/iactl_creds
export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
export GRADLE_HOME="/opt/gradle/latest"
export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"

# Add directories to PATH using the custom function
add_to_path $HOME/go/bin
add_to_path $HOME/flink/bin
add_to_path /usr/local/go/bin
add_to_path $HOME/.local/bin
add_to_path ${GRADLE_HOME}/bin
add_to_path /usr/local/apache-maven-3.9.6/bin

# setopt KSH_ARRAYS
