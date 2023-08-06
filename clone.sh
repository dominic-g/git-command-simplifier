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

expect -c "
spawn git clone \"https://$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$REPO_NAME\"
expect {
  \"*Username*\" {
    send \"$GITHUB_USERNAME\r\"
    exp_continue
  }
  \"*Password*\" {
    send \"$GITHUB_TOKEN\r\"
    exp_continue
  }
  \"*error: \" {
    puts \"ERROR: Git clone failed!\"
    exit 1
  }
  eof
}
exit 0
"

if [ $? -eq 0 ]; then
  printf "${GREEN}Git clone completed successfully.${RESET}\n"
  printf "${BLUE}Run cd $REPO_NAME to run other git commands like push & pull${RESET}\n"
fi

exit 1
# Change terminal into the repository folder if cloning is successful
# cd "$REPO_NAME" || exit 1