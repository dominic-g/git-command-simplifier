#!/bin/bash

source ~/bin/token.sh

if [ -z "$1" ]; then

echo "No repository given."

else
  
  git clone "https://$token@github.com/$username/$1"
fi
