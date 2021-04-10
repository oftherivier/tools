#!/bin/bash
. $OTR_BASE
export NODE_ENV="${NODE_ENV:-production}"

scripts() {
  babel "${2:-$(dirname "$OTR_SRC")}" --out-dir "$1" ${@:3}
}

:cjs() {
  if [[ "$OTR_TYPE" != "es5" ]]; then
    [ -d "./dist/cjs" ] && rm -rf "./dist/cjs"
    scripts "${2:-dist/cjs}" "$1" ${@:3}
  fi
}

:mjs() {
  if [[ "$OTR_TYPE" != "es5" ]]; then
    [ -d "./dist/mjs" ] && rm -rf "./dist/mjs"
    BABEL_MJS=1 scripts "${2:-dist/mjs}" "$1"
  fi
}

:umd() {
  [ -d "./dist/umd" ] && rm -rf "./dist/umd"
  webpack
}

:scripts() {
  :cjs
  :mjs
  :umd
}

:all() {
  :scripts
}

hook:empty() {
  :all
}

run $@
