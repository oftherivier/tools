const base = require('.')

module.exports = (overrides = {}) =>
  base([
    {
      env: {
        browser: true
      }
    },
    overrides
  ])
