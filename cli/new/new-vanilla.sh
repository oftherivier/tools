#!/bin/bash
. $OTR_BASE

extend "$DIR/new-base" vanilla $@

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
import tap from 'tap'
// import { _ } from '~'

tap.equal(true, true)
EOL

mkdir {src,test-d}
touch index.d.ts
touch src/index.{js,d.ts}
touch test-d/index.test-d.ts

yarn format
otr bootstrap
