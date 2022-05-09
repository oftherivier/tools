const path = require('path')
const { resolve } = require('../confutils')
const pkgUp = require('find-package-json')

module.exports = function conf(overrides = {}) {
  const env = conf.mode || process.env.NODE_ENV || 'development'
  const isPrd = env === 'production'
  const rootDir = path.dirname(pkgUp(process.cwd()).next().filename)

  const context = {
    env,
    isPrd,
    rootDir
  }

  const result = resolve(
    [
      {
        mode: env,
        entry: {
          ...(process.env.OTR_SRC && {
            main: path.resolve(rootDir, process.env.OTR_SRC)
          })
        },
        devtool: isPrd ? 'source-map' : 'cheap-module-source-map',
        output: {
          path: path.resolve(rootDir, 'dist', 'umd'),
          libraryTarget: 'umd',
          library: process.env.OTR_LIB_NAME,
          filename: `${process.env.OTR_BUNDLE_NAME}.js`,
          globalObject: 'this'
        },
        module: {
          rules: {
            ...(process.env.OTR_TYPE !== 'es5' && {
              js: {
                test: /\.js$/,
                exclude: /node_modules/,
                use: [
                  {
                    loader: 'babel-loader',
                    options: {
                      cacheDirectory: true
                    }
                  }
                ]
              }
            })
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
