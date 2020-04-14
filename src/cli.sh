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
  npm publish
}

:typetest() {
  tsd $@
}

:test() {
  tap $@
}

:bootstrap() {
  if [ -z "$NVM_DIR" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    . "$HOME/.nvm/nvm.sh"
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
