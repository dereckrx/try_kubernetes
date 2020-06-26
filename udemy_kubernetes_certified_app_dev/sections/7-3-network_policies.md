# Network policies
## Traffic

user -> frontend: port 80
fontend -> backend-api: port 5000
backend-api -> database: port 3306

### Traffic types: 
- ingress: inbound
- egress: outbound

### Traffic rules:
frontend
- ingress on port 80
- egress on port 5000
backend-api
- ingress on port 5000
- egress on port 3306
database
- ingress on port 3306

## Network Security 

network policy: a resource

"Database: allow ingress traffic from 'api-pod' on port 3306"

```yaml
# policy-definition.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata: 
  name: db-policy
spec: 
  podSelector: 
    matchLabels: 
      role: db
  policyTypes:
    - Ingress
  ingress:
  - from: 
    - podSelector: 
      matchlabels: 
        name: api-pod
    ports: 
      - protocol: TCP
        port: 3306
```

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata: 
  name: internal-policy
spec: 
  podSelector: 
    matchLabels: 
      role: internal
  policyTypes:
    - Egress
  egress:
  - from: 
    - podSelector: 
      matchlabels: 
        name: payroll
    ports: 
      - protocol: TCP
        port: 8080
  - from: 
    - podSelector: 
      matchlabels: 
        name: mysql
    ports: 
      - protocol: TCP
        port: 3306
```
Egress Allow: payroll
Payroll Port: 8080
Egress Allow: mysql
MYSQL Port: 3306
