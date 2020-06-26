## Services

node port service
- listens on a port and forwards request to pods
- can span across multiple nodes, or a single node with many identical pods

Service Types:
- NodePort: Expose a port for one or many pods
- ClusterIP: Expose an IP for a cluster of nodes
- Load Balancer

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
