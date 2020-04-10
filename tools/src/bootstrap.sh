#!/bin/bash
[ -z $NVM_DIR ] || (
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
  . "$HOME/.nvm/nvm.sh"
)

yarn install

(yarn run 2> /dev/null | grep bootstrap 2>&1 > /dev/null) && yarn run bootstrap
