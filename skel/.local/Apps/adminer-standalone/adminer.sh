#!/usr/bin/env bash

appDir=$(dirname $(readlink -f $0));

cd "$appDir/www";
port="$PORT";
if [ -z "$port" ]; then port="7777"; fi

mkdir -p ../sess
php -S "0.0.0.0:$port" -d session.save_path=$PWD/../sess & echo "Adminer server started.. PID: $!";
