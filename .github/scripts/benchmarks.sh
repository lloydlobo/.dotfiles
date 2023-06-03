#!/bin/bash
# shellcheck disable=SC2034
# https://github.com/yutkat/dotfiles/blob/main/.github/scripts/benchmark.sh
# https://zenn.dev/odan/articles/17a86574b724c9

# -e exit immediately if any command in the script exits with a non-zero status (indicating an error).
# -u treat unset variables as an error and exit.
set -eu

# Loop measures zsh shell execution time and redirecting output to standard output.
# zsh shell runs in login interactive mode, loading ~/.zshrc and immediately exits.
# Loop output is redirected to /tmp/zsh-load-time.txt , discarding errors.
{ for i in $(seq 1 10); do
    /usr/bin/time --format="%e" -o /dev/stdout zsh -li --rcs ~/.zshrc -c exit;
  done;
} >/tmp/zsh-load-time.txt 2>/dev/null

ZSH_LOAD_TIME=$(awk '{ total += $1 } END { print total/NR }' /tmp/zsh-load-time.txt)

# HACK: removes ansi escape sequences on the last line.
head -n -1 /tmp/zsh-load-time.txt | tee /tmp/zsh-load-time.txt>/dev/null

cat <<EOJ
[
  {
      "name": "zsh load time",
      "unit": "Second",
      "value": ${ZSH_LOAD_TIME},
  }
]
EOJ
