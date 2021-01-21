## Clusters

```
Cluster
    -< Services
        -< Nodes
            -< Pods
                -< Containers
```

### Nodes

- Master Node: assigns work to nodes
- Nodes: contain pods, pods contain container(s)

Pods: smallest unit of work

Replica Sets / Replication controller / deployments:

- Scale pods, maintain desired state, rollbacks, updates

Services:
- Enable internal (ClusterIP) between nodes
- and external requests (NodePort) from outside world
- Provide stable IP/Ports for node or groups of nodes
- Provide load balancing requests to a group of nodes

### Scaling

- add more replica pods first
- then add more nodes if needed
- DO NOT add more containers to a single pod

When a POD has more than one container

- helper container: ex: processing file uploads

### Namespace:

Pod's containers talk to each other using localhost

- same network namespace
- same storage

## Pods

- Defined with a declarative manifest file
- Somewhere between a VM and container
- Contains 1 container generally, but can have multiple
- One IP per pod, multiple containers are exposed via ports
  - ex: `10.0.10.15:80` and `10.0.10.15:8000`

All pods communicate on the "Pod Network". Inside pods, containers communicate via localhost and ports.

## Replica Set / Replication Controller

- Manages pods, a pod container
- defines desired state (ex: number of pods to keep running)

## Services

How do we access the pods? Via Browser or even Pod-to-pod communication?

Pods come and go as they are scaled and healed. So "Services" give us single reliable IP to talk to them.

Services:

- Load balances between pods (Randomly if ClusterIP/NodePort)
- Exposes single reliable DNS,IP,Port to connect the pods
  - ex: IP: 10.0.0.50, dns: "myservice", port:30050
- Port is cluster wide
  - So each node has a port, and other nodes can use that port to talk to each other

### Services with Yaml (declarative)

Reliable (static) network endpoint (IP)

- IP address, DNS name, and port
  Expose Pods to the outside world
- NodePort provides a cluster wide port for this node
- Load balances this node

## Deployments

Updates and rollbacks

Manages replica sets, and replica sets manage pods

Deployment - Replica Set
-< Pods

$ kubectl describe deploy

Apply the new deploy.yml changes and record the command in the history
$ kubectl apply -f deploy.yml --record

View the status
$ kubectl rollout status deployment hello-deploy

See history if you need to rollback
$ kubectl rollout history deployment hello-deploy

```
deployment.extensions/hello-deploy
REVISION  CHANGE-CAUSE
1         kubectl apply --filename=deploy.yml --record=true

`deployment "hello-deploy" successfully rolled out`
```

\$ kubectl rollout undo deployment hello-deploy --to-revision=1

## Namespaces
Two people named Mark, different families
Inside their house they say Mark
Referring to other marks they say full name 'Mark Smith'
Each house has it's own roles and shared resources: 
- Mark S. Father vs Mark A. Son

Services inside a pod (house) can refer to each other by name `db-service`.
Talking to a service in another pod uses full namespace (full name).
`db-service.dev.svc.cluster.local`

Namespace Examples:
* default
* dev, prod