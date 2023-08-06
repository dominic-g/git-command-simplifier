#!/bin/bash
GREEN="\033[0;32m"
WHITE="\033[1;37m"
RED="\033[1;31m"
BLUE="\033[0;34m"
ORANGE="\033[0;33m"
RESET="\033[0m"



setup_git_details() {
    # Prompt user for GitHub token
    read -p "Enter your GitHub token: " GITHUB_TOKEN
    if [[ ! "$GITHUB_TOKEN" =~ ^(gh[ps]_[a-zA-Z0-9]{36}|github_pat_[a-zA-Z0-9]{22}_[a-zA-Z0-9]{59})$ ]]; then
        printf "${RED}Error: Invalid GitHub token format.${RESET}"
        exit 1
    fi
    # Prompt user for GitHub username
    read -p "Enter your GitHub username: (As it appears in your github link) " GITHUB_USERNAME

    # Prompt user for Git config email
    read -p "Enter your Git config email: " GIT_CONFIG_EMAIL
    if [[ ! "$GIT_CONFIG_EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        printf "${RED}Error: Invalid email format.${RESET}"
        exit 1
    fi

    # Prompt user for Git config name
    read -p "Enter your Git config name: " GIT_CONFIG_NAME

    DEST_DIR="$HOME/.github_app"

    # Append color variables and function to the .env file
    echo -e "
    # Define ANSI color escape codes
    GREEN=\"\\033[0;32m\"
    WHITE=\"\\033[1;37m\"
    RED=\"\\033[1;31m\"
    BLUE=\"\\033[0;34m\"
    ORANGE=\"\\033[0;33m\"
    RESET=\"\\033[0m\"

    # Define a function to print colored messages
    print_colored_message() {
    echo -e \"\$1\$2\$RESET\"
    }
    " > "$DEST_DIR/.env"

    # Create or overwrite the .env file
    echo "GITHUB_TOKEN=\"$GITHUB_TOKEN\"" >> "$DEST_DIR/.env"
    echo "GITHUB_USERNAME=\"$GITHUB_USERNAME\"" >> "$DEST_DIR/.env"
    echo "GIT_CONFIG_EMAIL=\"$GIT_CONFIG_EMAIL\"" >> "$DEST_DIR/.env"
    echo "GIT_CONFIG_EMAIL=\"$GIT_CONFIG_EMAIL\"" >> "$DEST_DIR/.env"


    git config --global --replace-all user.email "$GIT_CONFIG_EMAIL"
    git config --global --replace-all user.name "$GIT_CONFIG_NAME"
    
    printf "${GREEN}Git variables saved to Enivronment.${RESET}"
}