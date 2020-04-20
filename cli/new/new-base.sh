#!/bin/bash
. $OTR_BASE

nodeVersion="$(node --version)"
yarnVersion="$(yarn --version)"

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
  "scripts": {
    "lint": "otr lint",
    "build": "otr build all",
    "format": "otr format",
    "test": "otr test",
    "typetest": "otr typetest",
    "checks": "yarn lint && yarn typetest && yarn test",
    "release": "otr release"
  },
  "oftherivier": {
    "type": "vanilla"
  }
}
EOL

if [[ "$type" == "es5" ]]; then
  echo "module.exports = require('@oftherivier/tools/eslint/es5')()'" > .eslintrc.js

  $DIR/assoc.js ./package.json << EOL
  {
    "oftherivier": {
      "type": "vanilla"
    }
  }
EOL
else
  echo "module.exports = require('@oftherivier/tools/eslint')()'" > .eslintrc.js
  echo "module.exports = require('@oftherivier/tools/babel/vanilla')()" > babel.config.js
fi

echo "module.exports = require('@oftherivier/tools/webpack')()" > webpack.config.js

touch CHANGELOG.md

cat > .eslintignore << EOL
.yarn
.nyc_output
EOL

cp .eslintignore .prettierignore

cat > .gitignore << EOL
node_modules
.nyc_output
yarn-error.log
dev
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
