const path = require('path')
const { resolve } = require('../confutils')

module.exports = function conf(overrides = {}) {
  const env = conf.mode || process.env.NODE_ENV || 'development'
  const isPrd = env === 'production'

  const context = {
    env,
    isPrd
  }

  const result = resolve(
    [
      {
        mode: env,
        devtool: isPrd ? 'source-map' : 'cheap-module-source-map',
        output: {
          path: path.resolve(process.cwd(), 'dist'),
          filename: '[name].js'
        },
        module: {
          rules: {
            js: {
              test: /\.js$/,
              exclude: /node_modules/,
              use: [
                process.env.OTR_TYPE !== 'es5' && {
                  loader: 'babel-loader',
                  options: {
                    cacheDirectory: true
                  }
                }
              ]
            }
          }
        }
      },
      overrides
    ],
    context
  )

  result.module.rules = Object.values(result.module.rules)

  return result
}
