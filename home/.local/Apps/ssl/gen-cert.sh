#!/usr/bin/env bash

if [ -z "$1"]; then
  echo "Usage: gen-cert.sh <domainname>"
  exit 1
fi

DomainName="$1";

settingsRoot(){
cat<<EOF

[req]
prompt = no
distinguished_name = dn

[ dn ]
C=IN
ST=Some state
O=Localhost.in CA Authority
emailAddress=admin@localhost.in
CN=localhost.in

EOF
}

settings(){
  localdomain=$DomainName
  cat<<EOF
[req]
prompt = no
distinguished_name = dn
req_extensions     = req_ext
x509_extensions = usr_cert

[ dn ]
C=IN
ST=Some state
O=$localdomain Orgaization
emailAddress=admin@$(echo $localdomain | sed 's/^\*\.//')
CN = $localdomain
 
[ req_ext ]
subjectAltName=DNS:$localdomain

[ usr_cert ]
subjectAltName=DNS:$localdomain
EOF
}

echo "Generating Root CA key"
[[ -f rootCA.key ]] || openssl genrsa -des3 -out rootCA.key 2048


echo "Generating Root CA certificate"
[[ -f rootCA.pem ]] || openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem -config <(settingsRoot)

echo "Generating certificate key"
[[ -f $DomainName.key ]] || openssl genrsa -des3 -out $DomainName.key 1024

echo "Generating Certificate signing request"
[[ -f $DomainName.csr ]] || openssl req -nodes -sha256 -newkey rsa:2048 -keyout $DomainName.key -out $DomainName.csr -config <( settings )



echo "Signing CSR with root key"

[[ -f $DomainName.crt ]] || openssl x509 -req -in $DomainName.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out $DomainName.crt -days 500 -sha256 -extfile <(printf "subjectAltName=DNS:$DomainName")




