#!/bin/bash

# Read node counts from JSON file
ETCD_COUNT=$(jq -r '."etcd-server"' node_counts.json)
CONTROLPLANE_COUNT=$(jq -r '.controlplane' node_counts.json)
WORKERNODE_COUNT=$(jq -r '.workernode' node_counts.json)

# Export as environment variables
export ETCD_COUNT
export CONTROLPLANE_COUNT
export WORKERNODE_COUNT
