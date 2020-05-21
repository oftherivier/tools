#!/bin/bash
. $OTR_BASE

extend "$DIR/new-base" es5 $@

echo "module.exports = require('@oftherivier/tools/eslint/es5')()" > .eslintrc.js

$DIR/assoc.js ./package.json << EOL
{
  "scripts": {
    "typetest": "otr typetest",
    "checks": "yarn lint && yarn typetest && yarn test"
  },
  "oftherivier": {
    "src": "index.js"
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

touch index.{js,d.ts,test-d.ts}

yarn format
otr bootstrap
