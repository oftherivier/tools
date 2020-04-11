const es5 = require('./es5')

module.exports = {
  rules: {
    'no-unused-expressions': 'off',
    'no-multiple-empty-lines': ['error', { max: 2 }]
  },
  overrides: [
    {
      files: ['./*.js', 'src/**/*.js'],
      ...es5
    }
  ]
}
