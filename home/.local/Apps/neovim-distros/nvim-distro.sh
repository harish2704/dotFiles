#!/usr/bin/env bash
THIS_DIR=$(dirname $(readlink -f $0))

nvconf="$THIS_DIR/$PKG"

if [[ ! -d $nvconf ]]; then
  echo "invalid \$PKG. Available values:"
  ls `dirname $nvconf`
  exit
fi


mkdir -p $nvconf/cache

if [ -z "$GUITERM" ]; then
  env XDG_CACHE_DIR=$nvconf/cache XDG_CACHE_HOME=$nvconf/cache XDG_DATA_HOME=$nvconf/share XDG_CONFIG_HOME=$nvconf nvim $@
else
  $GUITERM -e env XDG_CACHE_DIR=$nvconf/cache XDG_CACHE_HOME=$nvconf/cache XDG_DATA_HOME=$nvconf/share XDG_CONFIG_HOME=$nvconf nvim $@
fi
