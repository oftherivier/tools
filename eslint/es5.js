const es5 = require('eslint-plugin-es5')
const base = require('.')

module.exports = [
  ...base,
  {
    languageOptions: {
      parserOptions: {
        sourceType:
          process.env.OTR_SRC_MODULE_TYPE === 'module' ? 'module' : 'script'
      }
    },
    files: ['./*.js', 'src/**/*.js'],
    excludedFiles: ['./.*.js', './*.config.js'],
    plugins: [es5],
    extends: [es5.configs['no-es2015']],
    ignores: ['.nyc_output/**']
  }
]
