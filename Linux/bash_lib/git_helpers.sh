function git_delete_merged_local_branches() {
    git fetch -p
    # Following command deletes local branches that have been merged into the current branch
    git branch --merged | grep -v "\*" | xargs git branch -d
}

alias gl='git log --decorate --graph --oneline --all -16'
alias gll='git log --decorate --graph --oneline --all'
alias glv='git log --decorate --graph --pretty=medium --all --abbrev-commit --date=relative'
alias glvv='git log --decorate --graph --pretty=fuller --all --abbrev-commit --date=relative --name-only'
