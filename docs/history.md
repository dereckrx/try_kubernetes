## History

### In the beginning, there was servers

Big overpowered Server for 1 app, lots of wasted resources

VMware: run multiple apps on a single server

- Hypervisor to manage VMs
- Ration out resources of the server to the VMs
- Duplicated OSs waset and resources for each app

### Then came containers

Containers: Like VMs only faster and lighter

- 1 OS that is always running
- Add containers on top of the OS
- Server - 1 OS -< Many Containers

Image: VM template, everything bundled to run a container
Containers: Like fast, light-weight VMs
Docker: Makes running Apps inside of Containers easy

## Kubernetes is Orchestration

Kubernetes translates to "Helmsmen"

Cluster of nodes managed by the control pane.

- Master and Nodes/Minions

* K8s: The conductor (Scheduling, scaling, healing, updating)
  - Scaling: Manage load by inc/dec # nodes automatically
  - Self healing: if node goes down, k8s will start a new one
* Docker: Start | stop | delete containers
  - See `Makefile` for docker image repo commands

Kubernetes is like an orchestration.

```
Sports Team | K8s Application
Coach -> Orchestrator
Game Plan -> App manifest
Players -> Services
```