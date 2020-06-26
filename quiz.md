## Ingress 
Ingress Resource: when to use

Use when you need one IP to route to many services.  

Resource for path and subdomain routing rules.

/watch -> video-service
docs.example.com -> docs-service

ex: Reverse Proxy, load balancer

## Service Types
ClusterIP:
- use when you need a static internal IP for one or more Pods
- avoids hardcoding pod IP addresses
- ex: IP -< backends
- ex: backend -> mysql
NodePort:

LoadBalancer: 
