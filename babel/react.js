const { define } = require('../confutils')
const { presetEnv } = require('./common')

module.exports = define({
  presets: [presetEnv, '@babel/preset-react']
})
