

## INbox

mark what questions have been verified 

sudo -i
ssh <pod>
VIM config

QUIZ: volumeMounts have mountPath not path
QUIZ: volumeMounts: name, mountPath, readOnly
QUIZ: k exec -it webapp-color -- sh. then: nc -vz -w 1 secure-pop
QUIZ: --command when? k run pod (without =)
QUIZ: Debug pod
- look for event errors in describe
- look for liveness, readiness results
- check ports
- look at svc and ingress controllers
QUIZ: WATCH OUT FOR NUMBERS IN CONFGS/ENV, must be wrapped in quotes "
QUIZ: What are the service endpoints?
- Endpoints shows which pod IPs the service is currently forwarding too, you can curl them
QUIZ: are node IPs static? Yes
QUIZ: are pod's IP static? NO, they will change if the pod goes down.
- this is why we need ClusterIP services which create a static IP.
QUIZ: How can access my app at www.myapp.com?
- DNS AName myapp.com -> proxy-server or LB with incoming port :80
  - http://myapp.com -> http://myapp.com:80
- Proxy routes port 80 -> http://<node-ip>:38080
- Create NodePort service with nodePort: 38080
QUIZ: Route from ingress to Pod? 
- ingress my.host.name/path -> serviceName:port -> :targetPort -> podGroup:port
QUIZ: Ingress namespace should be? Same as backend services
QUIZ: what port do you use in a netpol? The pods labels and port (no svc)

k edit deploy nginx-deploy --image=nginx:1.17 --record

resources.requests.cpu: "0.2"
volumeMounts: 
ports:
- containerPort: 6379
nodeName: 
nodeSelector: 
  labelName: labelValue

k logs <pod_name> -c log-x | grep WARN > /opt/dind-878516_logs.txt

Verify Claim: k get pvc -o wide (look for STATUS bound)
Verify Pod -> Claim: k describe pod logger (look for event errors)
Verify ConfigMap in Pod: k exec time-check -n dvl1987 env | grep -i time

## NEXT

k set serviceaccount deployment frontend myuser

k get pod  --show-labels --selector=env=prod,bu=finance,tier=frontend
k explain <resource> and grep for key
k explain ingress --recursive | grep rules -A10
k taint node --help
k taint node node01 "app_type=alpha:NoSchedule"

k label node node02 app_type=beta

k describe node node01 | grep app_type

Taints and tolerations
spec: 
  tolerations:
  - key: "app_type"
    value: "alpha"
    operator: "Equal"
    effect: "Noschedule"

Affinity 
k label node node02 app_type=beta
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: app_type
            operator: In
            values:
            - beta


### Imperitive commands (TODO)
k run nginx --image=nginx (pod)
k run nginx --image=nginx --restart=OnFailure (job)
k run nginx --image=nginx --restart=OnFailure --schedule="* * * * *" (cronjob)

k run nginx --image=nginx --restart=Never 
--port=80 
--namespace=myname 
--command "/bin/sh -c 'echo hellow world'"
--serviceaccount=mysql
--env=HOSTNAME=local
--labels=bu=finance,env=dev
--requests='cpu=100m,memory=256Mi'
--limits='cpu=200m,memory=512Mi'
--port=8080
--dry-run -o yaml

## Setup
TextEdit: Preferences
* Plain text for new files
* Auto correct as type (format > spelling)

alias k=kubectl

vi ~/.vimrc
```bash
set nu
set expandtab
set list
set shiftwidth=2
set tabstop=2
```

k config set-context mycontext --namespace=mynamespace
k config set-context --current --namespace=

--all-namespace

export NS=dev1401
alias get="k get -n $NS pods -o wide"
alias get_all="k get pods --all-namespaces"
alias des="k describe pod -n $NS"
## Syntax

kubectl <action> <resourceType> <name> <options>
* Actions: CRUD: get, describe, edit, delete
* ResourceTypes: pods, replicasets, deployments, services, nodes

