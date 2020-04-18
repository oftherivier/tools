#!/usr/bin/env node
const fs = require('fs')
const { merge } = require('../../confutils')

const target = read(process.argv[2])
const props = read('/dev/stdin')
const result = merge(target, props)

fs.writeFileSync(process.argv[2], JSON.stringify(result, null, 2))

function read(pathname) {
  return JSON.parse(fs.readFileSync(pathname).toString())
}
