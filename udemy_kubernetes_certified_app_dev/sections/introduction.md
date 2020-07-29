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

- same network namespace
- same storage



