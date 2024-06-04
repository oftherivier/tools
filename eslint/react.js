const react = require('eslint-plugin-react')
const globals = require('globals')
const base = require('.')

module.exports = base({
  plugins: { react },
  languageOptions: {
    parserOptions: {
      ecmaFeatures: {
        jsx: true
      }
    },
    globals: {
      ...globals.browser,
      render: 'writeable'
    }
  },
  rules: {
    'react/jsx-uses-react': 'error',
    'react/jsx-uses-vars': 'error'
  },
  files: ['./**/*.page.js']
})
