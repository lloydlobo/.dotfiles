#!/usr/bin/bash

app="Distrohop"

# List all the packages to install with GNU Stow.
# #packages=("package1" "package2" "package3")
packages=$(cat ./.install-packages)
languages=$(cat ./.install-languages)

if [[ -z $packages ]]; then exit 0; fi
if [[ -z $languages ]]; then exit 0; fi

# Set the target directory where the files will be linked.
target_dir="$HOME"
# Detect the operating system.
os=$(uname -s)
distro=$(uname -n) # nodename.
kernel_release=$(uname -r)

# Define the installation prefix commands for different distros.
declare -A distro_prefixes
distro_prefixes["debian"]="sudo apt-get install"
distro_prefixes["ubuntu"]="sudo apt-get install"
distro_prefixes["fedora"]="sudo dnf install"
distro_prefixes["centos"]="sudo yum install"

left_pad="  "

# Retrieve the installation prefix command based on the nodename.
prefix_cmd=${distro_prefixes[$distro]}

# Check if the nodename is associated with a known distribution.
if [ -z "$prefix_cmd" ];then
    echo "${left_pad}Unknown distribution or we don't have the installation command or not a Linux system."

    # Read the command prefix from the user.
    echo "${left_pad}Enter the command prefix (e.g., sudo apt-get install): "
    read -r custom_prefix_cmd # TODO: Handle if user exits with: `exit 1`.

    prefix_cmd=${custom_prefix_cmd:-$prefix_cmd}
fi

echo "${left_pad}Installation prefix command for $distro: $prefix_cmd"

#================================================
# REGION_START: HELPER FUNCTIONS

# Loop through each line and left-pad it.
#
# Usage: fmt_pretty "hello" 4 "~"
# Output: ~~~~hello
#
# The left_pad function takes three parameters:
# - `string` (the original string to be left-padded),
# - `pad_length` (the desired total length of the padded string), and
# - `padding_char` (the character used for padding, defaults to space if not provided).
fmt_pretty() {
    local string=$1
    local pad_length=${2:-2} # default: 2.
    local padding_char=${3:-" "} # default: " "

    # Split the input string by line breaks. The read command uses the -d ''
    # option to read until the null character, ensuring that trailing
    # newline characters are preserved.
    IFS=$'\n' read -d '' -ra lines <<< "$string"

    for line in "${lines[@]}"; do
        printf "%-${pad_length}s""%s\n" "$padding_char" "$line"
    done
}

fmt_pretty_right(){
    local string=$1
    local pad_length=${2:-2} # default: 2.
    local padding_char=${3:-" "} # default: " "
    IFS=$'\n' read -d '' -ra lines <<< "$string"
    for line in "${lines[@]}"; do
        printf "%-${pad_length}s""%s\n" "$line" "$padding_char"
    done # Loop through each line and right-pad it.
}

fmt_green() { local as_green="\e[32m$1\e[0m"; return "$as_green"; }

fmt_yellow(){ local as_yellow="\e[33m$1\e[0m"; return "$as_yellow"; }

# REGION_END: HELPER FUNCTIONS
#================================================

#================================================
# REGION_START: PRINT SYSTEM DETAILS

fmt_pretty "⚡ $app - dotfiles installer"

# Print the formatted output
fmt_pretty "OS      -  $os"
fmt_pretty "Host    -  $distro"
fmt_pretty "Kernel  -  $kernel_release"
fmt_pretty "Target  -  target_dir: $target_dir"

# REGION_END: PRINT SYSTEM DETAILS
#================================================

#================================================
# REGION_START: PRINT DOTFILES REQUIREMENTS

# FIXME: sed doesn't clear empty line and also prefixes them.
# `sed` command is prepends 4 spaces to the beginning of each line in
# the specified files.
packages_pretty=$(sed 's/^/  -  /' ./.install-packages)
languages_pretty=$(sed 's/^/  -  /' ./.install-languages)
fmt_pretty "🔌 Packages"
echo "$packages_pretty"
fmt_pretty "🔌 Languages"
echo "$languages_pretty"

# REGION_END: PRINT DOTFILES REQUIREMENTS
#================================================

#================================================
# REGION_START: INSTALLING WITH PACKAGE MANAGER

eval "$prefix_cmd"

for package_name in ${packages[0]}; do
    fmt_pretty "🔌 $app is installing $package_name..."
    eval "$prefix_cmd $package_name"
    fmt_pretty "⚡ $app installed $package_name"
done

for language_name in ${languages[0]}; do
    fmt_pretty "🔌 $app is installing $language_name..."
    eval "$prefix_cmd $package_name"
    fmt_pretty "⚡ $app installed $language_name"
done

# REGION_END: INSTALLING WITH PACKAGE MANAGER
#================================================

#================================================
# REGION_START: LINKING GNU STOW

# Install and link packages using GNU Stow and the appropriate package manager.
if [ "$os" == "Linux" ]; then
    for package_name in ${packages[0]}; do
        fmt_pretty "🔌 $app is linking $package_name..."
        #eval "$prefix_cmd $package_name"
        # stow --dir="$PWD" --target="$target_dir" "$package_name"
        fmt_pretty "⚡ $app linked $package_name"
    done
    for language_name in ${languages[0]}; do
        fmt_pretty "🔌 $app is linking $language_name..."
        #eval "$prefix_cmd $package_name"
        # stow --dir="$PWD" --target="$target_dir" "$package_name"
        fmt_pretty "⚡ $app linked $language_name"
    done
elif [ "$os" == "Darwin" ]; then
    for package_name in ${packages[0]}; do
        fmt_pretty "🔌 $app is installing $language_name..."
        # stow --dir="$PWD" --target="$target_dir" "$package_name"
    done
fi

# REGION_END: LINKING GNU STOW
#================================================

fmt_pretty "⚡ Goodbye from $app!" 3


# ❯ zap update
# ⚡ Zap - Update
#
#    0 ⚡ Zap (Up to date)
#    1 🔌 zsh-autosuggestions (Up to date)
#    2 🔌 supercharge (Up to date)
#    3 🔌 zsh-syntax-highlighting (Up to date)
#    4 🔌 zsh-rust (Up to date)
#    5 🔌 zap-prompt (Up to date)
#
#   🔌 Plugin Number | (0) ⚡ Zap Itself | (a) All Plugins | (⏎) Abort: a
#
# Updating All Plugins
#
# ⚡ zsh-autosuggestions updated!
# ⚡ supercharge updated!
# ⚡ zsh-syntax-highlighting updated!
# ⚡ zsh-rust updated!
# ⚡ zap-prompt updated!

