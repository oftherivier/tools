#!/bin/bash
. $OTR_BASE

:new() {
  call "$DIR/new/new" $@
}

:lint() {
  eslint ${@:-.}
}

:format() {
  prettier --write ${@:-.}
}

:release() {
  maybeRun checks
  maybeRun build
  standard-version $@
  git push --follow-tags origin master
  npm publish
}

:typetest() {
  tsd $@
}

:test() {
  tap ${@:-'./tests/**/*.test.*'}
}

:build() {
  call "$DIR/build" $@
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

for dir in $OTR_EXTENSION_DIRS; do
  DIR="$dir/cli" . $dir/cli/cli.sh
done

run $@
end
