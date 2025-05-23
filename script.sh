#!/bin/bash


BOLD='\e[1m'
GREEN='\e[92m'
PURPLE='\e[95m'
BLACK_BG='\e[40m'
RED='\e[31m'
YELLOW='\e[33m'
NC='\e[0m'

print_info() {
    local text="$1"
    echo -e "${PURPLE}[INFO]${NC} ${BOLD}${GREEN}$text${NC}"
}

print_green() {
    local text="$1"
    echo -e "${BOLD}${GREEN}$text${NC}"
}

print_purple() {
    local text="$1"
    echo -e "${BOLD}${PURPLE}$text${NC}"
}

print_error() {
    local text="$1"
    echo -e "${RED}[ERROR]${NC} ${BOLD}${RED}$text${NC}"
}

print_warn() {
    local text="$1"
    echo -e "${YELLOW}[ERROR]${NC} ${BOLD}${YELLOW}$text${NC}"
}


#Greetings
clear
echo ""
echo -e "${BOLD}${GREEN}Hello ${BOLD}${PURPLE}$USER${NC}${BOLD}${GREEN}, I am ${PURPLE}JPscissor${NC}, ${BOLD}${GREEN}an author of this script.${NC}"
echo -e "${BOLD}${GREEN}${BLACK_BG}This script is my personal tool, to make my life easier, but i think it can be helpful for you too!${NC}"
echo ""
echo -e "${BOLD}${GREEN}This script will isntall and configure follow packages:${NC}"
echo -e "  ${BOLD}${PURPLE}- git"
echo -e "  - kitty"
echo -e "  - zen browser"
echo -e "  - fastfetch"
echo -e "  - VScodium"${NC}
echo ""

#Confirmation
while true; do
    read -p $'Do you want to start?\n1 - Start\n0 - Exit\n> ' choice
    case "$choice" in
        1)
            echo -e "${BOLD}${GREEN}Starting!${NC}"
            break
            ;;
        0)
            echo -e "${BOLD}${GREEN}Exit.${NC}"
            exit 0
            ;;
        *)
            echo -e "${BOLD}${GREEN}Incorrect option.. Enter 1 or 0.${NC}"
            ;;
    esac
done

#Functions
install_git() {
    if command -v apt-get &> /dev/null; then
        print_info "Detected APT (Debian/Ubuntu). Installing..."
        sudo apt-get update && sudo apt-get install -y git

    elif command -v dnf &> /dev/null; then
        print_info "Detected DNF (Fedora). Installing..."
        sudo dnf install -y git

    elif command -v yum &> /dev/null; then
        print_info "Detected YUM (RHEL/CentOS). Installing..."
        sudo yum install -y git

    elif command -v pacman &> /dev/null; then
        print_info "Detected Pacman (Arch). Installing..."
        sudo pacman -Sy --noconfirm git

    elif command -v zypper &> /dev/null; then
        print_info "Detected Zypper (openSUSE). Installing..."
        sudo zypper install -y git

    elif command -v emerge &> /dev/null; then
        print_info "Detected Portage (Gentoo). Installing..."
        sudo emerge --ask dev-vcs/git

    else
        print_error "Failed to detect package manager."
        print_warn "Install git manually please, I can't recognize your linux system :3"
        print_warn "Once git installed run script again!"
        exit 1
    fi
}

install_kitty() {
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh  | sh /dev/stdin launch=n
    KITTYPATH="$HOME/.local/bin"

    

}


#Installing git
echo ""
print_info "Installing git..."
install_git
print_info "Git was installed sucessfully!"

#Installing Kitty
echo ""
print_info "Installing kitty..."
install_kitty