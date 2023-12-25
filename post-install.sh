#!/usr/bin/env bash



# Fix: Chromium taking long time to open in first time
# https://bugs.archlinux.org/task/75650
echo no-allow-external-cache:0:1 | gpgconf --change-options gpg-agent
