#!/bin/bash

export PATH="$PATH:/opt/homebrew/bin"

which -s brew
if [[ $? != 0 ]] ; then
  # Install Homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Check if swiftlint is install
which -s swiftlint
if [[ $? != 0 ]] ; then
  # Install swiftlint  
  brew install swiftlint
fi

# Check if SwiftGen is install
which -s swiftgen
if [[ $? != 0 ]] ; then
  # Install swiftlint  
  brew install swiftgen
fi
