#!/bin/bash

source .env
# Ensure the required environment variables are set
if [ -z "$GITHUB_TOKEN" ]; then
  print_colored_message "$RED" "Error: GitHub token not provided."
  exit 1
fi


 if [[ -n $(git status -s) ]]; then

  commit_message=""
  if [ -z "$1" ]; then

    created=$(git status -s | grep "^?? " | wc -l)
    edited=$(git status -s | grep "^ M " | wc -l)
    deleted=$(git status -s | grep "^ D " | wc -l)

    # commit_message="Automtic commit:- "
    

    # if [[ $created -gt 0 ]]; then
      # commit_message+=" $created file(s) created,"
    # fi

    if [[ $edited -gt 1 ]]; then
      commit_message+=" $edited file(s) "
    fi
    if [[ $edited -gt 0 ]]; then
      commit_message+=" edited:"

      # Get list of edited files
      edited_files=$(git status -s | grep "^ M " | cut -c 4-)

      # Loop over edited files and append their names to the commit message
      while read -r file; do
        file=$(basename "$file")
        commit_message+=" $file"
      done <<< "$edited_files"
    fi

    if [[ $created -gt 1 ]]; then
      commit_message+=" $created file(s) "
    fi
    if [[ $created -gt 0 ]]; then
      commit_message+=" created:"

      # Get list of created files
      created_files=$(git status -s | grep "^ ?? " | cut -c 4-)

      # Loop over edited files and append their names to the commit message
      while read -r file; do
        file=$(basename "$file")
        commit_message+=" $file"
      done <<< "$created_files"
    fi

    if [[ $deleted -gt 1 ]]; then
      commit_message+=" $deleted file(s)"
    fi
    if [[ $deleted -gt 0 ]]; then
      commit_message+=" deleted:"

      # Get list of deleted files
      deleted_files=$(git status -s | grep "^ D " | cut -c 4-)

      # Loop over deleted files and append their names to the commit message
      while read -r file; do
        file=$(basename "$file")
        commit_message+=" $file"
      done <<< "$deleted_files"
    fi

    # Remove trailing comma and space
    commit_message=${commit_message%, *}


    timestamp=$(date +"%Y-%m-%d %T")
    commit_message+=" Pushed at $timestamp"
    # Truncate commit message if it exceeds 72 characters
    if [[ ${#commit_message} -gt 72 ]]; then
      commit_message=${commit_message:0:69}"..."
    fi
  else
    commit_message="$1"
  fi


  git add .

  git commit -m "$commit_message"

  printf "$GREEN" "\n\n Commiting: $commit_message\n\n"

  expect -c "
  spawn git push
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
      puts \"ERROR: Git push failed!\"
      exit 1
    }
    eof
  }
  exit 0
  "

  if [ $? -eq 0 ]; then
    print_colored_message "${GREEN}" "Git push completed successfully.\n"
  fi
else
   # Working tree is clean
   print_colored_message "${BLUE}" "Working tree is clean. No changes to push."
fi
