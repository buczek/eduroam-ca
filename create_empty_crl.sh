#! /bin/bash

set -e

cat <<__EOF__ > openssl.cnf.tmp
[eduroamCA]
database = /dev/null

__EOF__

openssl ca -config openssl.cnf.tmp -name eduroamCA \
    -gencrl -md md5 \
    -crldays 36585 \
    -keyfile eduroamCA.key.pem -cert eduroamCA.cert.pem \
    -out eduroam_crl.pem.tmp

openssl crl -in eduroam_crl.pem.tmp -out eduroam_crl.der -outform der

rm *.tmp
