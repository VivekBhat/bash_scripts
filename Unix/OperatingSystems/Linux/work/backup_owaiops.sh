#!/bin/bash

# Function to commit and push changes with today's date and time as the commit message
function backup_owaiops() {
    # Change to the repository directory
    (
        cd "$REPO_DIR" || {
            echo "Repository directory not found: $REPO_DIR"
            exit 1
        }

        # Check if there are changes to commit
        if git diff-index --quiet HEAD --; then
            echo "No changes to commit."
        else
            # Get today's date and time in YYYY-MM-DD HH:MM:SS format
            commit_message=$(date +"%Y-%m-%d %H:%M:%S")
            trace "commit message=$commit_message"

            # Check if the remote is set
            if ! git remote get-url origin >/dev/null 2>&1; then
                echo "Remote 'origin' is not set. Setting remote to https://github.com/VivekBhat/pvt_owaiops.git"
                git remote add origin https://github.com/VivekBhat/pvt_owaiops.git
            fi

            # Stage all changes
            git add .

            # Commit with today's date and time as the message
            git commit -m "$commit_message"

            # Push to the current branch
            git push origin $(git branch --show-current)

            # Confirmation message
            echo "Changes committed and pushed with message: $commit_message"
        fi
    )
}

function zip_folder() {
    local TARGET_DIR="/home/vivekbhat/Projects/owaiops/fault-localization-service-terraform"
    local ZIP_FILE="/home/vivekbhat/Projects/private/owaiops_backup/backup.zip"
    local EXCLUDES=("*.git/*" "*.terraform/*")

    # Create the zip file excluding the specified directories
    zip -r "$ZIP_FILE" "$TARGET_DIR" -x "${EXCLUDES[@]}"

    echo "Zipping complete: $ZIP_FILE"
}
