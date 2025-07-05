#!/bin/bash

# backup_owaiops.sh
# Purpose: Automates the backup process for OWAI Operations repository by:
#   1. Committing and pushing changes to Git
#   2. Creating a zip backup of the terraform service directory
#
# Dependencies:
#   - git
#   - zip
#   - $REPO_DIR environment variable must be set
#   - trace function must be available in the environment

# Function: backup_owaiops
# Description: Commits and pushes changes to the OWAI Operations repository
# Uses the current date/time as commit message in YYYY-MM-DD HH:MM:SS format
# Will set up remote origin if not configured
function backup_owaiops() {
    # Change to the repository directory
    (
        cd "$REPO_DIR" || {
            echo "ERROR: Repository directory not found: $REPO_DIR"
            exit 1
        }

        # Check if there are changes to commit
        if git diff-index --quiet HEAD --; then
            echo "INFO: No changes to commit."
        else
            # Get today's date and time in YYYY-MM-DD HH:MM:SS format
            commit_message=$(date +"%Y-%m-%d %H:%M:%S")
            trace "INFO: commit message=$commit_message"

            # Check and configure remote if necessary
            if ! git remote get-url origin >/dev/null 2>&1; then
                echo "INFO: Remote 'origin' is not set. Setting remote to https://github.com/VivekBhat/pvt_owaiops.git"
                git remote add origin https://github.com/VivekBhat/pvt_owaiops.git
            fi

            # Stage all changes
            git add .

            # Commit with today's date and time as the message
            git commit -m "$commit_message"

            # Push to the current branch
            current_branch=$(git branch --show-current)
            git push origin "$current_branch"

            echo "SUCCESS: Changes committed and pushed with message: $commit_message"
        fi
    )
}

# Function: zip_folder
# Description: Creates a zip backup of the fault-localization-service-terraform directory
# Excludes .git and .terraform directories to reduce size and avoid including unnecessary files
# Parameters: None
# Output: Creates a zip file at /home/vivekbhat/Projects/private/owaiops_backup/backup.zip
function zip_folder() {
    local TARGET_DIR="/home/vivekbhat/Projects/owaiops/fault-localization-service-terraform"
    local ZIP_FILE="/home/vivekbhat/Projects/private/owaiops_backup/backup.zip"
    local EXCLUDES=("*.git/*" "*.terraform/*")

    # Ensure target directory exists
    if [ ! -d "$TARGET_DIR" ]; then
        echo "ERROR: Target directory does not exist: $TARGET_DIR"
        return 1
    fi

    # Create backup directory if it doesn't exist
    mkdir -p "$(dirname "$ZIP_FILE")"

    # Create the zip file excluding the specified directories
    zip -r "$ZIP_FILE" "$TARGET_DIR" -x "${EXCLUDES[@]}"

    if [ $? -eq 0 ]; then
        echo "SUCCESS: Backup created at: $ZIP_FILE"
    else
        echo "ERROR: Failed to create backup zip file"
        return 1
    fi
}
