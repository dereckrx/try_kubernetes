## Networking

Node IP: 172.17.0.18

### ingress-space ns
ingress-service: Service<NodePort>: 30008 -> [name=nginx-ingress]:80
nginx-ingress-controller: Deploy -> :80 -> Pod with name=nginx-ingress
nginx-ingress-controller: Pod, routes requests to Ingress (with magic)

### app-space ns
router-ingress: Ingress
- /wear -> wear-service:8080
- /eat -> food-service:8080

wear-service: Service<ClusterIP>:8080
food-service: Service<ClusterIP>:8080

webapp-food: Deploy
webapp-wear: Deploy

curl 172.17.0.18:30008/eat

## Ingress & Egress

Incoming and outgoing traffic

frontend-service:
- ingress from port :80
- egress to api-service:5000

api-service:
- ingress from port :5000
- egress to db-service:3306

## Cluster's Virtual Private network

- By default "all-allow" communication between pods
- all pods are on the same VPN, so they can all talk to each other
  - using IPs, or service-names, or pod-names

## Network Policy

Restrict Ingress or Egress traffic to a pod group and their port
- Uses pods ports