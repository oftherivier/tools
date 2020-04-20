const base = require('.')

module.exports = (overrides = {}) =>
  base(({ append }) => [
    {
      plugins: ['react'],
      env: {
        browser: true
      },
      parserOptions: {
        ecmaFeatures: {
          jsx: true
        }
      },
      rules: {
        'react/jsx-uses-react': 'error',
        'react/jsx-uses-vars': 'error'
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
