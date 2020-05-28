const base = require('.')

module.exports = (overrides = {}) =>
  base(({ append }) => [
    {
      overrides: append([
        {
          parserOptions: {
            sourceType:
              process.env.OTR_SRC_MODULE_TYPE === 'module' ? 'module' : 'script'
          },
          files: ['./*.js', 'src/**/*.js'],
          excludedFiles: ['./.*.js', './*.config.js'],
          plugins: ['es5'],
          extends: ['plugin:es5/no-es2015']
        }
      ])
    },
    overrides
  ])
