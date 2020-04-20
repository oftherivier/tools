const { define } = require('../confutils')
const { presetEnv } = require('./common')

module.exports = define({
  presets: [presetEnv],
  plugins: [
    [
      'babel-plugin-module-resolver',
      {
        root: ['.'],
        alias: {
          '~': './src',
          [process.env.OTR_PKG_NAME]: './src'
        }
      }
    ]
  ]
})
