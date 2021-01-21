## Services

Service
- port: 80 listening for incoming request on :80
- targetPort: 80, forward requests to mypod:80

Example:
- nodePort: 30008
- svcPorts: 80 -> 8080
- mypod.port: 8080

curl http:my-cluster:30008 -> 80 -> mypod:8080

node port service
- listens on a port and forwards request to pods
- can span across multiple nodes, or a single node with many identical pods

Service Types:
- NodePort: Enable external comms between outside world and node.
    - Expose an internal pod via a port on the node
- ClusterIP: Enable internal comms between nodes
  - Expose a virtual IP for a cluster of nodes so frontend node can talk to backend node
- Load Balancer: Balance request to you frontend servers (pods)

Node Port:
- NodePort(node): 30008, 
- Port(service): 80, 
- TargetPort(pod): 80

```yaml
apiVersion: v1
kind: Service
metadata:
  name: front-end-service
spec:
  type: NodePort
  ports:
  - nodePort: 30000
    port: 80
    targetPort: 80
  selector: 
  - app: myapp
    type: front-end
```

### ClusterIP

```yaml
apiVersion: v1
kind: Service
metadata:
  name: back-end-service
spec:
  type: ClusterIP
  ports: 
  - targetPort: 80
    port: 80
  selector: # Copy labels from pod pod.metadata.labels
    app: myapp 
    type: back-end
```
