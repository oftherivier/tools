import { define } from '../confutils'
import { presetEnv } from './common'

export const conf = define({
  presets: [presetEnv]
})

export default conf()
