#!/usr/bin/bash

app="Distrohop"

success() { local as_green="\e[32m$1\e[0m"; return "$as_green"; }

error(){ local as_yellow="\e[33m$1\e[0m"; return "$as_yellow"; }

# Usage:
# log_pad "hello" 4 "~"
# Output:
# ~~~~hello
log_pad() {
    local string=$1
    local pad_length=${2:-2} # default: 2.
    local padding_char=${3:-" "} # default: " "

    # Split input by line breaks. -d '' option read until the null character,
    # ensuring that trailing newline characters are preserved.
    IFS=$'\n' read -d '' -ra lines <<< "$string"

    for line in "${lines[@]}"; do
        printf "%-${pad_length}s""%s\n" "$padding_char" "$line"
    done
}

print_os_info() {
    target_dir="$HOME" # Set the target directory where the files will be linked.
    os=$(uname -s) # Detect the operating system.
    distro=$(uname -n) # nodename.
    kernel_release=$(uname -r)

    log_pad "OS      -  $os"
    log_pad "Host    -  $distro"
    log_pad "Kernel  -  $kernel_release"
    log_pad "Target  -  target_dir: $target_dir"
}

# TODO: Diagnostics:
# 1. Use find instead of ls to better handle non-alphanumeric filenames. [SC2012]
# 2. Use ./*glob* or -- *glob* so names with dashes won't become options. [SC2035]
run_stow() {
    dots=$(ls -d */ | tr '/' ' ') # List only directories.

    # `-n` Run `stow` in simulation mode as to not modify filesystem.
    if [ "$os" == "Linux" ]; then
        for package_name in ${dots[0]}; do
            if [ "$package_name" != "test" ]; then
                log_pad "🔌 $app is linking $package_name..."
                stow "$package_name"
                if [ $? -eq 0 ]; then
                    log_pad "⚡ $app linked $package_name"
                else
                    log_pad "⚠️  $app Error occured while linking $package_name"
                fi
            fi
        done
    elif [ "$os" == "Darwin" ]; then
        for package_name in ${dots[0]}; do
            if [ "$package_name" != "test" ]; then
                log_pad "🔌 $app is linking $package_name..."
                stow "$package_name"
                if [ $? -eq 0 ]; then
                    log_pad "⚡ $app linked $package_name"
                else
                    log_pad "⚠️ $app Error occured while linking $package_name"
                fi
            fi
        done
    fi
}

main() {
    log_pad "⚡ $app - dotfiles installer"
    print_os_info
    run_stow
    printf "\n"
    log_pad "⚡ Goodbye from $app!" 2
}

main
