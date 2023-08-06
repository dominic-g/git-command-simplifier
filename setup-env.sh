#!/bin/bash

# Prompt user for GitHub token
read -p "Enter your GitHub token: " GITHUB_TOKEN
if [[ ! "$GITHUB_TOKEN" =~ ^(gh[ps]_[a-zA-Z0-9]{36}|github_pat_[a-zA-Z0-9]{22}_[a-zA-Z0-9]{59})$ ]]; then
    echo "Error: Invalid GitHub token format."
    exit 1
fi
# Prompt user for GitHub username
read -p "Enter your GitHub username: " GITHUB_USERNAME

DEST_DIR="$HOME/.github_app"
# Create or overwrite the .env file
echo "GITHUB_TOKEN=\"$GITHUB_TOKEN\"" > "$DEST_DIR/.env"
echo "GITHUB_USERNAME=\"$GITHUB_USERNAME\"" >> "$DEST_DIR/.env"

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
" >> "$DEST_DIR/.env"

echo "Environment variables saved to .env file."
