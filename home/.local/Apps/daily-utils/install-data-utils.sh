#!/usr/bin/env bash

# Download following
# 1. https://github.com/cube2222/octosql
# 2. https://github.com/TomWright/dasel
# 3. https://github.com/multiprocessio/dsq
# 4. https://github.com/roapi/roapi
# 5. https://github.com/dcmoura/spyql

Projects=(
  https://github.com/cube2222/octosql
  https://github.com/TomWright/dasel
  https://github.com/multiprocessio/dsq
  https://github.com/roapi/roapi
  https://github.com/dcmoura/spyql
)

getTarball(){
  local projUrl=$1
  local githubRepo=$(echo $projUrl | sed 's#https://github.com/##g')
  local tarballs=$(curl -s "https://api.github.com/repos/$githubRepo/releases/latest" | grep 'browser_download_url.*gz' | grep -E 'amd64|x86_64' | grep linux  | cut -d'"' -f4)
  echo $tarballs
}

downloadPkg(){
  local projUrl=$1
  latestTarball=$(getTarball "$projUrl")
  echo wget -c "$latestTarball"
}

main(){
  for projUrl in ${Projects[@]} ; do
    downloadPkg "$projUrl"
  done
}

main
