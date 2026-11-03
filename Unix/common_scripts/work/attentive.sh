#!/bin/bash
# Attentive work helpers. Keep this file generic: no account IDs, internal
# URLs or repo names. Put anything sensitive in ~/.attentive_local.sh
# (outside this repo); it is sourced at the end if it exists.
# macOS only: does nothing on other systems.

if [ "$(uname -s)" != "Darwin" ]; then
    return 0 2>/dev/null || exit 0
fi

export ATTN_REPO_DIR="$PROJECTS_FOLDER/attentive"
export REPO_DIR="$ATTN_REPO_DIR"   # used by workon <repo>

# Jump to work repos: `attn` or `attn <repo>`
attn() {
    mkdir -p "$ATTN_REPO_DIR"
    cd "$ATTN_REPO_DIR/$1" || return 1
}

# AWS: assume a Granted profile and export creds into this shell
# Usage: awsp <profile-name>   (profiles live in ~/.aws/config)
awsp() {
    if [ -z "$1" ]; then
        echo "Usage: awsp <profile>"
        grep -o '^\[profile [^]]*' ~/.aws/config 2>/dev/null | sed 's/\[profile /  /'
        return 1
    fi
    GRANTED_ALIAS_CONFIGURED="true" assume --ex --es "$1" && export AWS_PROFILE="$1"
}

# Clear assumed AWS credentials from this shell
awsclear() {
    unset AWS_PROFILE AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN \
        AWS_REGION AWS_DEFAULT_REGION AWS_CREDENTIAL_EXPIRATION
    echo "AWS credentials cleared"
}

# btr (Attentive DevOps CLI) shortcuts
alias cx='btr cortex'
alias cxget='btr cortex get'

# kubectl
alias k='kubectl'
alias kctx='kubectl config current-context'

[ -f "$HOME/.attentive_local.sh" ] && source "$HOME/.attentive_local.sh"
