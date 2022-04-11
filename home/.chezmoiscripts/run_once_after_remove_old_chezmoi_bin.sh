#!/bin/bash

if [ -d ~/bin ]; then
  if [ -f ~/bin/chezmoi ]; then
    rm -rf ~/bin/chezmoi
    echo "removed ~/bin/chezmoi"
  fi
  # remove ~/bin if empty
  pushd ~/bin/ > /dev/null
  if ls -1qA . | grep -q .; then 
    echo
  else 
    rm -rf ~/bin
  fi
  popd > /dev/null
fi

