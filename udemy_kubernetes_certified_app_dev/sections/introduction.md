Cluster

- Master Node
- Node

Cluster
  Nodes  
    Pods
      Container

Scaling

- add more replica pods first
- then add more nodes if needed
- DONT add more containers to a single pod

When a POD has more than one container

- helper container: ex: processing file uploads

Pod's containers talk to each other using localhost

- same netowrk namespace
- same storage

## Editing Pods

Output yaml if you don't have one
`kubectl get pod <pod-name> -o yaml > pod-definition.yaml`

command to edit pod properties.
`Use the kubectl edit pod <pod-name>`
