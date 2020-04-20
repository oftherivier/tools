const base = require('.')

module.exports = (overrides = {}) =>
  base(({ append }) => [
    {
      plugin: ['react'],
      env: {
        browser: true
      },
      parserOptions: {
        ecmaFeatures: {
          jsx: true
        }
      },
      overrides: append([
        {
          files: ['./**/*.page.js'],
          globals: {
            render: 'writeable'
          }
        }
      ])
    },
    overrides
  ])
