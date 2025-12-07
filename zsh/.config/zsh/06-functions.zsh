# measure zsh start time
timezsh() {
    for i in {1..3}; do
        /usr/bin/time zsh -i -c exit 2>&1 | grep real
    done | awk '/real/ {sum += $2; count++} END {printf "average: %.2fs\n", sum/count}'
}
