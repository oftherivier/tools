import { define } from '../confutils'
import { presetEnv } from './common'

export const conf = define({
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

export default conf()
