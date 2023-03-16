#!/usr/bin/env bash
THIS_DIR=$(dirname $(readlink -f $0))

env PKG=lunarvim alacritty -e "$THIS_DIR/nvim.sh" "$@" &
