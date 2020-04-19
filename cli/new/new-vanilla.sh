#!/bin/bash
. $OTR_BASE

extend "$DIR/new-base"

mkdir tests

cat > tests/$NAME.test.js << EOL
import tap from 'tap'

tap.equal(true, true)
EOL

touch index.js
touch index.d.ts
touch index.test-d.ts

otr format
otr bootstrap