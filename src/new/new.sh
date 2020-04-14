#!/bin/bash
set -e
dir="$(dirname "$0")"

:vanilla() {
  $dir/new-vanilla.sh $@
}

:react() {
  $dir/new-react.sh $@
}

:help() {
  declare -F | awk '{print $NF}' | grep '^:' | sed -E 's/:/* /g'
}


if [[ -z "$@" ]] || [[ "$@" == "--help" ]]; then
  :help
else
  :$@
fi
