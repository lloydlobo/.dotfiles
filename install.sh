#!/usr/bin/bash

INSTALL_COMMANDS=$(cat install-commands)

IFS=$'\n' read -d '' -ra commands <<< "$INSTALL_COMMANDS"

for cmd in "${commands[@]}"; do
    echo "$ $cmd"
    eval "$cmd"
done

