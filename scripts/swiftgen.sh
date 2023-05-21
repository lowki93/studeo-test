#!/bin/bash

export PATH="$PATH:/opt/homebrew/bin"

if which swiftgen >/dev/null; then
  swiftgen config run
else
  echo "SwiftGen not installed, download from https://github.com/SwiftGen/SwiftGen"
  exit 1 
fi

