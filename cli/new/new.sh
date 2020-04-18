#!/bin/bash
. $OTR_BASE

:vanilla() {
  call "$DIR/new-vanilla" $@
}

:react() {
  call "$DIR/new-react" $@
}

run $@
