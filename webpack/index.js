const path = require('path')
const { sync: pkgUp } = require('pkg-up')
const { resolve } = require('../confutils')

module.exports = function conf(overrides = {}) {
  const env = conf.mode || process.env.NODE_ENV || 'development'
  const isPrd = env === 'production'
  const rootDir = path.dirname(pkgUp())

  const context = {
    env,
    isPrd,
    rootDir
  }

  const result = resolve(
    [
      {
        mode: env,
        entry: {},
        devtool: isPrd ? 'source-map' : 'cheap-module-source-map',
        output: {
          path: path.resolve(rootDir, 'dist'),
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
