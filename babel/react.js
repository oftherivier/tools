const { define } = require('../confutils')
const { presetEnv } = require('./common')

module.exports = define({
  presets: [presetEnv, '@babel/preset-react'],
  plugins: [
    [
      'babel-plugin-module-resolver',
      {
        root: ['.'],
        alias: {
          '~': './src/js',
          [process.env.OTR_PKG_NAME]: './src/js'
        }
      }
    ]
  ]
})
