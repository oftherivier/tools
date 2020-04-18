const toString = Function.prototype.toString
const objectString = toString.call(Object)

const api = {
  join,
  append,
  prepend,
  merge
}

module.exports = {
  ...api,
  resolve,
  define
}

function resolve(confs, context) {
  const [first, ...rest] = normalizeConfs(confs, {
    ...context,
    ...api
  })

  let result = first

  for (const conf of rest) {
    result = merge(result, conf)
  }

  return result
}

function define(conf) {
  return function confFn(overrides) {
    return resolve([conf, overrides])
  }
}

function join(fn) {
  return new JoinDef(fn)
}

function append(tail) {
  return join(body =>
    body !== undefined ? [].concat(body).concat(tail) : tail
  )
}

function prepend(head) {
  return join(body =>
    body !== undefined ? [].concat(head).concat(body) : head
  )
}

function merge(a, b) {
  if (b === undefined) {
    return a
  }

  if (b instanceof JoinDef) {
    return b.fn(a)
  }

  if (isPlainObject(a) && isPlainObject(b)) {
    return mergeObjects(a, b)
  }

  return b
}

function normalizeConfs(confs, context) {
  const results = []

  for (const conf of [].concat(confs)) {
    if (Array.isArray(conf)) {
      results.push(conf.map(d => normalizeConfs(d, context)))
    } else if (typeof conf === 'function') {
      results.push(normalizeConfs(conf(context), context))
    } else {
      results.push(conf)
    }
  }

  return results.reduce(concat)
}

function concat(a, b) {
  return [].concat(a).concat(b)
}

function mergeObjects(a, b) {
  const keys = [...new Set([...Object.keys(a), ...Object.keys(b)])]
  const result = {}

  for (const k of keys) {
    result[k] = merge(a[k], b[k])
  }

  return result
}

function isPlainObject(v) {
  if (!v || Array.isArray(v) || typeof v !== 'object') {
    return false
  }

  const proto = Object.getPrototypeOf(v)
  return !proto || toString.call(proto.constructor) === objectString
}

class JoinDef {
  constructor(fn) {
    this.fn = fn
  }
}
