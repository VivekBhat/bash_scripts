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

# setopt KSH_ARRAYS
