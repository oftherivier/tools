#!/bin/bash
. $OTR_BASE

extend "$DIR/new-base"

echo "module.exports = require('@oftherivier/tools/eslint/react')()'" > .eslintrc.js
echo "module.exports = require('@oftherivier/tools/babel/react')()" > babel.config.js
echo "module.exports = require('@oftherivier/ui-tools/webpack/dev')()" > webpack.dev.config.js

mkdir -p tests/unit

cat > tests/unit/$NAME.test.js << EOL
import tap from 'tap'

tap.equal(true, true)
EOL

$DIR/assoc.js ./package.json << EOL
{
  "scripts": {
    "start": "otr start"
  },
  "oftherivier": {
    "type": "react",
    "extensions": ["@oftherivier/ui-tools"]
  },
  "peerDependencies": {
    "react": "^15.0.0 || ^16.0.0"
  }
}
EOL

yarn add -D react

if [[ "$TESTING" ]]; then
  yarn link @oftherivier/ui-tools
else
  yarn add -D @oftherivier/ui-tools
fi

mkdir -p src/js
touch src/js/index.js

mkdir -p src/scss
touch scss/scss/index.entry.scss

mkdir -p examples/simple

cat > examples/simple/simple.page.js << EOL
import React from 'react'
// import * as _ from '$NAME'

const SimpleExample = () => (
  <div>A simple example</div>
)

render(SimpleExample)
EOL

mkdir -p dev/sandbox

cat > dev/dev.page.js << EOL
import React from 'react'
// import * as _ from '$NAME'

const Sandbox = () => (
  <div>This is your sandbox, put anything here</div>
)

render(Sandbox)
EOL

otr format
otr bootstrap
