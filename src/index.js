#!/usr/bin/env node
const path = require('path')
const child = require('child_process')

const args = process.argv.slice(2)

const result = child.spawnSync(path.join(__dirname, 'cli.sh'), args, {
  stdio: 'inherit'
})

process.exit(result.status)
