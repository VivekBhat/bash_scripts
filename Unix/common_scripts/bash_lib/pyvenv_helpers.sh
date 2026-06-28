#!/bin/bash

# Deprecated: Use workon instead of pyvenv_here for better functionality and user experience.
# pyvenv_here creates a virtual environment in ~/.virtualenvs based on the current folder name,
# while workon creates a local .venv in the project directory and offers to install dependencies 
# from requirements.txt if it exists. workon also provides tab completion for project names based on subdirectories
function pyvenv_here() {
    local venv_path=".venv"
    if [ ! -d "$venv_path" ]; then
        echo "Creating virtual environment..."
        uv venv "$venv_path" || return 1
    fi
    source "$venv_path/bin/activate"
    echo "Activated virtual environment at $(pwd)/.venv"
}

function workon ()
{
    if [[ "$1" == "-h" ]]; then
        echo "Usage: workon";
        echo "Activates the local Python virtual environment (./.venv).";
        echo "Offers to create it if it is missing.";
        return 0;
    fi;

    local project="$1"
    local project_dir

    if [[ $project == "." ]]; then
        project_dir="$PWD"
    else
        project_dir="$REPO_DIR/$project"
    fi

    local venv_dir="$project_dir/.venv"
    local created=0

    # Check for local .venv
    if [[ ! -d "$venv_dir" ]]; then
        read -p "No local virtual environment found at $venv_dir. Create it now? [Y/n] " yn
        case "$yn" in
            [nN]*)
                echo "Aborted."
                return 1
            ;;
            *)
                echo "Creating virtual environment..."
                (cd `dirname $venv_dir` && uv venv) || {
                    echo "Error: Failed to create virtual environment."
                    return 1
                }
                created=1
            ;;
        esac
    fi

    # Activate the local environment
    cd "$project_dir"
    source "$venv_dir/bin/activate" || {
        echo "Error: Could not activate $venv_dir"
        return 1
    }

    echo "Activated: $venv_dir"

    # Handle requirements.txt if we just created the venv
    if [[ -f "requirements.txt" && $created -eq 1 ]]; then
        read -p "requirements.txt found. Install dependencies? [Y/n] " yn
        case "$yn" in
            [nN]*)
                echo "Skipping installation."
            ;;
            *)
                uv pip install --upgrade pip
                uv pip install -r requirements.txt || echo "Warning: Some requirements failed to install."
            ;;
        esac
    fi
}
_mytabcomplete() {
    local cur
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"

    # Check if $REPO_DIR is set and is a directory
    if [[ -n "$REPO_DIR" && -d "$REPO_DIR" ]]; then
        # Generate completions based on subdirectory names in $REPO_DIR
        COMPREPLY=( $(compgen -d -- "${REPO_DIR}/${cur}" | sed "s|${REPO_DIR}/||") )
    fi

    return 0
}

complete -F _mytabcomplete workon
