#!/usr/bin/bash
#set -euo pipefail # enable if accepting CLI args.

readonly APP="Distrohop"

readonly YELLOW='\033[1;33m'
readonly  GREEN='\033[1;32m'
readonly   CYAN='\033[1;36m' # [1 -> bold
readonly   CYAN_ITALIC='\033[3;36m' # [1 -> bold [3 -> italic [4 -> underline [5 -> blinks
readonly    RED='\033[1;31m'
readonly     NC='\033[0m' # No Color.

INSTALL_COMMANDS=$(cat install-commands)

IFS=$'\n' read -d '' -ra commands <<< "$INSTALL_COMMANDS"

function message() {
    echo -e "$0"
}

# echo -e # enable interpretaitionof backslash escapes (special characters)
function install_packages() {
    for cmd in "${commands[@]}"; do
        echo -e "  ${YELLOW}Installing  ${NC}${CYAN}\$ ${cmd}${NC}"

        eval "$cmd"
        if [ $? -eq 0 ]; then
            echo -e "  ${GREEN}Finished    ${NC}${CYAN_ITALIC}${cmd}${NC}"
        else
            echo -e "  ${RED}Error       ${NC}⚠️  Failed to run ${CYAN_ITALIC}$cmd${NC}"
        fi
    done
}

function main() {
    echo -e "  ⚡ $APP - package installer"
    install_packages
    echo -e "   ⚡ ${GREEN}Bye${NC} from $APP!"
}

main
