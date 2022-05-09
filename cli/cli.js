#!/usr/bin/env node
const path = require('path')
const child = require('child_process')
const pkgUp = require('find-package-json')

function main() {
  const args = process.argv.slice(2)
  const conf = readConf()

  // reversed for later scripts to take command precedence
  const extensions = conf.extensions
    .map(maybeResolve)
    .filter(Boolean)
    .map(path.dirname)
    .reverse()
    .join(' ')

  Object.assign(process.env, {
    DIR: __dirname,
    OTR_PKG_NAME: conf.name,
    OTR_LIB_NAME: conf.libName || conf.name,
    OTR_BUNDLE_NAME: conf.bundleName,
    OTR_TYPE: conf.type,
    OTR_DIR: __dirname,
    OTR_SRC: conf.src || '',
    OTR_BASE: path.join(__dirname, 'base.sh'),
    OTR_SRC_MODULE_TYPE: conf.srcModuleType,
    OTR_EXTENSION_DIRS: extensions
  })

  const result = child.spawnSync(path.join(__dirname, 'cli.sh'), args, {
    stdio: 'inherit'
  })

  process.exit(result.status)
}

function readConf() {
  const pkg = pkgUp(process.cwd()).next().value || {}

  return {
    name: pkg.name,
    type: 'bleeding',
    src: null,
    extensions: [],
    srcModuleType: pkg.type || 'commonjs',
    bundleName: pkg.name,
    ...pkg.oftherivier
  }
}

function maybeResolve(name) {
  try {
    return require.resolve(name)
  } catch (_) {
    return null
  }
}

if (require.main === module) {
  main()
}
