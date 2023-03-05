#! /bin/bash

set -e

die() { echo "$*" >&2 ; exit 1 }

test -e config.sh || die "config.sh missing"
. config.sh

test -s eduroamCA.key.pem && die "eduroamCA.key.pem: file already exists"
test -s eduroamCA.cert.pem && die "eduroamCA.cert.pem: file already exists"

# if user messes up passphrase in a previous attempt, openssl leaves an empty .key file
test -e eduroamCA.key.pem && rm eduroamCA.key.pem

cat <<__EOF__ > openssl.cnf.tmp

distinguished_name  = server_distinguished_name
x509_extensions     = x509_extensions

[server_distinguished_name]

[x509_extensions]

basicConstraints     = CA:true
keyUsage             = critical, keyCertSign
subjectKeyIdentifier = hash

__EOF__

openssl req -x509 -config openssl.cnf.tmp \
    -newkey rsa:4096 -keyout eduroamCA.key.pem \
    -subj "$ca_subject" \
    -days 36585 \
    -out eduroamCA.cert.pem

rm *.tmp
