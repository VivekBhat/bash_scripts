#!/usr/bin/env bash
# Clones or updates all hnsdevops Bitbucket repos into $REPO_DIR.
# - If a repo directory doesn't exist, it clones it.
# - If it already exists, it fetches and pulls the default branch.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPOS_FILE="${SCRIPT_DIR}/repos.txt"
DEST_DIR="${REPO_DIR:?REPO_DIR is not set}"
BB_ORG="git@bitbucket.org:hnsdevops"

if [[ ! -f "$REPOS_FILE" ]]; then
  echo "ERROR: repos.txt not found at $REPOS_FILE"
  exit 1
fi

echo "Syncing repos to: $DEST_DIR"
echo "---"

success=0
failed=0

while IFS= read -r repo; do
  [[ -z "$repo" || "$repo" =~ ^# ]] && continue

  repo_path="${DEST_DIR}/${repo}"

  if [[ -d "$repo_path/.git" ]]; then
    echo "[update] $repo"
    if git -C "$repo_path" fetch --all --prune && git -C "$repo_path" pull --ff-only; then
      ((success++))
    else
      echo "  WARNING: pull failed for $repo (maybe diverged), skipping"
      ((failed++))
    fi
  else
    echo "[clone] $repo"
    if git clone "${BB_ORG}/${repo}.git" "$repo_path"; then
      ((success++))
    else
      echo "  WARNING: clone failed for $repo"
      ((failed++))
    fi
  fi
done < "$REPOS_FILE"

echo "---"
echo "Done. success=$success failed=$failed"
