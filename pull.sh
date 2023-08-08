#!/bin/bash

source .env

git pull
exit 1

expect<<EOF
spawn git pull
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
    puts "ERROR: Git pull failed!"
    exit 1
  }
  eof {
    puts "Git pull completed successfully."
  }
}
EOF