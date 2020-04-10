#!/usr/bin/env node
const path = require('path')

const cli = require('yargs')
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

cli.argv

function sh (cmd) {
  return argv => {
    const [, ...args] = argv._
    const result = require('child_process').spawnSync(
      path.join(__dirname, `${cmd}.sh`),
      args,
      {
        stdio: 'inherit'
      }
    )

    process.exit(result.status)
  }
}
