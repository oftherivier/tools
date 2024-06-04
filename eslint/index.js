const js = require('@eslint/js')
const globals = require('globals')
const { define } = require('../confutils')
const ignores = require('./ignores')

module.exports = define(js.configs.recommended)([ignores, {
  languageOptions: {
    parserOptions: {
      ecmaVersion: 2020,
      sourceType: 'module'
    },
    globals: {
      ...globals.es2021,
      ...globals.node
    }
  },

  rules: {
    'no-unused-expressions': 'off',
    'no-multiple-empty-lines': ['error', { max: 2 }],
    'no-unused-vars': [
      'error',
      {
        varsIgnorePattern: '^_',
        argsIgnorePattern: '^_',
        caughtErrorsIgnorePattern: '^_',
        vars: 'all',
        args: 'after-used',
        ignoreRestSiblings: false
      }
    ]
  },
}])
