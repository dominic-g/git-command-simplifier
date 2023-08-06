#!/bin/bash
GREEN="\033[0;32m"
WHITE="\033[1;37m"
RED="\033[1;31m"
BLUE="\033[0;34m"
ORANGE="\033[0;33m"
RESET="\033[0m"

# Destination directory
DEST_DIR="$HOME/.github_app"

# Check if the directory already exists
if [ -d "$DEST_DIR" ]; then
    printf "${ORANGE}The folder is already set up at $DEST_DIR.${RESET}\n"
    exit 1
fi

# Create destination directory
mkdir -p "$DEST_DIR" || { printf "${RED}Failed to create directory $DEST_DIR${RESET}\n"; exit 1; }

# Copy the files
cp clone.sh pu.sh pull.sh setup-env.sh "$DEST_DIR/" || { printf "${RED}Failed to copy files${RESET}\n"; exit 1; }

# Make the copied files executable
chmod +x "$DEST_DIR/clone.sh" "$DEST_DIR/pu.sh" "$DEST_DIR/pull.sh" "$DEST_DIR/setup-env.sh" || { printf "${RED}Failed to make files executable${RESET}\n"; exit 1; }

# Create symbolic links
ln -s "$DEST_DIR/clone.sh" "$DEST_DIR/clone" || { printf "${ORANGE}Failed to create symbolic link for clone${RESET}\n"; printf "You will have to call the \"${BLUE}clone${RESET}\" command using \"${BLUE}clone.sh${RESET}\"\n"; }
ln -s "$DEST_DIR/pu.sh" "$DEST_DIR/push" || { printf "${ORANGE}Failed to create symbolic link for push${RESET}\n"; printf "You will have to call the \"${BLUE}push${RESET}\" command using \"${BLUE}pu.sh${RESET}\"\n"; }
ln -s "$DEST_DIR/pull.sh" "$DEST_DIR/pull" || { printf "${ORANGE}Failed to create symbolic link for pull${RESET}\n"; printf "You will have to call the \"${BLUE}pull${RESET}\" command using \"${BLUE}pull.sh${RESET}\"\n"; }
ln -s "$DEST_DIR/setup-env.sh" "$DEST_DIR/github_token" || { printf "${ORANGE}Failed to create symbolic link for github_token${RESET}\n"; printf "You will have to call the \"${BLUE}github_token${RESET}\" command using \"${BLUE}setup-env.sh${RESET}\"\n"; }

# Make the symbolic links executable
chmod +x "$DEST_DIR/clone" "$DEST_DIR/push" "$DEST_DIR/pull" "$DEST_DIR/github_token" || { printf "${ORANGE}Failed to make symbolic links executable${RESET}"; printf "You will have to use the full script names as commands name\n"; }

source "$DEST_DIR/setup-env.sh"

# Add the destination directory to the PATH environment
echo "export PATH=\$PATH:$DEST_DIR" >> "$HOME/.bashrc" || { printf "${RED}Failed to modify shell profile${RESET}\nYou will have to add ${BLUE}$DEST_DIR${RESET} to PATH Enviroment manualy. ${ORANGE}$HOME/.bashrc${RESET}\n"; exit 1; }

printf "${GREEN}Installation completed.${RESET}\n ${BLUE}You may need to restart your terminal.${RESET}"

