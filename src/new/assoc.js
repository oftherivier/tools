#!/usr/bin/env node
var fs = require('fs')

var target = read(process.argv[2])
var props = read('/dev/stdin')

Object.keys(props).forEach(assoc)
fs.writeFileSync(process.argv[2], JSON.stringify(target, null, 2))

function assoc (k) {
  var v = props[k]

  if (v && typeof v === 'object') {
    target[k] = {
      ...target[k],
      ...v
    }
  } else {
    target[k] = v
  }
}

function read (pathname) {
  return JSON.parse(fs.readFileSync(pathname).toString())
}
