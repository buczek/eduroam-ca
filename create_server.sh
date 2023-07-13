#! /bin/bash

set -e

die() { echo "$*" >&2 ; exit 1; }

test -e config.sh || die "config.sh missing"
. config.sh

######### create cert request

cat <<__EOF__ > openssl.cnf.tmp

distinguished_name  = server_distinguished_name

[server_distinguished_name]

__EOF__

openssl req -config openssl.cnf.tmp \
    -newkey rsa:4096 -keyout server.key.pem -nodes \
    -subj "$server_subject" \
    -out server.certreq.pem.tmp \

######### create cert

# max days 825 for macOS 10.15+ and iOS 13+ [1]
#
# [1] https://wiki.geant.org/display/H2eduroam/EAP+Server+Certificate+considerations

cat <<__EOF__ > openssl.ext.tmp

basicConstraints       = CA:FALSE
keyUsage               = critical, digitalSignature,keyEncipherment
extendedKeyUsage       = serverAuth
subjectKeyIdentifier   = hash
authorityKeyIdentifier = keyid
subjectAltName         = DNS:$server_fqdn
${crl_url:+crlDistributionPoints = URI:$crl_url}

__EOF__

openssl x509 \
    -in server.certreq.pem.tmp -req \
    -CA eduroamCA.cert.pem -CAkey eduroamCA.key.pem \
    -out server.cert.pem \
    -extfile openssl.ext.tmp \
    -days 825

rm *.tmp
