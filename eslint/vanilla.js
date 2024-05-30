const base = require('.')

module.exports = [
  ...base,
  {
    rules: {
      'no-var': ['error']
    }
  }
]