## Primary commands

`kubectl create -f pod_definition_file.yaml`

`kubectl apply -f pod_definition_file.yaml`

OR Use the edit command to update pod properties. 
`kubectl edit pod <pod-name>`

k run mypod --image=nginx -l app=mypod --command "sleep 3600"
k expose deploy myDeploy --name=myService --port=6379 --target-port=6379
* optional: --type=nodeport

k create <thing> <name> --from-literal=<secret=value>
RUN: pod
CREATE: deploy, secret, configmap, namespace
EXPOSE: Service
YAML: pv, pvc, netpol

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
--namespace=<namespace> OR -n <ns>

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
cm: configmaps
no: nodes:
netpol: networkpolicies
NO SHORTCUT
    * jobs
    * secrets

## Debug --------------------

List all Resources 
k api-resources | grep -i thingy

View Logs:
k logs throw-dice-pod 
k exec -it webapp cat /log/app.log

Extracting the basic yaml from a running resource
`kubectl get deploy busybox --export -o yaml > exported.yaml`

Output yaml if you don't have one
`kubectl get pod <pod-name> -o yaml > pod-definition.yaml`

Get all with selector
kubectl get all --selector env=prod
kubectl get all --selector env=prod,bu=finance,tier=frontend

### Check connection
k exec -it webapp-color -- sh
(uses netcat nc)
/opt # nc -z -v -w 1 secure-service 80
GOOD: secure-service (10.103.1091.151:80) open
BAD: timeout or "nc: bad address 'secure-service'"

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

list: k get pods --show-labels -o wide
describe: k describe pod <name>
delete: kubectl delete pod <name-pod>
edit: k apply -f <name-pod.yaml>
edit: kubectl edit pod <name>
- must delete old instances

'kubectl get pods --selector env=dev'

### Kubernetes commands and argurments

Override in `pod-definiton.yml`

ENTRYPOINT ["sleep"] -> command: ["sleep"]

CMD ["5"] -> args: ["10"]

## Jobs, Cronjobs --------------------------

### Job
$ kubectl create job nginx --image=nginx 

### CronJob
$ kubectl create cronjob nginx --image=nginx --schedule="* * * * *" 

$ kubectl run crontest --image=busybox --schedule="*/1 * * * *" --restart=OnFailure --dry-run -o yaml > crontest-cron.yml


## Replica Sets (rs) -------------
create: k create -f replicaset-definition-1.yaml
list: kubectl get replicaset
describe: k describe rs <name-rs>
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

k expose deploy webapp-deploy --type=NodePort --name=webapp-svc --target-port=8080  --dry-run -o yaml > webapp-svc.yaml

k create service clusterip my-clusterIp-service --tcp=5678:8080 --dry-run -o yaml

kubectl run httpd --image=httpd:alpine --port=80 --expose

create: `kubectl create -f config/service.yml`

describe: `kubectl describe svc hello-service`

list: `k get svc`

NODE PORT TESTING
* hostname -I // to get ip address of cluster
* k get svc to get nodePort // ex: 30008
* curl 172.17.0.24:30008



## Deployment (deploy) --------------
Create: 

kubectl create deploy webapp --image=kodekloud/webapp-color --replicas=3 --dry-run=client -o yaml > webapp.yaml

kubectl create deploy nginx --image=nginx 

kubectl create deploy redis-deploy --namespace=dev-ns --image=redis --replicas=2

kubectl create deploy nginx -image=nginx --dry-run=client -o yaml > nginx-deployment.yaml

kubectl run nginx --image=nginx --replicas=3 --dry-run -o yaml > nginx-deploy.yml

EDIT
kubectl edit deployment frontend

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

## Config Map (cm) --------------

k create cm time-config -n dvl1987 --from-literal=TIME_FREQ=10 --dry-run-o yaml > time-config.yaml

## Networking (netpol) ---------------

kubectl get networkpolicy

