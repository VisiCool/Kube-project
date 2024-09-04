#!/bin/bash

# File paths
KUBE_COMP="Kube-project/Scripts/kube-components.json"
NODES_FILE="Kube-project/node_counts.json"
CA_KEY="ca.key"
CA_CERT="ca.crt"
CONFIG_FILE="openssl_k8s.conf"

# ... existing code for CA key and cert generation ...

# Read node counts from JSON
ETCD_COUNT=$(jq -r '.["etcd-server"]' "$NODES_FILE")
CONTROLPLANE_COUNT=$(jq -r '.["controlplane"]' "$NODES_FILE")
WORKER_COUNT=$(jq -r '.["workernode"]' "$NODES_FILE")

# Function to generate keys and certificates
generate_certs() {
    local type=$1
    local i=$2

    NAME="${type}${i}"
    openssl genrsa -out "${NAME}.key" 4096
    openssl req -new -key "${NAME}.key" -sha256 -config "$CONFIG_FILE" -section "$type" -out "${NAME}.csr"
    openssl x509 -req -days 180 -in "${NAME}.csr" -sha256 -CA "$CA_CERT" -CAkey "$CA_KEY" -CAcreateserial -out "${NAME}.crt"
    echo "Generated ${NAME}.key and ${NAME}.crt"
}

# Function to copy certificates and keys to host directory
copy_certificates() {
    local type=$1
    local host=$2
    local path=$3
    local i=$4

    NAME="${type}${i}"
    ssh root@$host "mkdir -p $path"
    scp $CA_CERT root@$host:$path
    scp $NAME.crt root@$host:$path/$NAME.crt
    scp $NAME.key root@$host:$path/$NAME.key
}

# Process components
process_components() {
    local cert_type=$1
    local components=$(jq -r ".$cert_type | keys[]" "$KUBE_COMP")

    for component in $components; do
        local node_type=$(jq -r ".$cert_type[\"$component\"][0]" "$KUBE_COMP")
        local path=$(jq -r ".$cert_type[\"$component\"][1]" "$KUBE_COMP")
        
        if [ "$cert_type" == "single-certificate" ]; then
            generate_certs "$component" ""
            for i in $(seq 1 $CONTROLPLANE_COUNT); do
                copy_certificates "$component" "controlplane$i" "$path" ""
            done
        else
            local count
            case $node_type in
                "etcd-node") count=$ETCD_COUNT ;;
                "controlplane") count=$CONTROLPLANE_COUNT ;;
                "node") count=$WORKER_COUNT ;;
            esac
            
            for i in $(seq 1 $count); do
                generate_certs "$component" "$i"
                copy_certificates "$component" "${node_type}${i}" "$path" "$i"
            done
        fi
    done
}

# Main execution
process_components "single-certificate"
process_components "multiple-certificate"