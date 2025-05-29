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
echo -e "Hello $USER, I am ${PURPLE}JPscissor${NC}, an author of this script."
echo -e "This script is my personal tool, to make my life easier, but i think it can be helpful for you too!"
echo ""
echo -e "This script will isntall and configure follow packages:"
echo -e "  ${BOLD}${PURPLE}- git"
echo -e "  - kitty"
echo -e "  - zen browser"
echo -e "  - fastfetch"
echo -e "  - VScodium"${NC}
echo ""

print_info "Instalation will start soonly..."
sleep 5

#Functions
install_git() {

    if ! command -v git &> /dev/null; then
        

    if command -v apt-get &> /dev/null; then
        print_info "Detected APT (Debian/Ubuntu). Installing..."
        sudo apt-get update && sudo apt-get install git
        if ! command -v git &> /dev/null; then
            print_error "Git installation failed via APT."
            exit 1
        fi

    elif command -v dnf &> /dev/null; then
        print_info "Detected DNF (Fedora). Installing..."
        sudo dnf install -y git
        if ! command -v git &> /dev/null; then
            print_error "Git installation failed via DNF."
            exit 1
        fi

    elif command -v yum &> /dev/null; then
        print_info "Detected YUM (RHEL/CentOS). Installing..."
        sudo yum install -y git
        if ! command -v git &> /dev/null; then
            print_error "Git installation failed via YUM."
            exit 1
        fi

    elif command -v pacman &> /dev/null; then
        print_info "Detected Pacman (Arch). Installing..."
        sudo pacman -Sy --noconfirm git
        if ! command -v git &> /dev/null; then
            print_error "Git installation failed via Pacman."
            exit 1
        fi

    elif command -v zypper &> /dev/null; then
        print_info "Detected Zypper (openSUSE). Installing..."
        sudo zypper install -y git
        if ! command -v git &> /dev/null; then
            print_error "Git installation failed via Zypper."
            exit 1
        fi

    elif command -v emerge &> /dev/null; then
        print_info "Detected Portage (Gentoo). Installing..."
        sudo emerge --ask dev-vcs/git
        if ! command -v git &> /dev/null; then
            print_error "Git installation failed via Portage."
            exit 1
        fi

    else
        print_error "Failed to detect package manager."
        print_warn "Install git manually please, I can't recognize your linux system :3"
        print_warn "Once git installed run script again!"
        exit 1
    fi

    #Checking installation
    if ! command -v git &> /dev/null; then
        print_error "Git is not installed or not in PATH."
        print_warn "Please install git manually and try again."
        exit 1
    else
        print_info "Git installed successfully!"
    fi

    else
        print_info "Git is already installed. Moving on..."
    fi
}


#Setup
REPO_URL="https://github.com/JPscissor/ConfigScript"
FOLDER_NAME="apps_configs"
TEMP_DIR="TMP_DIR"


install_kitty() {

    if ! commad kitty &> /dev/null; then
        print_info "Kitty is already installed! Moving on..."

    else
        curl -L https://sw.kovidgoyal.net/kitty/installer.sh  | sh /dev/stdin launch=n
    fi


    #Cloning repo
    echo ""
    print_info "Configuring kitty..."
    print_info "Cloning repo: $REPO_URL"
    git clone "$REPO_URL" "$TEMP_DIR" || {
        rm -rf "$TEMP_DIR"
    }

    mkdir -p ~/.config
    print_info "Copying files to ~/.config..."
    cp -r "$TEMP_DIR"/"$FOLDER_NAME"/* ~/.config/ || {
        print_error "Unable to clone files"
        rm -rf "$TEMP_DIR"
    }

    #Clearing
    rm -rf "$TEMP_DIR"

    #Adding to PATH
    mkdir -p ~/.local/bin
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty

    print_info "Done!"

}


#Installing git
clear
echo ""
print_info "Installing git..."
install_git
sleep 3

#Installing Kitty
clear
echo ""
print_info "Installing kitty..."
install_kitty
sleep 3 