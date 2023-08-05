#!/bin/bash

# Prompt user for GitHub token
read -p "Enter your GitHub token: " GITHUB_TOKEN

# Prompt user for GitHub username
read -p "Enter your GitHub username: " GITHUB_USERNAME

# Create or overwrite the .env file
echo "GITHUB_TOKEN=\"$GITHUB_TOKEN\"" > .env
echo "GITHUB_USERNAME=\"$GITHUB_USERNAME\"" >> .env

echo "Environment variables saved to .env file."

