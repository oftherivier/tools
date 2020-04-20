const base = require('.')

module.exports = (overrides = {}) =>
  base(({ append }) => [
    {
      overrides: append([
        {
          parserOptions: {
            sourceType: 'script'
          },
          files: ['./*.js', 'src/**/*.js'],
          plugins: ['es5'],
          extends: ['plugin:es5/no-es2015']
        }
      ])
    },
    overrides
  ])
