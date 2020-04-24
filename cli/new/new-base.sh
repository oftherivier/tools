#!/bin/bash
. $OTR_BASE

nodeVersion="$(node --version)"
yarnVersion="$(yarn --version)"

TYPE="${TYPE:-$1}"

if [[ "$2" ]] && [[ "$2" != "." ]]; then
  mkdir -p "$2"
  cd $2
fi

export NAME="$(basename $PWD)"

git init
yarn init -y
$DIR/new-license.sh @oftherivier

yarn set version "$yarnVersion"
echo "$nodeVersion" > .node-version
echo "# $NAME" > readme.md
echo "module.exports = require('@oftherivier/tools/prettier')()" > .prettierrc.js

$DIR/assoc.js ./package.json << EOL
{
  "version": "0.0.0",
  "oftherivier": {
    "type": "$TYPE"
  },
  "renovate": {
    "extends": [
      "github>oftherivier/tools"
    ]
  },
  "scripts": {
    "build": "otr build",
    "lint": "otr lint",
    "format": "otr format",
    "test": "otr test",
    "release": "otr release"
  }
}
EOL

echo "module.exports = require('@oftherivier/tools/eslint')()" > .eslintrc.js

if [[ "$TYPE" != "es5" ]]; then
  echo "module.exports = require('@oftherivier/tools/babel/vanilla')()" > babel.config.js

  $DIR/assoc.js ./package.json << EOL
{
  "type": "commonjs",
  "main": "dist/cjs/index.js",
  "module": "dist/mjs/index.js",
  "exports": {
    "import": "dist/mjs/index.js",
    "require": "dist/cjs/index.js"
  }
}
EOL
fi

echo "module.exports = require('@oftherivier/tools/webpack')()" > webpack.config.js

touch CHANGELOG.md

cat > .eslintignore << EOL
.yarn
.nyc_output
dist
EOL

cp .eslintignore .prettierignore

cat > .gitignore << EOL
node_modules
.nyc_output
yarn-error.log
dev
dist
EOL

if [[ "$TESTING" ]]; then
  yarn link @oftherivier/tools
else
  yarn add -D @oftherivier/tools
fi

cat > .travis.yml << EOL
language: node_js
node_js:
  - 10
  - 12
  - 13
script: yarn checks
EOL
