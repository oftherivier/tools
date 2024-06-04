const es5 = require('eslint-plugin-es5')
const base = require('.')

const noEs2015 = {
  ...es5.configs['no-es2015'],
  plugins: { es5 },
}

module.exports = base([
  noEs2015,
  {
  languageOptions: {
    parserOptions: {
      sourceType:
        process.env.OTR_SRC_MODULE_TYPE === 'module' ? 'module' : 'script'
    }
  },
  plugins: { es5 },
}])