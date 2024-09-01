# TLS Certificate to ControlPlane, Worker and ETCD node

**OpenSSL will be used to create key, certificate and CSR**


## Generate CA 


```bash
openssl genrsa -out ca.key 4096
```

Above key will be used to create CA CSR and certificate

```bash
openssl req -x509 -new -nodes -key ca.key -sha256 -days 3650 -out ca.crt -config openssl.cnf
```

