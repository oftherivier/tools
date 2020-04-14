#!/bin/bash
dir="$(dirname $0)"

:new() {
  $dir/new/new.sh $@
}

:lint() {
  eslint ${@:-.}
}

:format() {
  prettier --write ${@:-.}
}

:release() {
  standard-version $@
}

:typetest() {
  tsd $@
}

:test() {
  tap $@
}

:bootstrap() {
  $dir/bootstrap.sh $@
}

:help() {
  declare -F | awk '{print $NF}' | grep '^:' | sed -E 's/:/* /g'
}

if [[ -z "$@" ]] || [[ "$@" == "--help" ]]; then
  :help
else
  :$@
fi
