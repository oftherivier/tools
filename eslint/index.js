module.exports = {
  extends: ['eslint:recommended'],

  parserOptions: {
    ecmaVersion: 2020,
    ecmaFeatures: {
      jsx: true
    },
    sourceType: 'module'
  },

  env: {
    es6: true,
    node: true
  },

  rules: {
    'no-var': ['error'],
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
}
