const es5 = require('./es5')

module.exports = {
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
  },
  overrides: [
    {
      files: ['./*.js', 'src/**/*.js'],
      ...es5
    }
  ]
}
