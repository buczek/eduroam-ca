# Howto

1) Create config:

```
cp config_example.sh config.sh
vi config.sh
```

2) Create key and certificate for CA

`./create_ca.sh`

Asks for new password for the CA key. Creates `eduroamCA.key.pem` and `eduroamCA.cert.pem`

3) Create key and certificate for radius server

`./create_server.sh`

Ask for existing password for the CA key. Creates `server.key.pem` and `server.cert.pem`

4) (Optionally) create emtpy CRL

`./create_empty_crl.sh`

Creates `eduroam_crl.der`

5) Distribute the files

`eduroamCA.cert.pem` should be configured into a profile at https://cat.eduroam.org/.
`server.key.pem` and `server.cert.pem` should go to your eduroam IdP radius server. `eduroam_crl.der` should be published at your configured CRL URL.

