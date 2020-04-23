const { define } = require('../confutils')

module.exports = define({
  extends: ['eslint:recommended'],

  parserOptions: {
    ecmaVersion: 2020,
    sourceType: 'module'
  },

  env: {
    es6: true,
    node: true
  },

  rules: {
    'no-unused-expressions': 'off',
    'no-multiple-empty-lines': ['error', { max: 2 }],
    'no-unused-vars': [
      'error',
      {
        varsIgnorePattern: '^_',
        vars: 'all',
        args: 'after-used',
        ignoreRestSiblings: false
      }
    ]
  }
})
