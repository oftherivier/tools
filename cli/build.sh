#!/bin/bash
. $OTR_BASE
export NODE_ENV="${NODE_ENV:-production}"

scripts() {
  babel "${2:-src}" --out-dir "$1" ${@:3}
}

if [[ "$OTR_TYPE" != "es5" ]]; then
  :cjs() {
    scripts "${2:-dist/cjs}" "$1" ${@:3}
  }

  :mjs() {
    BABEL_MJS=1 scripts "${2:-dist/mjs}" "$1"
  }
fi

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
