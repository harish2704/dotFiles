#!/usr/bin/env bash

THIS_DIR=$(dirname $(readlink -f $0))

cd $THIS_DIR

python -m http.server 8082
