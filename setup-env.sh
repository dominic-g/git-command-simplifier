#!/bin/bash

# Prompt user for GitHub token
read -p "Enter your GitHub token: " GITHUB_TOKEN
if [[ ! "$GITHUB_TOKEN" =~ ^(gh[ps]_[a-zA-Z0-9]{36}|github_pat_[a-zA-Z0-9]{22}_[a-zA-Z0-9]{59})$ ]]; then
    echo "Error: Invalid GitHub token format."
    exit 1
fi
# Prompt user for GitHub username
read -p "Enter your GitHub username: " GITHUB_USERNAME


# Create or overwrite the .env file
echo "GITHUB_TOKEN=\"$GITHUB_TOKEN\"" > .env
echo "GITHUB_USERNAME=\"$GITHUB_USERNAME\"" >> .env

echo "Environment variables saved to .env file."

