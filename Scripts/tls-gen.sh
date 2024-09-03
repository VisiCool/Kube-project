#!/bin/bash

# File paths
KUBE_COMP="kube-components.json"
NODES_FILE="node_counts.json"
CA_KEY="ca.key"
CA_CERT="ca.crt"
CONFIG_FILE="openssl_k8s.conf"

#create ca.key and ca.cert
openssl genrsa -out "$CA_KEY" 4096
openssl req -x509 -new -sha512 -key "$CA_KEY" -days 365 -config "$CONFIG_FILE" -out "$CA_CERT"

# Read node counts from JSON
ETCD_COUNT=$(jq -r '.["etcd-server"]' "$NODES_FILE")
CONTROLPLANE_COUNT=$(jq -r '.["controlplane"]' "$NODES_FILE")
WORKER_COUNT=$(jq -r '.["workernode"]' "$NODES_FILE")

# Function to generate keys and certificates based on JSON data
generate_certs() {
    local TYPE="$1"

    COMO_TYPE="${TYPE}${i}"
    openssl genrsa -out "${COMP_TYPE}.key" 4096
    openssl req -new -key "${COMP_TYPE}.key" -sha256 -config openssl_k8s.conf -section "$type" -out "${COMP_TYPE}.csr"
    openssl x509 -req -days 180 -in "${COMP_TYPE}.csr" -sha256 -CA "$CA_CERT" -CAkey "$CA_KEY" -CAcreateserial -out "${COMP_TYPE}.crt"
    echo "Generated ${COMP_TYPE}.key and ${COMP_TYPE}.crt"
}

# Function to copy certificates and keys in host directory
copy_certificates() {
    local TYPE=$1
    local host=$2
    local path=$3

    COMP_TYPE="${TYPE}${i}"
        # Create the necessary directory on the remote host
        ssh root@$host "mkdir -p $path" 

        # Copy the CA certificate
        scp $CA_CERT root@$host:$path

    # Copy the specific certificate and key files
    scp $COMP_TYPE.crt root@$host:$path/$COMO_TYPE
    scp $COMP_TYPE.key root@$host:$path/$COMO_TYPE
    done
}





