#!/bin/bash
. $OTR_BASE
export NODE_ENV="${NODE_ENV:-production}"

scripts() {
  babel "${2:-src}" --out-dir "$1" ${@:3}
}

:cjs() {
  if [[ "$OTR_TYPE" != "es5" ]]; then
    scripts "${2:-dist/cjs}" "$1" ${@:3}
  fi
}

:mjs() {
  if [[ "$OTR_TYPE" != "es5" ]]; then
    BABEL_MJS=1 scripts "${2:-dist/mjs}" "$1"
  fi
}

:umd() {
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
