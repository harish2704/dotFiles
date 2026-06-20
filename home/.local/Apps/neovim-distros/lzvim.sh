#!/usr/bin/env bash
THIS_DIR=$(dirname $(readlink -f $0))
PKG=LazyVim

nvconf="$THIS_DIR/$PKG"

if [[ -d $nvconf ]]; then
  mkdir -p $nvconf/cache
  if [[ -n "$NO_GUI" ]]; then
  env XDG_CACHE_DIR=$nvconf/cache XDG_CACHE_HOME=$nvconf/cache XDG_DATA_HOME=$nvconf/share XDG_CONFIG_HOME=$nvconf nvim $@
  else
  exec -a "Lazyvim" alacritty -e env XDG_CACHE_DIR=$nvconf/cache XDG_CACHE_HOME=$nvconf/cache XDG_DATA_HOME=$nvconf/share XDG_CONFIG_HOME=$nvconf nvim $@ &
  fi
else
  echo "invalid \$PKG. Available values:"
  ls `dirname $nvconf`
fi
