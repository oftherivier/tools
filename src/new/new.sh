#!/bin/bash
set -e

dir="$(dirname "$0")"
nodeVersion="$(node --version)"
yarnVersion="$(yarn --version)"

if [ "$1" ]; then
  mkdir -p "$1"
  cd $1
fi

name="$(basename $PWD)"

git init
yarn init -y
$dir/new-license.sh @oftherivier

echo "$nodeVersion" > .nvmrc
yarn set version "$yarnVersion"
echo "# $name" > readme.md
echo "module.exports = require('@oftherivier/tools/prettier')" > .prettierrc.js
echo "module.exports = require('@oftherivier/tools/eslint/es5-lib')" > .eslintrc.js

touch CHANGELOG.md
touch index.js
touch index.d.ts
touch index.test-d.ts

cat > .eslintignore << EOL
.yarn
.nyc_output
EOL

cp .eslintignore .prettierignore

cat > .gitignore << EOL
node_modules
.nyc_output
EOL

$dir/assoc.js ./package.json << EOL
{
  "type": "commonjs",
  "author": "@oftherivier",
  "scripts": {
    "lint": "otr style --lint",
    "format": "otr style --format",
    "test": "otr test './tests/**/*.test.js'",
    "typetest": "otr typetest",
    "checks": "yarn lint && yarn typetest && yarn test",
    "release": "otr release",
    "prepublishOnly": "yarn checks"
  },
  "renovate": {
    "extends": ["github>oftherivier/tools"]
  }
}
EOL

yarn add -D @oftherivier/tools

mkdir tests
cat > tests/$name.test.js << EOL
const tap = require('tap')

tap.equal(true, true)
EOL

cat > .travis.yml << EOL
language: node_js
node_js:
  - 10
  - 12
  - 13
script: yarn checks
EOL

$dir/../bootstrap.sh
