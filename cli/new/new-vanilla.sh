#!/bin/bash
. $OTR_BASE

extend "$DIR/new-base" vanilla $@

echo "module.exports = require('@oftherivier/tools/eslint/vanilla')()" > .eslintrc.js

$DIR/assoc.js ./package.json << EOL
{
  "scripts": {
    "typetest": "otr typetest",
    "checks": "yarn lint && yarn typetest && yarn test"
  },
  "oftherivier": {
    "src": "src/index.js"
  }
}
EOL

mkdir tests

cat > tests/$NAME.test.js << EOL
import test from 'ava'
// import { _ } from '~'

test('_', t => {
  t.pass()
})
EOL

mkdir {src,test-d}
touch index.d.ts
touch src/index.{js,d.ts}
touch test-d/index.test-d.ts

yarn format
otr bootstrap
