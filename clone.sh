#!/bin/bash

# Define ANSI color escape codes
GREEN="\033[0;32m"
BLUE="\033[0;34m"
RESET="\033[0m"

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
#if ! git clone "https://$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$REPO_NAME"; then
#  echo "Error: Cloning repository failed."
#  exit 1
#fi
expect<<EOF
spawn git clone "https://$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$REPO_NAME"
expect {
  "*Username*" {
    send "{$GITHUB_TOKEN}\r"
    exp_continue
  }
  "*Password*" {
    send "{$GITHUB_TOKEN}\r"
    exp_continue
  }
  "*error: " {
    puts "ERROR: Git clone failed!"
    exit 1
  }
  eof {
    #puts "Git clone completed successfully.\n Run cd $REPO_NAME to run other git commands like push & pull"

    message1="${GREEN}Git clone completed successfully.${RESET}"
    message2="${BLUE}Run cd \$REPO_NAME to run other git commands like push & pull${RESET}"

    # Print the colored messages
    echo -e "$message1"
    echo -e "$message2"
  }
}
EOF

exit 1
# Change terminal into the repository folder if cloning is successful
cd "$REPO_NAME" || exit 1