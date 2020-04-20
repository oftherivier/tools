#!/usr/bin/env node
const path = require('path')
const child = require('child_process')
const pkgUp = require('pkg-up').sync

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
    OTR_TYPE: conf.type,
    OTR_DIR: __dirname,
    OTR_BASE: path.join(__dirname, 'base.sh'),
    OTR_EXTENSION_DIRS: extensions
  })

  const result = child.spawnSync(path.join(__dirname, 'cli.sh'), args, {
    stdio: 'inherit'
  })

  process.exit(result.status)
}

function readConf() {
  const pkgPath = pkgUp()
  const pkg = pkgPath ? require(pkgPath) : {}

  return {
    name: pkg.name,
    type: 'bleeding',
    extensions: [],
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
