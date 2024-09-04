# Kubernetes Cluster Configuration from Scratch (In Progress) 🚧

## Introduction

This repository chronicles the journey of constructing a Kubernetes cluster from the ground up. A unique aspect of this project is the utilization of Docker containers 🐳 for all nodes, including the control plane, eschewing the conventional use of virtual machines. This approach promises a lightweight, adaptable, and scalable cluster environment.

## Project Goals 🎯

- *Manual Configuration*: The cluster will be configured without relying on tools like kubeadm for a deep understanding of Kubernetes internals.
- *Docker-Based Nodes*: All cluster components will run within Docker containers for efficiency and scalability.
- *High Availability*: The cluster will employ multiple control plane and etcd nodes for redundancy and fault tolerance.

## Cluster Architecture 🗺️

- *Total Nodes*: 
  - *Control Plane Nodes*: 3 🧠
  - *etcd Nodes*: 3 🗄️
  - *Worker Nodes*: 2 👷‍♂️

 **Note**: The count of each Kubernetes component (Control Plane Nodes, etcd Nodes, Worker Nodes) can be adjusted as needed. These values should be specified in the `node_counts.json` file.

## Setup Steps 🛠️

1. *etcd Cluster Establishment* (🚧 In Progress)
   - Configure a highly available etcd cluster across three nodes for reliable data storage.
   - Implement necessary security measures and backups.
   
2. *Control Plane Deployment* (🚧 In Progress)
   - Set up Kubernetes API server, controller manager, and scheduler on three dedicated nodes.
   - Implement load balancing for high availability and fault tolerance.
   - Configure secure communication channels between components.
   
3. *Worker Node Configuration* (🚧 In Progress)
   - Install kubelet and kube-proxy on two worker nodes.
   - Join worker nodes to the Kubernetes cluster.
   - Configure network policies and resource quotas.
   
4. *Cluster Validation and Testing* (🚧 In Progress)
   - Conduct comprehensive tests to verify cluster functionality and performance.
   - Implement monitoring and logging solutions.
   - Optimize cluster configuration based on test results.
   
5. *Application Deployment* (🚧 In Progress)
   - Deploy sample applications to demonstrate cluster capabilities.
   - Explore deployment strategies and scaling options.

## Why Docker? 🤔

- *Efficiency*: Reduces overhead compared to virtual machines.
- *Scalability*: Enables easy management and scaling of nodes.
- *Simplified Management*: Leverages Docker's streamlined configuration process.

## Future Enhancements 🔮

- Explore advanced Kubernetes features like network policies, storage orchestration, and service meshes.
- Implement automated deployment and scaling mechanisms.
- Integrate with cloud platforms for hybrid or multi-cloud environments.

## Contributing 🤝

Contributions to this project are welcome! Feel free to submit bug reports, feature requests, or code improvements.

## License 📜

This project is licensed under the [Apache-2.0 license](./LICENSE)

---

*Note*: This project is currently under development. More detailed information and documentation will be added as the project progresses.

## Acknowledgements

Some portions of the code were inspired by and adapted from [Kubernetes the Hard Way by Kelsey Hightower](https://github.com/kelseyhightower/kubernetes-the-hard-way).

