_wt_get_main_repo_root() {
  git worktree list --porcelain | grep '^worktree ' | head -1 | sed 's/^worktree //'
}

_wt_get_worktrees_base() {
  local main_repo=$(_wt_get_main_repo_root)
  echo "$(dirname "$main_repo")/worktrees"
}

_wt_check_allowed_dir() {
  local ALLOWED_DIRS=(
    "$HOME/code/github.com/troph-team/workspace"
  )
  
  local current_dir=$(pwd)
  local allowed=false
  
  for dir in "${ALLOWED_DIRS[@]}"; do
    local expanded_dir="${dir/#\~/$HOME}"
    if [[ "$current_dir" == "$expanded_dir" ]] || [[ "$current_dir" == "$expanded_dir"/* ]]; then
      allowed=true
      break
    fi
  done
  
  if [[ "$allowed" != true ]]; then
    echo "Error: This command can only be run within the following directories:"
    for dir in "${ALLOWED_DIRS[@]}"; do
      echo "  - $dir"
    done
    echo ""
    echo "Current directory: $current_dir"
    return 1
  fi
  return 0
}

wt() {
  # Check if in allowed directory
  _wt_check_allowed_dir || return 1
  
  local cmd=${1:-""}
  shift || true
  
  case "$cmd" in
    co)
      if [ $# -eq 0 ]; then
        # Select from existing worktrees
        local worktree
        worktree=$(git worktree list --porcelain | grep -E '^worktree ' | sed 's/^worktree //' | fzf --height=40% --reverse --prompt="Select worktree: ") || return 0
        
        if [ -n "$worktree" ]; then
          cd "$worktree"
        fi
      else
        # Switch to existing worktree by branch name
        local branch_name="$1"
        local existing_worktree
        existing_worktree=$(git worktree list --porcelain | grep -B2 "branch refs/heads/$branch_name" | grep '^worktree ' | sed 's/^worktree //' | head -1)
        
        if [ -n "$existing_worktree" ]; then
          cd "$existing_worktree"
        else
          echo "Error: No worktree found for branch '$branch_name'"
          echo "Use 'wt new $branch_name' to create a new worktree"
          return 1
        fi
      fi
      ;;
      
    cor)
      # Create worktree from local branch - interactive only
      local branch_name
      branch_name=$(git for-each-ref --sort=-creatordate --format='%(refname:short)' refs/heads/ | \
        fzf --height=40% --reverse --prompt="Select branch to create worktree: ") || return 0
      
      if [ -z "$branch_name" ]; then
        return 0
      fi
      
      # Check if worktree already exists
      local existing_worktree
      existing_worktree=$(git worktree list --porcelain | grep -B2 "branch refs/heads/$branch_name" | grep '^worktree ' | sed 's/^worktree //' | head -1)
      
      if [ -n "$existing_worktree" ]; then
        # Worktree exists, switch to it
        cd "$existing_worktree"
      else
        # Create new worktree
        local worktree_base=$(_wt_get_worktrees_base)
        local worktree_name="${branch_name//\//-}"
        local worktree_path="${worktree_base}/${worktree_name}"
        
        git worktree add "$worktree_path" "$branch_name"
        cd "$worktree_path"
      fi
      ;;
      
    new)
      if [ $# -eq 0 ]; then
        echo "Usage: wt new <branch-name> [base-branch]"
        return 1
      fi
      
      local branch_name="$1"
      local base_branch="${2:-HEAD}"
      
      local worktree_base=$(_wt_get_worktrees_base)
      local worktree_name="${branch_name//\//-}"
      local worktree_path="${worktree_base}/${worktree_name}"
      
      if [ -d "$worktree_path" ]; then
        echo "Error: Worktree path already exists: $worktree_path"
        return 1
      fi
      
      # Check if branch already exists
      if git show-ref --verify --quiet refs/heads/"$branch_name"; then
        # Branch exists, just create worktree
        echo "Branch '$branch_name' already exists, creating worktree only"
        git worktree add "$worktree_path" "$branch_name"
      else
        # Branch doesn't exist, create both branch and worktree
        git worktree add -b "$branch_name" "$worktree_path" "$base_branch"
      fi
      cd "$worktree_path"
      ;;
      
    br)
      git worktree list
      ;;
      
    com)
      local main_repo=$(_wt_get_main_repo_root)
      local target_branch
      
      if git show-ref --verify --quiet refs/heads/main; then
        target_branch="main"
      elif git show-ref --verify --quiet refs/heads/master; then
        target_branch="master"
      else
        echo "Error: Neither main nor master branch exists"
        return 1
      fi
      
      # Check if worktree for main/master exists
      local existing_worktree
      existing_worktree=$(git worktree list --porcelain | grep -B2 "branch refs/heads/$target_branch" | grep '^worktree ' | sed 's/^worktree //' | head -1)
      
      if [ -n "$existing_worktree" ]; then
        cd "$existing_worktree"
      else
        git checkout "$target_branch"
        cd "$main_repo"
      fi
      ;;
      
    dd)
      # Remove worktrees and optionally branches
      local worktrees
      worktrees=$(git worktree list --porcelain | awk '
        /^worktree / { wt_path=$2 }
        /^branch / { 
          branch=$2
          gsub(/^refs\/heads\//, "", branch)
          if (branch != "" && wt_path != "") {
            print wt_path "|" branch
          }
          wt_path=""
          branch=""
        }
      ')
      
      if [ -z "$worktrees" ]; then
        return 0
      fi
      
      local selected
      selected=$(echo "$worktrees" | fzf -m --height=40% --reverse --prompt="Select worktrees to delete (Tab to multi-select): " --delimiter='|' --with-nth=2) || return 0
      
      if [ -z "$selected" ]; then
        return 0
      fi
      
      # Check if current directory is in any of the selected worktrees
      local current_dir=$(pwd)
      
      while IFS='|' read -r wt_path branch; do
        if [[ "$current_dir" == "$wt_path"* ]]; then
          echo "Error: You are currently in worktree: $wt_path"
          echo "Please switch to another directory first (e.g., 'wt com')"
          return 1
        fi
      done <<< "$selected"
      
      # Process each selected worktree
      while IFS='|' read -r wt_path branch; do
        echo "Removing worktree: $wt_path (branch: $branch)"
        git worktree remove "$wt_path" --force
        
        # Ask before deleting branch
        read -q "REPLY?Delete branch '$branch'? [y/N] " </dev/tty || true
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          git branch -D "$branch"
        else
          echo "Kept branch: $branch"
        fi
      done <<< "$selected"
      ;;
      
    ls)
      # List all branches with worktree status
      git for-each-ref --sort=-creatordate --format='%(refname:short)' refs/heads/ | while read branch; do
        local worktree_path
        worktree_path=$(git worktree list --porcelain | grep -B2 "branch refs/heads/$branch" | grep '^worktree ' | sed 's/^worktree //' | head -1)
        if [ -n "$worktree_path" ]; then
          echo "✓ $branch → $worktree_path"
        else
          echo "  $branch (no worktree)"
        fi
      done
      ;;
      
    prune)
      echo "Pruning stale worktrees..."
      git worktree prune -v
      ;;
      
    *)
      echo "Unknown command: $cmd"
      return 1
      ;;
  esac
}

