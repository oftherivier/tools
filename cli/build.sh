#!/bin/bash
. $OTR_BASE
export NODE_ENV="${NODE_ENV:-production}"

scripts() {
  babel "${2:-src/js}" --out-dir "$1" ${@:3}
}

if [[ "$OTR_TYPE" != "es5" ]]; then
  :cjs() {
    scripts "${2:-dest/cjs}" "$1" ${@:3}
  }

  :mjs() {
    BABEL_MJS=1 scripts "${2:-dest/mjs}" "$1"
  }
fi

:umd() {
  : # todo
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
