#!/bin/bash

export PATH="$PATH:/opt/homebrew/bin"

if which swiftlint >/dev/null; then
  swiftlint --config "${SRCROOT}/.swiftlint.yaml"
else
  echo "SwiftLint not installed, download from https://github.com/realm/SwiftLint"
  exit 1 
fi

