#!/usr/bin/bash

app="Distrohop"

packages=$(cat ./.install-packages)

if [[ -z $packages ]]; then exit 0; fi

target_dir="$HOME" # Set the target directory where the files will be linked.
os=$(uname -s) # Detect the operating system.
distro=$(uname -n) # nodename.
kernel_release=$(uname -r)

# Define the installation prefix commands for different distros.
declare -A distro_prefixes
distro_prefixes["debian"]="sudo apt-get install"
distro_prefixes["ubuntu"]="sudo apt-get install"
distro_prefixes["fedora"]="sudo dnf install"
distro_prefixes["centos"]="sudo yum install"

with_left_pad="  "

prefix_cmd=${distro_prefixes[$distro]}

# Check if the nodename is associated with a known distribution.
if [ -z "$prefix_cmd" ];then
    echo "${with_left_pad}Unknown distribution or we don't have the installation command or not a Linux system."
    echo "${with_left_pad}Enter the command prefix (e.g., sudo apt-get install): "
    read -r custom_prefix_cmd # TODO: Handle if user exits with: `exit 1`.
    prefix_cmd=${custom_prefix_cmd:-$prefix_cmd}
fi

# Usage: log_pad "hello" 4 "~"
# Output: ~~~~hello
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

success() { local as_green="\e[32m$1\e[0m"; return "$as_green"; }

error(){ local as_yellow="\e[33m$1\e[0m"; return "$as_yellow"; }

print_os_info(){
    log_pad "OS      -  $os"
    log_pad "Host    -  $distro"
    log_pad "Kernel  -  $kernel_release"
    log_pad "Target  -  target_dir: $target_dir"
}

# FIXME: sed doesn't clear empty line and also prefixes them. `sed` command
# is prepends 4 spaces to the beginning of each line in the specified files.
print_pkg_lang_info(){
    packages_pretty=$(sed 's/^/  -  /' ./.install-packages)
    printf "\n"
    log_pad "🔌 Packages"
    echo "$packages_pretty"
}

run_install(){
    log_pad "${with_left_pad}Installation prefix command for $distro: $prefix_cmd"
    for package_name in ${packages[0]}; do
        log_pad "🔌 $app is installing $package_name..."
        eval "$prefix_cmd $package_name"
        log_pad "⚡ $app installed $package_name"
    done
}

dotfiles_dirs=$(ls -a)

# `-n` Run `stow` in simulation mode as to not modify filesystem.
# stow --dir="$PWD" --target="$target_dir" "$package_name"
run_stow(){
    if [ "$os" == "Linux" ]; then
        for package_name in ${packages[0]}; do
            log_pad "🔌 $app is linking $package_name..."
            stow "$package_name"
            if [ $? -eq 0 ]; then
                log_pad "⚡ $app linked $package_name"
            else
                log_pad "⚠️  $app Error occured while linking $package_name"
            fi
        done
    elif [ "$os" == "Darwin" ]; then
        for package_name in ${packages[0]}; do
            log_pad "🔌 $app is linking $package_name..."
            stow "$package_name"
            # stow --dir="$PWD" --target="$target_dir" "$package_name"
            if [ $? -eq 0 ]; then
                log_pad "⚡ $app linked $package_name"
            else
                log_pad "⚠️ $app Error occured while linking $package_name"
            fi
        done
    fi
}

main() {
    log_pad "⚡ $app - dotfiles installer"
    print_os_info
    print_pkg_lang_info
    #run_install
    run_stow
    printf "\n"
    log_pad "⚡ Goodbye from $app!" 2
}

main
