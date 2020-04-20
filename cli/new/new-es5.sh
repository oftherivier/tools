#!/bin/bash
. $OTR_BASE

extend "$DIR/new-base"

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
const tap = require('tap')

tap.equal(true, true)
EOL

touch index.{js,d.ts,test-d.ts}

yarn format
otr bootstrap
