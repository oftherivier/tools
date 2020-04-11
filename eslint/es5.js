module.exports = {
  parserOptions: {
    ecmaVersion: 5,
    ecmaFeatures: {
      jsx: false
    },
    sourceType: 'script'
  },
  env: {
    es6: false
  },
  plugins: ['es5'],
  extends: ['plugin:es5/no-es2015']
}
