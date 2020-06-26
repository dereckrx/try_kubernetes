## Ingress and Networking

kubectl get ingress --all-namespaces
k edit ingress ingress-wear-watch --namespace=app-space
k get all --all-namespaces

annotations: 
  nginx.ingress.kubernetes.io/rewrite-target: /
  nginx.ingress.kubernetes.io/ssl-redirect: "false"

  
----------------------
http://mycompany.com 
-> dns -> proxy server IP on port 80
-> proxy:80 -> sevice-NodePort:30000 (auto load balances)
-> app pods
-> service-clusterIP -> MySql pods

http://mycompany.com 
-> dns -> cloud service load balancer IP on port 80
-> LB:80 -> sevice-LoadBalancer:30000
-> app pods
-> service-clusterIP -> MySql pods

## Ingress
- exposes a single url for your users
- routes based off of url path
- manages ssl 

http://mycompany.com 
-> dns -> cloud service load balancer IP on port 80
-> service-ingress-loadBalancer:38080 
-> app pods, other pods

### Ingress Controllers
- Istio, HAProxy, nginx, and other options

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-app
spec:
  backend: 
    serviceName: back-end-service
    servicePort: 80
```

## Ingress Rules
route paths or subdomains 

```yaml
# Route by path rule
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-wear-watch
spec:
  rules:
    - http:
        paths:
          - path: /wear
            backend:
              serviceName: wear-service
              servicePort: 80
          - path: /watch
            backend:
              serviceName: watch-service
              servicePort: 80
```
```yaml
# Route By subdomain rules
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-wear-watch
spec:
  rules:
    - host: wear.my-online-store.com
      http:
        paths:
          - backend:
              serviceName: wear-service
              servicePort: 80
    - host: watch.my-online-store.com
      http:
        paths:
          - backend:
              serviceName: watch-service
              servicePort: 80
```
