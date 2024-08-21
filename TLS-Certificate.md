# Kubernetes Certificate and Connection Details

This document provides an overview of the certificate structure and connection details for a Kubernetes cluster. The following sections outline the server and client certificates used for securing communication between different components of the Kubernetes architecture.

## Certificate and Connection Overview

### 1. Server Certificates

These certificates are used by various servers within the Kubernetes architecture to authenticate and secure communication with clients.

| *Server*            | *Certificate*          | *API Request Direction*                               | *Used By*                                           |
|-----------------------|--------------------------|---------------------------------------------------------|-------------------------------------------------------|
| *Kube API Server*    | api-server.crt, api-server.key | ← Admin, Scheduler, Kube Proxy, Controller Manager    | Admin, Scheduler, Kube Proxy, Controller Manager       |
| *etcd Server*        | etcd-server.crt, etcd-server.key | ← Kube API Server                                      | Kube API Server                                      |
| *Kubelet Server*     | kubelet.crt, kubelet.key | ← Kube API Server                                      | Kube API Server                                      |

### 2. Client Certificates

These certificates are used by various clients to make secure API requests to the servers.

| *Client*                  | *Certificate*                              | *API Request Direction*                               | *Used By*                                           |
|-----------------------------|----------------------------------------------|---------------------------------------------------------|-------------------------------------------------------|
| *Admin (User)*            | admin.crt, admin.key                     | → Kube API Server                                      | Kube API Server                                       |
| *Scheduler*               | scheduler.crt, scheduler.key             | → Kube API Server                                      | Kube API Server                                       |
| *Controller Manager*      | controller-manager.crt, controller-manager.key | → Kube API Server                               | Kube API Server                                       |
| *Kube Proxy*              | kube-proxy.crt, kube-proxy.key           | → Kube API Server                                      | Kube API Server                                       |
| *Kube API Server* (etcd)  | api-server-etcd-client.crt, api-server-etcd-client.key | → etcd Server                                    | etcd Server                                           |
| *Kube API Server* (kubelet) | api-server-kubelet-client.crt, api-server-kubelet-client.key | → Kubelet Server                         | Kubelet Server                                        |

### 3. Certificate Authority (CA)

#### CA for Kubernetes

The following certificates are issued by the Kubernetes Certificate Authority (CA) for various clients and servers:

- *Client Certificates*:
  - admin.crt, admin.key → Kube API Server
  - scheduler.crt, scheduler.key → Kube API Server
  - controller-manager.crt, controller-manager.key → Kube API Server
  - kube-proxy.crt, kube-proxy.key → Kube API Server
  - api-server.crt, api-server.key ← Admin, Scheduler, Kube Proxy, Controller Manager
  - kubelet.crt, kubelet.key ← Kube API Server
  - api-server-kubelet-client.crt, api-server-kubelet-client.key → Kubelet Server

#### CA for etcd

For simplicity, the same Kubernetes CA is used to issue the following server certificates for etcd:

- *Server Certificates*:
  - etcd-server.crt, etcd-server.key ← Kube API Server
  - api-server-etcd-client.crt, api-server-etcd-client.key → etcd Server

## Conclusion

This structure ensures that all components in the Kubernetes architecture can securely communicate using certificates issued by the CA. The direction of API requests is clearly indicated, helping you understand the flow of communication between services.

For any further details or questions, feel free to raise an issue or contact the repository maintainers.
