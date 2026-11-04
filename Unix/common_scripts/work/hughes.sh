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

# source <(invoke --print-completion-script bash)
