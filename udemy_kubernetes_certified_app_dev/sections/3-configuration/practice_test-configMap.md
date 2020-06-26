kubectl get pod webapp-color -o yaml > webapp-color.yaml

k get configmaps

kubectl create configmap <config-name> --from-literal=<key>=<value>
kubectl create configmap webapp-config-map --from-literal=APP_COLOR=darkblue
```yaml
spec:
  envFrom:
  - configMapRef:
      name: app-config
```

## Practice Test - Secrets
k create secret generic db-secret --from-literal=DB_Host=sql01 --from-literal=DB_User=root --from-literal=DB_Password=password123

## Practice Test - Security Contexts and Users
```yaml
spec:
  containers: 
    - name: foo
      securityContext:
        runAsUser: 1010
```

kubectl exec -it ubuntu-sleeper -- date -s '19 APR 2012 11:14:00'

## Practice Test - Service Accounts

```yaml
spec:
  serviceAccount: dashbaard-sa
```

kubectl edit dashboard-app

kubernickles

## Practice Test - Resource limits
spec:
  containers: 
    resources:  
      limit/requests:
        cpu: 0.5
        memory: 1Mi
        disk: 256M

## Practice Test - Taints and Tolerates

k taint node node01 spray=mortein:NoSchedule
untaint
k taint node node01 spray-

Run a pod imperitvily 
k run mosquito  --image=nginx # deprecated
k run --generator=run-pod/v1 or k create instead

    spec: 
tolerations:
- key: "spray"
  operator: "Equal"
  value: "mortein"
  effect: "NoSchedule"

## Practice Test - Affinity

k create deployment blue --image=nginx
k scale deployment blue --replicas=3

k get pods -o wide  

    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: color
                operator: In
                values:
                - blue  

## Practice Test - Multi container pods 
SideCar: logging-agent
Adapter: Transform data before sending on 
Ambasador: Proxy localhost to dev/test/prod db

k get pods --namespace=elastic-stack

kubectl exec -it app cat /log/app.log

- name: sidecar
  image: kodekloud/filebeat-configured
  volumeMounts: 
  - name: log-volume
    mountPath: /var/log/event-simulator/s

## Practice Test - Readiness and liveness probes

* Readiness probes: determin if pod is in "Ready" state, http (api), tcp (dbs), exec
* Liveness probes: determin if pod should be restarted or not, http, tcp, exec

```yaml
spec:
  containers:
    ...
    readinessProbe:
      httpGet:
        path: /api/ready
        port: 8080
```

```yaml
    livenessProbe:
      httpGet:
        path: /api/live
        port: 8080
      periodSeconds: 1
      initialDelaySeconds: 80
```

## Logging

k logs -f webapp-1

## Monitoring and Debugging

Metrics Server
- aggregates and stores metrics n-momory 

Create a metrics server by cloning it and running the yaml
- k create -f path/to/metric-server.yaml

Get cpu and memory info for nodes or pods:
`kubectl top node`
`kubectl top pod`

## Labels and Selectors

labels: 
selectors: 
annotations:

k get pods --selector env=dev
k get all --selector env=prod
k get pods --selector bu=finance,env=prod,tier=frontend

## Rolling updates and Rollbacks

Update an existing deploy with changes to the yaml file
`kubectl apply –f deployment-definition.yml`

kubectl create –f deployment-definition.yml
kubectl get deployments
kubectl apply –f deployment-definition.yml
kubectl set image deployment/myapp-deployment nginx=nginx:1.9.1
kubectl rollout undo deployment/myapp-deployment

stategy: 
  type: RollingUpdate/Recreate

## Jobs

spec:
  restartPolicy: Never

## Cron Jobs

