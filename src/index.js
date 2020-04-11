#!/usr/bin/env node
var path = require('path')
var yargs = require('yargs')
var child = require('child_process')

yargs
  .scriptName('otr')
  .help()
  .command(
    'bootstrap',
    'run this first time you clone a project',
    {},
    sh('bootstrap')
  )
  .command('new', 'scaffold out a new project', {}, sh('new/new'))
  .command('style', 'linting and formatting', {}, sh('style'))
  .command('test', 'run tests', {}, sh('test'))
  .command('typetest', 'run type tests', {}, sh('typetest'))
  .command('release', 'create a new release', {}, sh('release')).argv

function sh (cmd) {
  return function () {
    var args = process.argv.slice(3)
    var result = child.spawnSync(path.join(__dirname, cmd + '.sh'), args, {
      stdio: 'inherit'
    })

    process.exit(result.status)
  }
}
