#!/bin/bash
set -e
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
  maybeRun checks
  standard-version $@
  git push --follow-tags origin master
  yarn publish
}

:typetest() {
  tsd $@
}

:test() {
  tap ${@:-'./tests/**/*.test.*'}
}

:bootstrap() {
  if [[ ! -s "$HOME/.avn/bin/avn.sh" ]]; then
    npm i -g n avn avn-n avn-nvm
    n $(cat .node-version)
    . "$HOME/.avn/bin/avn.sh"
  fi

  yarn install
  maybeRun bootstrap
  maybeRun checks
}

:help() {
  declare -F | awk '{print $NF}' | grep '^:' | sed -E 's/:/* /g'
}

maybeRun() {
  (yarn run 2> /dev/null | grep $1 2>&1 > /dev/null) && yarn run $1
}

if [[ -z "$@" ]] || [[ "$@" == "--help" ]]; then
  :help
else
  :$@
fi
