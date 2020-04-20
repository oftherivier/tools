#!/bin/bash
. $OTR_BASE

extend "$DIR/new-base"

$DIR/assoc.js ./package.json << EOL
{
  "scripts": {
    "typetest": "otr typetest",
    "checks": "yarn lint && yarn typetest && yarn test",
  }
}
EOL

mkdir tests

cat > tests/$NAME.test.js << EOL
import tap from 'tap'
// import { _ } from '~'

tap.equal(true, true)
EOL

touch index.js
touch index.d.ts
touch index.test-d.ts

yarn format
otr bootstrap
