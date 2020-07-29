# Cheatsheet

## Syntax
kubectl <action> <resourceType> <name> <options>

### Primary commands

kubectl create -f pod_definition_file.yaml

kubectl apply -f pod_definition_file.yaml

## Editing Pods

Output yaml if you don't have one
`kubectl get pod <pod-name> -o yaml > pod-definition.yaml`

Use the edit command to update pod properties. 
`kubectl edit pod <pod-name>`

## actions
CRUD: get, describe, edit, delete

### get
```
get -o yaml: output config to editor
get -o yaml > new-file.yaml: output to file
get -o wide: more detailed
get --all-namespaces
get all
```

### create 
```
-f <filename>: yaml config file
```

### Others
* describe
* edit
* delete

## resourceType
pod: pods

rs: replicasets 

rc: replication-controller (deprecated)

deployments

service

nodes

## name

show in `get` output

## options
--dry-run: only output success/failure

--namespace=<namespace>

## Less common

kubectl scale rs myapp-rs --replicas=5

kubectl run nginx --image=nginx

Set namespace

kubectl config set-context $(kubectl config currentContext) --namespace=dev

## 
Generate POD Manifest YAML file (-o yaml). 

Don't create it(--dry-run)

`kubectl run nginx --image=nginx --restart=Never --dry-run -o yaml`

Generate Deployment YAML file (-o yaml). 

Don't create it(--dry-run)

`kubectl create deployment --image=nginx nginx --dry-run -o yaml > nginx-deployment.yaml`

## Kubernetes commands and argurments

Override in `pod-definiton.yml`

ENTRYPOINT ["sleep"] -> command: ["sleep"]

CMD ["5"] -> args: ["10"]
