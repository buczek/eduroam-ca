#! /bin/bash

ca_subject="/C=DE/O=Max-Planck-Institut fuer molekulare Genetik/CN=eduroamCA"

server_fqdn=ratschefummel.molgen.mpg.de
server_subject="/C=DE/O=Max-Planck-Institut fuer molekulare Genetik/CN=ratschefummel.molgen.mpg.de"

# crl_url is optional
#
# If not given, the connectivity test in the cat tool emits the following
# messages:
#
# - "It was not possible to determine the TLS version that was used in the EAP
#    exchange"
#
# - "The server certificate did not include a CRL Distribution Point, creating
#    compatibility problems with Windows Phone 8"
#
# With the first message believed to be caused by a flaw in the cat tool.
#
# If URL is given, make sure, that a (empty) CRL can actually be downloaded
# from it, because some clients might try.
#
crl_url=https://www.molgen.mpg.de/eduroam_crl.der

