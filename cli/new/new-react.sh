#!/bin/bash
. $OTR_BASE

extend "$DIR/new-base" react $@

echo "module.exports = require('@oftherivier/tools/eslint/react')()" > .eslintrc.js
echo "module.exports = require('@oftherivier/tools/babel/react')()" > babel.config.js
echo "module.exports = require('@oftherivier/ui-tools/webpack/dev')()" > webpack.dev.config.js

mkdir -p tests/unit

cat > tests/unit/$NAME.test.js << EOL
import test from 'ava'

test('_', t => {
  t.pass()
})
EOL

$DIR/assoc.js ./package.json << EOL
{
  "scripts": {
    "start": "otr start",
    "checks": "yarn lint && yarn test"
  },
  "oftherivier": {
    "src": "src/js/index.js",
    "extensions": ["@oftherivier/ui-tools"],
    "srcModuleType": "module"
  },
  "ava": {
    "babel": true
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
touch src/scss/index.scss

mkdir -p examples/simple

cat > examples/simple/simple.page.js << EOL
import React from 'react'
// import { _ } from '~'

const SimpleExample = () => (
  <div>A simple example</div>
)

render(SimpleExample)
EOL

mkdir dev

cat > dev/dev.page.js << EOL
import React from 'react'
// import { _ } from '~'

const Sandbox = () => (
  <div>This is your sandbox, put anything here</div>
)

render(Sandbox)
EOL

yarn format
otr bootstrap
yarn start
