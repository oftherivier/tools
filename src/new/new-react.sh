#!/bin/bash
dir="$(dirname "$0")"
$dir/new-base.sh $@
$dir/../cli.sh bootstrap
