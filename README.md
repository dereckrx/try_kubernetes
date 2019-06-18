## Useful links
View all Docker images that you've pushed to docker hub
https://cloud.docker.com/repository/list 

Play with k8s in the browser
https://labs.play-with-k8s.com/

## Overview
See `Makefile` for commands commands.

`kubectl` command line tool is used send API requests and commands to an API-server which runs in the master node inside the cluster.

Cluster
- Master, asigns work to nodes
- nodes, contain pods, pods contain container(s)
- workers
api-command with JSON manifest file (describes desired state)

Pods: unit of work
Replication controller/deployments: Scale pods, desired state, rollbacks, updates
Services: Stable networking: load balancing 

## History

### In the beginning, there was servers
Big overpowered Server for 1 app, lots of wasted resources

VMware: run multiple apps on a single server
- Hypervisor to manage VMs
- Ration out resources of the server to the VMs
- Duplicated OSs waset and resources for each app

### Then came containers
Containers: Like VMs only faster and lighter
* 1 OS that is always running
* Add containers on top of the OS
* Server - 1 OS -< Many Containers

Image: VM template, everything bundled to run a container
Containers: Like fast, light-weight VMs
Docker: Makes running Apps inside of Containers easy

## Kubernetes is Orchestration
Kubernetes translates to "Helmsmen"

Cluster of nodes managed by the control pane. 
- Master and Nodes/Minions

* K8s: The conductor (Scheduling, scaling, healing, updating) 
    * Scaling: Manage load by inc/dec # nodes automatically
    * Self healing: if node goes down, k8s will start a new one
* Docker: Start | stop | delete containers
    * See `Makefile` for docker image repo commands

Kubernetes is like an orchestration.
```
Sports Team | K8s Application
Coach -> Orchestrator
Game Plan -> App manifest
Players -> Services
```

A cluster can have many Services, that can 

```
Cluster 
    -< Services
        -< Nodes
            -< Pods
                -< Containers
```

## Pods

- Defined with a declarative manifest file 
    - see `pods.yml`
- Somewhere between a VM and container
- Contains 1 container generally, but can have multiple
- One IP per pod, multiple containers are exposed via ports
    - ex: `10.0.10.15:80` and `10.0.10.15:8000`
 
All pods communicate on the "Pod Network". Inside pods, containers communicate via localhost and ports. 

```
$ kubectl create -f config/pod.yml
$ kubectl get pods
$ kubectl describe pods
$ kubectl delete pods hello-pod
```

## Replication Controller

- Manages pods, a pod container
- defines desired state (ex: number of pods to keep running)
    - see `replication_controller.yml`

```
$ kubectl create -f config/replication_controller.yml
$ kubectl get rc
$ kubectl describe rc
$ kubectl delete rc hello-rc
```

## Services

How do we access the pods? Via Browser or even Pod-to-pod communication?

Pods come and go as they are scaled and healed. So "Services" give us single reliable IP to talk to them.

Services:

- Load balances between pods
- Exposes single reliable DNS,IP,Port to connect the pods
    - ex: IP: 10.0.0.50, dns: "myservice", port:30050
- Port is cluster wide
    - So each node has a port, and other nodes can use that port to talk to each other

```
$ kubectl create -f config/service.yml
$ kubectl expose rc hello-rc --name=hello-service --target-port=8080 --type=NodePort
$ kubectl describe svc hello-service
```

## View in browser
GET ip of nodes
$ kubectl describe nodes <node-name> (ex: minikube)
```    
Addresses:
  InternalIP:  192.168.64.2
```
$ kubectl describe svc hello-service
```
NodePort:                 <unset>  30752/TCP
```
Then the app is available at: 
[](http://192.168.64.2:30752/)

### Services with Yaml (declarative)
Reliable (static) network endpoint (IP)
- IP address, DNS name, and port
Expose Pods to the outside world
- NodePort provides a cluster wide port for this node
- Load balances this node

```
$ kubectl create -f config/service.yml
$ kubectl get svc
```

## Deployments
Updates and rollbacks

Manages replica sets, and replica sets manage pods

Deployment
    - Replica Set
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
$ kubectl rollout undo deployment hello-deploy --to-revision=1

## Courses Links
https://app.pluralsight.com/library/courses/managing-kubernetes-api-server-pods/table-of-contents
https://app.pluralsight.com/library/courses/kubernetes-installation-configuration-fundamentals/table-of-contents
https://app.pluralsight.com/player?course=kubernetes-installation-configuration-fundamentals&author=anthony-nocentino&name=c841b22a-35fa-4260-b592-e1a755760ace&clip=0&mode=live

## Done
### Thu Jun 6 2019 1:33 PM
This one was really good, hands on with minikube
https://app.pluralsight.com/library/courses/getting-started-kubernetes/table-of-contents

Meh, history part was good but no real info on how k8s works
https://app.pluralsight.com/library/courses/docker-kubernetes-big-picture/table-of-contents
