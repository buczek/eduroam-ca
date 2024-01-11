# Howto

1) Create config:

        cp config_example.sh config.sh
        vi config.sh

2) Create key and certificate for CA

        ./create_ca.sh

    Asks for new password for the CA key. Creates `eduroamCA.key.pem` and `eduroamCA.cert.pem`.
   **The password will be needed for future certificate rollovers!**

4) Create key and certificate for radius server

        ./create_server.sh

    Asks for the password for the CA key set in the previous step. Creates `server.key.pem` and `server.cert.pem`

5) (Optionally) create emtpy CRL

        ./create_empty_crl.sh

    Creates `eduroam_crl.der`

6) Distribute the files

    `eduroamCA.cert.pem` should be configured into a profile at https://cat.eduroam.org/.
    `server.key.pem` and `server.cert.pem` should go to your eduroam IdP radius server. `eduroam_crl.der` should be published at your configured CRL URL.

