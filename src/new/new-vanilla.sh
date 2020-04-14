#!/bin/bash
set -e
dir="$(dirname "$0")"
$dir/new-base.sh $@

echo "module.exports = require('@oftherivier/tools/eslint/es5-lib')" > .eslintrc.js

mkdir tests
cat > tests/$name.test.js << EOL
const tap = require('tap')

tap.equal(true, true)
EOL

$dir/../cli.sh bootstrap
