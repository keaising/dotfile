#!/bin/bash
# Claude Code status line script
# Displays: model name | token usage (percentage + absolute)

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Unknown Model"')

used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
used_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_tokens=$(echo "$input" | jq -r '.context_window.context_window_size // 0')

if [ -n "$used_pct" ] && [ "$total_tokens" -gt 0 ] 2>/dev/null; then
  used_pct_fmt=$(printf "%.1f" "$used_pct")
  used_k=$(echo "$used_tokens $total_tokens" | awk '{printf "%.1fk/%.0fk", $1/1000, $2/1000}')
  ctx_str="CTX ${used_pct_fmt}% (${used_k})"
else
  ctx_str="CTX --"
fi

printf "%s | %s" "$model" "$ctx_str"
