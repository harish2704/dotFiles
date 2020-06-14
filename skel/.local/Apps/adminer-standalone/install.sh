#!/usr/bin/env bash

VER=4.7.5
wget "https://github.com/vrana/adminer/releases/download/v${VER}/adminer-${VER}.zip"
# wget "http://127.0.0.1:8080/adminer-${VER}.zip"


unzip "adminer-${VER}.zip"

mv adminer-${VER} www

cat<<EOF > www/index.php
<?php header("Location: adminer/plugin.php"); ?>
EOF

# Install & setup FCSqliteConnectionWithoutCredentials plugin.
cd www/plugins
cat<<EOF > fc-sqlite-connection-without-credentials.php
<?php
class SqliteConnectionWithoutCredentials {
    function login(\$login, \$password) {
            return true;
    }
}
EOF
sed -i '/\$plugins = array(/a \\t\tnew SqliteConnectionWithoutCredentials,' ../adminer/plugin.php

