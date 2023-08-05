#!/bin/bash

# Destination directory
DEST_DIR="$HOME/.github_app"

# Check if the directory already exists
if [ -d "$DEST_DIR" ]; then
    echo "The folder is already set up at $DEST_DIR."
    exit 1
fi

# Create destination directory
mkdir -p "$DEST_DIR" || { echo "Failed to create directory $DEST_DIR"; exit 1; }

# Copy the files
cp clone.sh pu.sh pull.sh setup-env.sh "$DEST_DIR/" || { echo "Failed to copy files"; exit 1; }

# Make the copied files executable
chmod +x "$DEST_DIR/clone.sh" "$DEST_DIR/pu.sh" "$DEST_DIR/pull.sh" "$DEST_DIR/setup-env.sh" || { echo "Failed to make files executable"; exit 1; }

# Create symbolic links
ln -s "$DEST_DIR/clone.sh" "$DEST_DIR/clone" || { echo "Failed to create symbolic link for clone"; exit 1; }
ln -s "$DEST_DIR/pu.sh" "$DEST_DIR/push" || { echo "Failed to create symbolic link for push"; exit 1; }
ln -s "$DEST_DIR/pull.sh" "$DEST_DIR/pull" || { echo "Failed to create symbolic link for pull"; exit 1; }
ln -s "$DEST_DIR/setup-env.sh" "$DEST_DIR/github_token" || { echo "Failed to create symbolic link for github_token"; exit 1; }

# Make the symbolic links executable
chmod +x "$DEST_DIR/clone" "$DEST_DIR/push" "$DEST_DIR/pull" "$DEST_DIR/github_token" || { echo "Failed to make symbolic links executable"; exit 1; }

# Prompt user for GitHub token
read -p "Enter your GitHub token " GITHUB_TOKEN

# Validate the token using the given regexp
if [[ ! "$GITHUB_TOKEN" =~ ^(gh[ps]_[a-zA-Z0-9]{36}|github_pat_[a-zA-Z0-9]{22}_[a-zA-Z0-9]{59})$ ]]; then
    echo "Error: Invalid GitHub token format."
    exit 1
fi

# Prompt user for GitHub username
read -p "Enter your GitHub username: " GITHUB_USERNAME

# Store the token and username in the .env file
echo "GITHUB_TOKEN=\"$GITHUB_TOKEN\"" > "$DEST_DIR/.env"
echo "GITHUB_USERNAME=\"$GITHUB_USERNAME\"" >> "$DEST_DIR/.env"

# Add the destination directory to the PATH environment
echo "export PATH=\$PATH:$DEST_DIR" >> "$HOME/.bashrc" || { echo "Failed to modify shell profile"; exit 1; }

echo "Installation completed. You may need to restart your terminal."

