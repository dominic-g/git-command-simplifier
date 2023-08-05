#!/bin/bash

source .env
# Ensure the required environment variables are set
if [[ -z "$GITHUB_TOKEN" || -z "$GITHUB_USERNAME" ]]; then
  echo "Error: GitHub token or username not provided."
  exit 1
fi

if [[ -z "$1" ]]; then
  echo "Error: No repository name provided."
  exit 1
fi

REPO_NAME="$1"

# Validate repository name (this is a simple example, you might want more comprehensive validation)
if [[ ! "$REPO_NAME" =~ ^[a-zA-Z0-9_.-]+$ ]]; then
  echo "Error: Invalid repository name."
  exit 1
fi

# Clone the repository
echo "Cloning repository: $REPO_NAME"
git clone "https://$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$REPO_NAME"

