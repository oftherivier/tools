const base = require('.')

module.exports = (overrides = {}) =>
  base([
    {
      rules: {
        'no-var': ['error']
      }
    },
    overrides
  ])
