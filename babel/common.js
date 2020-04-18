exports.presetEnv = [
  '@babel/preset-env',
  {
    exclude: ['transform-regenerator', 'transform-async-to-generator'],
    ...(process.env.BABEL_MJS
      ? {
          modules: false
        }
      : {
          loose: true
        })
  }
]
