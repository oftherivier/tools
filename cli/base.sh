#!/bin/bash
set -e
hasRan=false
cmdFound=false

hook:help() {
  declare -F | awk '{print $NF}' | grep '^:' | sed -E 's/:/* /g'
}

hook:empty() {
  help
}

maybeRun() {
  if (yarn run 2> /dev/null | grep $1); then
    yarn run $1
  fi
}

call() {
  DIR="$(dirname $1)" "$1.sh" ${@:2}
}

extend() {
  DIR="$(dirname $1)" OTR_MAIN=false . "$1.sh" ${@:2}
}

run() {
  [[ "$hasRan" == true ]] && return
  [[ "$OTR_MAIN" == false ]] && return

  if [[ -z "$@" ]]; then
    cmdFound=true
    hook:empty
  elif [[ "$@" == "--help" ]] || [[ "$@" == "help" ]]; then
    cmdFound=true
    hook:help
  elif [[ "$(declare -F :$1)" != "" ]]; then
    cmdFound=true
    :$@
  fi

  hasRan=true
}

end() {
  if [[ "$hasRan" == true ]] && [[ "$cmdFound" == false ]]; then
    hook:help
  fi
}
