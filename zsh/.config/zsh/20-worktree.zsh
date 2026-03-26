# ── Helpers ──────────────────────────────────────────────────

_wt_main_root() {
  git worktree list --porcelain | sed -n 's/^worktree //p' | head -1
}

_wt_base() {
  echo "$(dirname "$(_wt_main_root)")/worktrees"
}

# Output: path|branch per line
_wt_list() {
  git worktree list --porcelain | awk '
    /^worktree / { p=$2 }
    /^branch /   { b=$2; sub(/refs\/heads\//, "", b); print p"|"b; p=b="" }
  '
}

_wt_find() {
  _wt_list | awk -F'|' -v b="$1" '$2==b {print $1; exit}'
}

_wt_check_allowed_dir() {
  local ALLOWED_DIRS=("$HOME/code/github.com/troph-team/workspace")
  local cwd=$(pwd)
  for dir in "${ALLOWED_DIRS[@]}"; do
    if [[ "$cwd" == "$dir" ]] || [[ "$cwd" == "$dir"/* ]]; then
      return 0
    fi
  done
  echo "Error: Not in allowed directory. Current: $cwd" >&2
  return 1
}

# ── Commands ─────────────────────────────────────────────────

wt() {
  _wt_check_allowed_dir || return 1
  local cmd=${1:-""}; shift 2>/dev/null

  case "$cmd" in
    co)
      if [[ $# -gt 0 ]]; then
        local target=$(_wt_find "$1")
        if [[ -z "$target" ]]; then
          echo "No worktree for '$1'. Use 'wt new $1' to create one." >&2
          return 1
        fi
        cd "$target"
        return
      fi

      # Interactive: select from all branches, auto-create worktree if needed
      local selected
      selected=$(git for-each-ref --sort=-creatordate --format='%(refname:short)' refs/heads/ | \
        fzf --height=40% --reverse --prompt="Select branch: ") || return 0

      local existing=$(_wt_find "$selected")
      if [[ -n "$existing" ]]; then
        cd "$existing"
      else
        local wt_path="$(_wt_base)/${selected//\//-}"
        git worktree add "$wt_path" "$selected"
        cd "$wt_path"
      fi
      ;;

    new)
      if [[ $# -eq 0 ]]; then
        echo "Usage: wt new <branch> [base]" >&2
        return 1
      fi
      local branch="$1" base="${2:-HEAD}"
      local wt_path="$(_wt_base)/${branch//\//-}"

      if [[ -d "$wt_path" ]]; then
        echo "Error: $wt_path already exists" >&2
        return 1
      fi

      if git show-ref --verify --quiet "refs/heads/$branch"; then
        echo "Branch '$branch' already exists, creating worktree only"
        git worktree add "$wt_path" "$branch"
      else
        git worktree add -b "$branch" "$wt_path" "$base"
      fi
      cd "$wt_path"
      ;;

    com)
      for name in main master; do
        if git show-ref --verify --quiet "refs/heads/$name"; then
          local target=$(_wt_find "$name")
          cd "${target:-$(_wt_main_root)}"
          return
        fi
      done
      echo "Error: No main or master branch" >&2
      return 1
      ;;

    dd)
      local main_root=$(_wt_main_root)
      local selected
      selected=$(_wt_list | awk -F'|' -v m="$main_root" '$1!=m' | \
        fzf -m --height=40% --reverse --prompt="Delete (Tab=multi): " --delimiter='|' --with-nth=2) || return 0
      [[ -z "$selected" ]] && return 0

      local cwd=$(pwd)
      while IFS='|' read -r path branch; do
        if [[ "$cwd" == "$path"* ]]; then
          echo "Error: You're in $path, run 'wt com' first" >&2
          return 1
        fi
      done <<< "$selected"

      while IFS='|' read -r path branch; do
        echo "Removing: $path ($branch)"
        git worktree remove "$path" --force
        read -q "REPLY?Delete branch '$branch'? [y/N] " </dev/tty || true; echo
        [[ $REPLY =~ ^[Yy]$ ]] && git branch -D "$branch" || echo "Kept: $branch"
      done <<< "$selected"
      ;;

    br)
      git worktree list
      ;;

    *) echo "Usage: wt {co|new|com|dd|br}" >&2; return 1 ;;
  esac
}
