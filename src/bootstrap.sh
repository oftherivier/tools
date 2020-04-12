#!/bin/bash

maybeRun() {
  (yarn run 2> /dev/null | grep $1 2>&1 > /dev/null) && yarn run $1
}

if [ -z "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
  . "$HOME/.nvm/nvm.sh"
fi

yarn install
maybeRun bootstrap
maybeRun checks
