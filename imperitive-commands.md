
## Syntax

kubectl <action> <resourceType> <name> <options>
* Actions: CRUD: get, describe, edit, delete
* ResourceTypes: pods, replicasets, deployments, services, nodes

## Primary commands

`kubectl create -f pod_definition_file.yaml`

`kubectl apply -f pod_definition_file.yaml`

OR Use the edit command to update pod properties. 
`kubectl edit pod <pod-name>`

### get
```
get -o yaml: output config to editor
get -o yaml > new-file.yaml: output to file
get -o wide: more detailed
get --all-namespaces
get all
```

### options
--dry-run: only output success/failure
--namespace=<namespace>

## Shortcuts ------------------
po: pods
rs: repicasets
deploy: deployments
svc: services
ns: namespace (-n namespace)
netpol: network policies
pv: persistent volume
pvc: persistent volume claims
sa: service account

## Debug --------------------

View Logs: k exec -it webapp cat /log/app.log

Extracting the basic yaml from a running resource
`kubectl get deploy busybox --export -o yaml > exported.yaml`

Output yaml if you don't have one
`kubectl get pod <pod-name> -o yaml > pod-definition.yaml`

## Pods (po) ---------------------

create: kubectl create -f config/pod.yml

create: 
k run nginx --image=nginx
k run nginx --image=nginx --restart=Never # Maybe this is no longer required?

create (create file): 
k run redis --image=redis --dry-run=client -o yaml > redis-pod.yaml

create (w/ Labels): 
k run redis --image=redis:alpine --labels=tier=db

Create w port
k run custom-nginx --image=nginx --port=8080

list: k get pods -o wide
describe: k describe pod <name>
delete: kubectl delete pod <name-pod>
edit: k apply -f <name-pod.yaml>
edit: kubectl edit pod <name>
- must delete old instances

### Kubernetes commands and argurments

Override in `pod-definiton.yml`

ENTRYPOINT ["sleep"] -> command: ["sleep"]

CMD ["5"] -> args: ["10"]

## Jobs --------------------------

$ k run nginx --image=nginx --restart=Never  # pod
$ kubectl create job nginx --image=nginx  # job
$ kubectl create cronjob nginx --image=nginx --schedule="* * * * *"  # cronJob
$ kubectl run crontest --image=busybox --schedule="*/1 * * * *" --restart=OnFailure --dry-run -o yaml > crontest-cron.yml

## Replica Sets (rs) -------------
create: k create -f replicaset-definition-1.yaml
list: kubectl get replicaset
describe: k describe rs <name-rs>
debug: kubectl explain replicaset 
edit: kubectl edit replicaset 
scale: `kubectl scale rs myapp-rs --replicas=5`

## Service (svc) --------------
Create a service redis-service to expose the redis application within the cluster on port 6379.
Service: redis-service
Port: 6379
Type: ClusterIp
Selector: tier=db

kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml > redis-service.yaml

kubectl expose rc hello-rc --name=hello-service --target-port=8080 --type=NodePort

kubectl run httpd --image=httpd:alpine --port=80 --expose

create: `kubectl create -f config/service.yml`

describe: `kubectl describe svc hello-service`

list: `k get svc`

## Deployment (deploy) --------------
Create: 

kubectl create deploy webapp --image=kodekloud/webapp-color --replicas=3 --dry-run=client -o yaml > webapp.yaml

kubectl create deploy nginx --image=nginx 

kubectl create deploy redis-deploy --namespace=dev-ns --image=redis --replicas=2

kubectl create deploy nginx -image=nginx --dry-run=client -o yaml > nginx-deployment.yaml

kubectl run nginx --image=nginx --replicas=3 --dry-run -o yaml > nginx-deploy.yml



## Namespace (ns or -n) ----------------

create: k create ns dev-ns

Set namespace
`kubectl config set-context $(kubectl config currentContext) --namespace=dev`

## Persistent Volume (pv) and Volume Claim (pvc) -----------

k get pvc # persistentvolumeclaim
k get pv # persistentvolume


## Secrets -------------------

```s
$ kubectl create secret generic my-secret --from-literal=foo=bar -o yaml --dry-run > my-secret.yaml
```