#!/bin/bash
set -e

dir="$(dirname "$0")"
mkdir -p "$1"
cd "$1"
yarn init -y

$dir/license.sh @oftherivier

$dir/assoc.js ./package.json << EOL
{
  "author": "@oftherivier",
  "scripts": {
    "lint": "otr style --lint",
    "format": "otr style --format"
  }
}
EOL

yarn add -D @oftherivier/tools

echo "module.exports = require('@oftherivier/tools/prettier')" > .prettierrc
echo "module.exports = require('@oftherivier/tools/eslint/es5')" > .eslintrc
