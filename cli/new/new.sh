#!/bin/bash
. $OTR_BASE

:vanilla() {
  call "$DIR/new-vanilla" $@
}

:es5() {
  call "$DIR/new-es5" $@
}

:react() {
  call "$DIR/new-react" $@
}

run $@
